---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.WaypointSystem; addon.WaypointSystem = NS

--------------------------------

NS.Script = {}

--------------------------------

function NS.Script:Load()
	--------------------------------
	-- REFERENCES
	--------------------------------

	local Frame = WaypointFrame.Waypoint
	local Frame_Waypoint = Frame.REF_WAYPOINT
	local Frame_Pinpoint = Frame.REF_PINPOINT
	local Frame_BlizzardWaypoint = SuperTrackedFrame
	local Callback = NS.Script; NS.Script = Callback

	--------------------------------
	-- FUNCTIONS (FRAME)
	--------------------------------

	do
		do -- WAYPOINT
			do -- SET
				function Frame_Waypoint:SetContext(image, tintColor)
					Frame.REF_WAYPOINT_CONTEXT:SetInfo(image, tintColor)
				end

				function Frame_Waypoint:SetMarker(tintColor)
					Frame.REF_WAYPOINT_MARKER_BACKGROUND_TEXTURE:SetVertexColor(tintColor.r, tintColor.g, tintColor.b, tintColor.a)
				end

				function Frame_Waypoint:SetText(text, tintColor)
					Frame.REF_WAYPOINT_FOOTER_TEXT:SetText(text)
					Frame.REF_WAYPOINT_FOOTER_TEXT:SetTextColor(tintColor.r, tintColor.g, tintColor.b, 1)
				end

				function Frame_Waypoint:SetInfo(text, contextImage, tintColor)
					Frame_Waypoint:SetContext(contextImage, tintColor)
					Frame_Waypoint:SetText(text, tintColor)
					Frame_Waypoint:SetMarker(tintColor)
				end
			end

			do -- LOGIC

			end
		end

		do -- PINPOINT
			do -- SET
				function Frame_Pinpoint:Background_SetContext(image, tintColor)
					Frame.REF_PINPOINT_BACKGROUND_CONTEXT:SetInfo(image, tintColor)
				end

				function Frame_Pinpoint:Foreground_SetText(text, tintColor)
					Frame.REF_PINPOINT_FOREGROUND_TEXT:SetText(text)
					Frame.REF_PINPOINT_FOREGROUND_BACKGROUND_TEXTURE:SetVertexColor(tintColor.r, tintColor.g, tintColor.b, 1)
				end

				function Frame_Pinpoint:SetInfo(text, contextImage, tintColor)
					Frame_Pinpoint:Background_SetContext(contextImage, tintColor)
					Frame_Pinpoint:Foreground_SetText(text, tintColor)
				end
			end

			do -- LOGIC

			end
		end
	end

	--------------------------------
	-- FUNCTIONS (MAIN)
	--------------------------------

	do
		do -- 3D
			---@param framePosX number
			---@param framePosY number
			---@param screenWidth number
			---@param screenHeight number
			---@param horizontalDistance number
			---@param elevationDiff number
			---@param fov number
			function Callback:GetPerspectiveRotation(framePosX, framePosY, screenWidth, screenHeight, horizontalDistance, elevationDiff, fov)
				local fovRad       = math.rad(fov)
				local f            = (screenWidth * 0.5) / math.tan(fovRad * 0.5)

				local ratio        = elevationDiff / horizontalDistance
				local centerX      = screenWidth * 0.5
				local centerY      = screenHeight * 0.5
				local dx           = framePosX - centerX
				local dy           = framePosY - centerY

				local yawFromPixel = math.atan(dx / f)
				local scaledYaw    = yawFromPixel * (horizontalDistance / (horizontalDistance + f)) * (ratio / 1 * 1.625)

				return -scaledYaw
			end

			---@param distance number Distance from camera to object.
			---@param referenceDistance number Reference distance for referenceScale.
			---@param referenceScale number Desired scale at referenceDistance.
			---@param minScale number Absolute minimum scale.
			---@param maxScale number Absolute maximum scale.
			---@param exponent number Controls falloff curve (default = 1).
			function Callback:GetDistanceScale(distance, referenceDistance, referenceScale, minScale, maxScale, exponent)
				local distance = distance
				local referenceDistance = referenceDistance
				local baselineScale = referenceScale
				local minScale = minScale
				local maxScale = maxScale
				local exponent = exponent or 1

				--------------------------------

				if distance <= 0 then
					return maxScale
				end

				local rawScale = baselineScale * (referenceDistance / distance) ^ exponent

				if rawScale < minScale then
					return minScale
				elseif rawScale > maxScale then
					return maxScale
				else
					return rawScale
				end
			end

			function Callback:GetSuperTrackedMapElement()
				for i = 1, WorldMapFrame.ScrollContainer.Child:GetNumChildren() do
					local element = select(i, WorldMapFrame.ScrollContainer.Child:GetChildren())

					--------------------------------

					if element.selected == true or element.superTracked == true or element.isSuperTracked == true then
						return element
					end
				end
			end

			function Callback:GetSuperTrackedPosition()
				local result = {
					mapID = nil,
					normalizedX = nil,
					normalizedY = nil,
					continentID = nil,
					worldPos = nil,
				}

				--------------------------------

				local superTrackedMapElement = Callback:GetSuperTrackedMapElement()
				local mapID = C_Map.GetBestMapForUnit("player")

				if superTrackedMapElement then
					result.normalizedX, result.normalizedY = superTrackedMapElement.normalizedX, superTrackedMapElement.normalizedY
					result.continentID, result.worldPos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(result.normalizedX, result.normalizedY))
				end

				--------------------------------

				return result
			end

			function Callback:GetDistance2D()
				local mapID = C_Map.GetBestMapForUnit("player")
				local pinInfo = Callback:GetSuperTrackedPosition()
				local _, playerWorldPos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(C_Map.GetPlayerMapPosition(mapID, "player").x, C_Map.GetPlayerMapPosition(mapID, "player").y))

				local dx = pinInfo.worldPos.x - playerWorldPos.x
				local dy = pinInfo.worldPos.y - playerWorldPos.y
				local distance = math.sqrt(dx * dx + dy * dy)

				return distance
			end

			function Callback:GetElevation()
				local d3 = C_Navigation.GetDistance()
				local d2 = Callback:GetDistance2D()
				local elevation = math.sqrt(d3 * d3 - d2 * d2)

				return elevation
			end
		end

		do -- GET
			function Callback:GetSuperTrackingInfo()
				local superTrackingInfo = {
					["valid"] = C_SuperTrack.IsSuperTrackingAnything(),
					["type"] = C_SuperTrack.GetHighestPrioritySuperTrackingType(),
					["texture"] = tostring(Frame_BlizzardWaypoint.Icon:GetTexture()),
				}

				return superTrackingInfo
			end

			function Callback:GetContextIcon_Quest(questID)
				local contextIconInfo = {
					["string"] = nil,
					["texture"] = nil,
				}

				--------------------------------

				contextIconInfo.string, contextIconInfo.texture = addon.ContextIcon.Script:GetContextIcon(nil, nil, questID)

				--------------------------------

				return contextIconInfo
			end

			function Callback:GetContextIcon_Pin()
				local texture = {
					["type"] = nil,
					["path"] = nil
				}

				--------------------------------

				local pinInfo = Callback:GetPinInfo()
				local isWay = WaypointUI_IsWay()

				if pinInfo.pinType then
					if pinInfo.poiInfo and pinInfo.poiInfo.atlasName then
						texture.type = "ATLAS"
						texture.recolor = true
						texture.path = pinInfo.poiInfo.atlasName
					elseif isWay then
						texture.type = "TEXTURE"
						texture.recolor = false
						texture.path = addon.CREF:GetAddonPath() .. "Art/ContextIcons/map-pin-way.png"
					elseif pinInfo.pinType == Enum.SuperTrackingType.UserWaypoint then
						texture.type = "TEXTURE"
						texture.recolor = false
						texture.path = addon.CREF:GetAddonPath() .. "Art/ContextIcons/map-pin-default.png"
					elseif pinInfo.poiType == Enum.SuperTrackingMapPinType.TaxiNode then
						texture.type = "ATLAS"
						texture.recolor = true
						texture.path = "Crosshair_Taxi_128"
					elseif pinInfo.poiType == Enum.SuperTrackingMapPinType.DigSite then
						texture.type = "ATLAS"
						texture.recolor = true
						texture.path = "ArchBlob"
					elseif pinInfo.poiType == Enum.SuperTrackingMapPinType.QuestOffer then
						texture.type = "TEXTURE"
						texture.recolor = true
						texture.path = addon.CREF:GetAddonPath() .. "Art/ContextIcons/quest-available.png"
					else
						texture.type = "TEXTURE"
						texture.recolor = false
						texture.path = addon.CREF:GetAddonPath() .. "Art/ContextIcons/map-pin-default.png"
					end
				end

				--------------------------------

				return texture
			end

			function Callback:GetContextIcon_Redirect(questID)
				local texture = nil

				--------------------------------

				if questID then
					local questClassification = C_QuestInfoSystem.GetQuestClassification(questID)
					local questComplete = C_QuestLog.IsComplete(questID)

					--------------------------------

					if questComplete then
						if questClassification == Enum.QuestClassification.Recurring then
							texture = addon.CREF:GetAddonPath() .. "Art/ContextIcons/redirect-repeatable.png"
						elseif questClassification == Enum.QuestClassification.Important then
							texture = addon.CREF:GetAddonPath() .. "Art/ContextIcons/redirect-important.png"
						else
							texture = addon.CREF:GetAddonPath() .. "Art/ContextIcons/redirect-default.png"
						end
					else
						texture = addon.CREF:GetAddonPath() .. "Art/ContextIcons/redirect-incomplete.png"
					end
				else
					texture = addon.CREF:GetAddonPath() .. "Art/ContextIcons/redirect-neutral.png"
				end

				--------------------------------

				return texture
			end

			function Callback:GetTint(questID)
				local tint = nil

				--------------------------------

				if questID then
					local questClassification = C_QuestInfoSystem.GetQuestClassification(questID)
					local questComplete = C_QuestLog.IsComplete(questID)

					--------------------------------

					if questComplete then
						if questClassification == Enum.QuestClassification.Recurring then
							tint = addon.CREF:GetSharedColor().RGB_PING_QUEST_REPEATABLE
						elseif questClassification == Enum.QuestClassification.Important then
							tint = addon.CREF:GetSharedColor().RGB_PING_QUEST_IMPORTANT
						else
							tint = addon.CREF:GetSharedColor().RGB_PING_QUEST_NORMAL
						end
					else
						tint = addon.CREF:GetSharedColor().RGB_PING_QUEST_NEUTRAL
					end
				else
					tint = { r = addon.CREF:GetSharedColor().RGB_PING_NEUTRAL.r, g = addon.CREF:GetSharedColor().RGB_PING_NEUTRAL.g, b = addon.CREF:GetSharedColor().RGB_PING_NEUTRAL.b, a = 1 }
				end

				--------------------------------

				return tint
			end

			--------------------------------

			function Callback:GetQuestInfo()
				local SUPER_TRACK_INFO = Callback:GetSuperTrackingInfo()

				--------------------------------

				local questInfo = {
					["questID"] = C_SuperTrack.GetSuperTrackedQuestID(),
					["completed"] = nil,
					["contextIcon"] = nil,
					["objectiveInfo"] = {
						["objectives"] = nil,
						["objectiveIndex"] = 1,
						["isMultiObjective"] = nil,
					},
				}
				local isQuest = (SUPER_TRACK_INFO.type == Enum.SuperTrackingType.Quest and questInfo.questID)
				local isQuestComplete = (isQuest) and (C_QuestLog.IsComplete(questInfo.questID))
				local isWorldQuest = (isQuest) and (C_TaskQuest.GetQuestInfoByQuestID(questInfo.questID))

				if isQuest and not isWorldQuest then
					questInfo.completed = isQuestComplete
					questInfo.contextIcon = Callback:GetContextIcon_Quest(questInfo.questID)

					--------------------------------

					if not isQuestComplete then
						questInfo.objectiveInfo.objectives = C_QuestLog.GetQuestObjectives(questInfo.questID)
						questInfo.objectiveInfo.isMultiObjective = (questInfo.objectiveInfo.objectives and #questInfo.objectiveInfo.objectives > 1)

						if questInfo.objectiveInfo.objectives then
							for i, objective in ipairs(questInfo.objectiveInfo.objectives) do
								if objective.finished then
									if i < #questInfo.objectiveInfo.objectives then
										questInfo.objectiveInfo.objectiveIndex = i + 1
									else
										questInfo.completed = true
									end
								end
							end
						end
					end

					--------------------------------

					return questInfo
				else
					return nil
				end
			end

			function Callback:GetPinInfo()
				local pinInfo = nil

				--------------------------------

				local pinType = C_SuperTrack.GetHighestPrioritySuperTrackingType() -- Super tracking type
				local poiType, poiID = C_SuperTrack.GetSuperTrackedMapPin()  -- AreaPOI, QuestOffer, TaxiNode, DigSite
				local trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent() -- Appearance, Mount, Achievement

				local poiInfo = poiID and C_AreaPoiInfo.GetAreaPOIInfo(nil, poiID)
				local pinName, pinDescription = C_SuperTrack.GetSuperTrackedItemName() -- Name of super tracked (e.g. The Stockades)
				local isWay = WaypointUI_IsWay()

				pinInfo = {
					["isWay"] = isWay,
					["pinType"] = pinType,
					["poiType"] = poiType,
					["poiID"] = poiID,
					["trackableType"] = trackableType,
					["trackableID"] = trackableID,
					["poiInfo"] = poiInfo,
					["pinName"] = pinName,
					["pinDescription"] = pinDescription,
				}

				--------------------------------

				return pinInfo
			end

			function Callback:GetCurrentState()
				local CONFIG_WS_DISTANCE_TRANSITION = addon.C.Database.Variables.DB_GLOBAL.profile.WS_DISTANCE_TRANSITION
				local CONFIG_WS_DISTANCE_HIDE = addon.C.Database.Variables.DB_GLOBAL.profile.WS_DISTANCE_HIDE

				--------------------------------

				local SUPER_TRACK_INFO = Callback:GetSuperTrackingInfo()
				local QUEST_INFO = Callback:GetQuestInfo()

				--------------------------------

				local state = nil

				local distance = C_Navigation.GetDistance()
				local isInInstance = (IsInInstance())
				local isQuest = (QUEST_INFO ~= nil)
				local isValid = (SUPER_TRACK_INFO.valid)
				local isDefault = (SUPER_TRACK_INFO.texture == "3308452")
				local isPin = (SUPER_TRACK_INFO.texture == "3500068")
				local isRangeProximity = (distance < CONFIG_WS_DISTANCE_TRANSITION)
				local isRangeValid = (distance > CONFIG_WS_DISTANCE_HIDE)

				if (isInInstance) or (not isRangeValid) or (not isValid) then
					if not isRangeValid then
						state = "INVALID_RANGE"
					else
						state = "INVALID"
					end
				elseif isRangeProximity then
					if isQuest and isDefault then
						state = "QUEST_PROXIMITY"
					else
						state = "PROXIMITY"
					end
				else
					if isQuest and isDefault then
						state = "QUEST_AREA"
					else
						state = "AREA"
					end
				end

				--------------------------------

				return state
			end

			function Callback:GetIsClamped()
				return Frame_BlizzardWaypoint.isClamped
			end
		end

		do -- SET
			do -- GENERAL
				function Callback:Blizzard_Hide()
					Frame_BlizzardWaypoint.Icon:SetAlpha(0)
					Frame_BlizzardWaypoint.DistanceText:SetAlpha(0)
					Frame_BlizzardWaypoint.Arrow:SetAlpha(0)
				end

				function Callback:Blizzard_Show()
					Frame_BlizzardWaypoint.Icon:SetAlpha(1)
					Frame_BlizzardWaypoint.DistanceText:SetAlpha(1)
					Frame_BlizzardWaypoint.Arrow:SetAlpha(1)
				end

				function Callback:Waypoint_Reset(keepElementState)
					if not keepElementState then
						Frame_Waypoint.hidden = true
						Frame_Waypoint:Hide()

						Frame_Pinpoint.hidden = true
						Frame_Pinpoint:Hide()
					end

					--------------------------------

					NS.Variables.Session = {
						["isInInstance"] = nil,
						["state"] = nil,
						["lastState"] = nil,
						["id"] = nil,
						["quest"] = nil,
						["questContextIcon"] = nil
					}
				end

				function Callback:Waypoint_Hide()
					Frame:Hide()
				end

				function Callback:Waypoint_Show()
					Frame.Waypoint:SetPoint("CENTER", Frame_BlizzardWaypoint.navFrame)
					Frame.Pinpoint:SetPoint("BOTTOM", Frame_BlizzardWaypoint.navFrame, "TOP", 0, 75)
					Frame:Show()
				end
			end

			do -- WAYPOINT
				function Callback:Waypoint_Context_Show()
					Frame.REF_WAYPOINT_CONTEXT:Show()
				end

				function Callback:Waypoint_Context_Hide()
					Frame.REF_WAYPOINT_CONTEXT:Hide()
				end

				function Callback:Waypoint_SetTint(tintColor)
					Frame.REF_WAYPOINT_MARKER_BACKGROUND_TEXTURE:SetVertexColor(tintColor.r, tintColor.g, tintColor.b, tintColor.a)
					Frame.REF_WAYPOINT_FOOTER_TEXT:SetTextColor(tintColor.r, tintColor.g, tintColor.b, tintColor.a)
				end

				function Callback:Waypoint_SetDistanceText(text)
					Frame.REF_WAYPOINT_FOOTER_TEXT:SetText(text)
				end

				function Callback:Waypoint_SetContext(image, tintColor, opacity)
					Frame.REF_WAYPOINT_CONTEXT:SetInfo(image, tintColor, opacity)
				end

				function Callback:Waypoint_SetContextVFX(type)
					if type == "QuestCompletion" then
						Frame.REF_WAYPOINT_CONTEXT_VFX_QUEST_COMPLETION:Show()
					else
						Frame.REF_WAYPOINT_CONTEXT_VFX_QUEST_COMPLETION:Hide()
					end
				end

				function Callback:Waypoint_SetType(type)
					if type == "WAYPOINT" then
						Frame.REF_WAYPOINT_CONTEXT:Hide()

						Frame.REF_WAYPOINT_MARKER:ClearAllPoints()
						Frame.REF_WAYPOINT_MARKER:SetPoint("BOTTOM", Frame.REF_WAYPOINT, "TOP", 0, -37.5)

						Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME:ClearAllPoints()
						Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME:SetPoint("CENTER", Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME:GetParent(), 0, 7.5)
					elseif type == "CONTEXT" then
						Frame.REF_WAYPOINT_CONTEXT:Show()

						Frame.REF_WAYPOINT_MARKER:ClearAllPoints()
						Frame.REF_WAYPOINT_MARKER:SetPoint("BOTTOM", Frame.REF_WAYPOINT_CONTEXT, "TOP", 0, -25)

						Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME:ClearAllPoints()
						Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME:SetPoint("CENTER", Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME:GetParent(), 0, 0)
					end
				end
			end

			do -- PINPOINT
				function Callback:Pinpoint_SetText(text)
					if text then
						Frame.REF_PINPOINT_FOREGROUND_TEXT:SetText(text)
					end

					--------------------------------

					Frame.REF_PINPOINT_FOREGROUND:SetShown(text ~= nil)
				end

				function Callback:Pinpoint_SetTint(tintColor)
					Frame.REF_PINPOINT_BACKGROUND_ARROW:SetTint(tintColor)
					Frame.REF_PINPOINT_FOREGROUND_BACKGROUND_BORDER_TEXTURE:SetVertexColor(tintColor.r, tintColor.g, tintColor.b, tintColor.a)
					Frame.REF_PINPOINT_FOREGROUND_TEXT:SetVertexColor(tintColor.r, tintColor.g, tintColor.b, tintColor.a)
				end

				function Callback:Pinpoint_SetContext(image, tintColor, opacity)
					Frame.REF_PINPOINT_BACKGROUND_CONTEXT:SetInfo(image, tintColor, opacity)
				end
			end
		end

		do -- LOGIC
			local function Transition_Pinpoint(id)
				if not Frame_Waypoint.hidden then
					Frame_Waypoint:HideWithAnimation(id).onFinish(function()
						Frame_Pinpoint:ShowWithAnimation(id, false)
					end)

					--------------------------------

					addon.C.Sound.Script:PlaySound(SOUNDKIT.UI_RUNECARVING_CLOSE_MAIN_WINDOW)
				else
					Frame_Pinpoint:ShowWithAnimation(id, false)
				end
			end

			local function Transition_Waypoint(id)
				if not Frame_Pinpoint.hidden then
					Frame_Pinpoint:HideWithAnimation(id).onFinish(function()
						Frame_Waypoint:ShowWithAnimation(id, false)
					end)


					--------------------------------

					addon.C.Sound.Script:PlaySound(SOUNDKIT.UI_RUNECARVING_OPEN_MAIN_WINDOW)
				else
					Frame_Waypoint:ShowWithAnimation(id, false)
				end
			end

			local function Transition_OnlyPinpoint(id)
				if Frame_Pinpoint.hidden then
					Frame_Pinpoint:ShowWithAnimation(id, false)
				end

				if not Frame_Waypoint.hidden then
					Frame_Waypoint:HideWithAnimation(id, false)

					--------------------------------

					addon.C.Sound.Script:PlaySound(SOUNDKIT.UI_RUNECARVING_CLOSE_MAIN_WINDOW)
				end
			end

			local function Transition_OnlyWaypoint(id)
				if not Frame_Pinpoint.hidden then
					Frame_Pinpoint:HideWithAnimation(id, false)
				end

				if Frame_Waypoint.hidden then
					Frame_Waypoint:ShowWithAnimation(id, false)

					--------------------------------

					addon.C.Sound.Script:PlaySound(SOUNDKIT.UI_RUNECARVING_OPEN_MAIN_WINDOW)
				end
			end

			--------------------------------

			function Callback:UpdateStateSession(currentState)
				local id = nil
				local isNewState = nil

				--------------------------------

				if NS.Variables.Session.lastState ~= currentState then
					id = addon.C.API.Util:gen_hash()
					isNewState = true
				else
					id = NS.Variables.Session.id
					isNewState = false
				end

				--------------------------------

				return id, isNewState
			end

			function Callback:Update(isNewWaypoint)
				if isNewWaypoint then
					Callback:Waypoint_Reset()

					--------------------------------

					addon.C.Sound.Script:PlaySound(31583)
				end

				--------------------------------
				-- REFERENCES
				--------------------------------

				local CONFIG_WS_TYPE = addon.C.Database.Variables.DB_GLOBAL.profile.WS_TYPE
				local CONFIG_WS_PINPOINT_DETAIL = addon.C.Database.Variables.DB_GLOBAL.profile.WS_PINPOINT_DETAIL
				local CVAR_FOV = GetCVar("cameraFov")

				--------------------------------
				-- VARIABLES
				--------------------------------

				local SUPER_TRACKING_INFO = Callback:GetSuperTrackingInfo()
				local QUEST_INFO = Callback:GetQuestInfo()

				local STATE = Callback:GetCurrentState()
				local ID, IS_NEW_STATE = Callback:UpdateStateSession(STATE)
				local IS_QUEST = (QUEST_INFO ~= nil)
				local IS_CLAMPED = Callback:GetIsClamped()
				local TINT_COLOR = Callback:GetTint(QUEST_INFO and QUEST_INFO.questID)

				--------------------------------
				-- 3D
				--------------------------------

				local DISTANCE = C_Navigation.GetDistance()
				local WAYPOINT_3D_MODIFIER_SCALE = Callback:GetDistanceScale(DISTANCE, 2000, .25, .25, 1.5, 1)
				Frame.REF_WAYPOINT_CONTENT:SetScale(WAYPOINT_3D_MODIFIER_SCALE)

				-- local DISTANCE_2D = Callback:GetDistance2D()
				-- local ELEVATION = Callback:GetElevation()
				-- local WAYPOINT_3D_MODIFIER_ROTATION = Callback:GetPerspectiveRotation(SuperTrackedFrame:GetLeft() or 0, SuperTrackedFrame:GetTop() or 0, GetScreenWidth(), GetScreenHeight(), DISTANCE_2D, ELEVATION, CVAR_FOV)
				-- Frame.REF_WAYPOINT_MARKER_BACKGROUND_TEXTURE:SetRotation(WAYPOINT_3D_MODIFIER_ROTATION)

				--------------------------------
				-- SET
				--------------------------------

				NS.Variables.Session = {
					["lastInInstance"] = IsInInstance(),
					["state"] = STATE,
					["lastState"] = NS.Variables.Session.lastState,
					["id"] = ID,
					["questInfo"] = QUEST_INFO,
				}

				NS.Variables.Session.lastState = STATE

				if STATE == "INVALID" or STATE == "INVALID_RANGE" then
					if IS_NEW_STATE and STATE == "INVALID_RANGE" then
						if not Frame_Waypoint.hidden then
							Frame_Waypoint:HideWithAnimation(ID, false)
						end

						if not Frame_Pinpoint.hidden then
							Frame_Pinpoint:HideWithAnimation(ID, false)
						end
					end

					--------------------------------

					Callback:Blizzard_Hide()

					--------------------------------

					return
				else
					if IS_CLAMPED then
						Callback:Waypoint_Hide()
						Callback:Blizzard_Hide()
					else
						Callback:Waypoint_Show()
						Callback:Blizzard_Hide()
					end

					--------------------------------

					if STATE == "QUEST_PROXIMITY" then
						if IS_NEW_STATE then
							if CONFIG_WS_TYPE == 1 then -- Both
								Transition_Pinpoint(ID)
							end

							if CONFIG_WS_TYPE == 2 then -- Waypoint
								Transition_OnlyWaypoint(ID)
							end

							if CONFIG_WS_TYPE == 3 then -- Pinpoint
								Transition_OnlyPinpoint(ID)
							end
						end
					elseif STATE == "PROXIMITY" then
						if IS_NEW_STATE then
							if CONFIG_WS_TYPE == 1 then -- Both
								Transition_Pinpoint(ID)
							end

							if CONFIG_WS_TYPE == 2 then -- Waypoint
								Transition_OnlyWaypoint(ID)
							end

							if CONFIG_WS_TYPE == 3 then -- Pinpoint
								Transition_OnlyPinpoint(ID)
							end
						end
					elseif STATE == "QUEST_AREA" then
						if IS_NEW_STATE then
							if CONFIG_WS_TYPE == 1 then -- Both
								Transition_Waypoint(ID)
							end

							if CONFIG_WS_TYPE == 2 then -- Waypoint
								Transition_OnlyWaypoint(ID)
							end

							if CONFIG_WS_TYPE == 3 then -- Pinpoint
								Transition_OnlyPinpoint(ID)
							end
						end
					elseif STATE == "AREA" then
						if IS_NEW_STATE then
							if CONFIG_WS_TYPE == 1 then -- Both
								Transition_Waypoint(ID)
							end

							if CONFIG_WS_TYPE == 2 then -- Waypoint
								Transition_OnlyWaypoint(ID)
							end

							if CONFIG_WS_TYPE == 3 then -- Pinpoint
								Transition_OnlyPinpoint(ID)
							end
						end
					end

					--------------------------------

					if not Frame_Waypoint.hidden then
						if QUEST_INFO then
							local contextIcon = { type = "TEXTURE", recolor = false, path = QUEST_INFO.contextIcon.texture }
							local currentWaypointObjective = (C_QuestLog.GetNextWaypointText(QUEST_INFO.questID))

							if currentWaypointObjective then
								contextIcon = { type = "TEXTURE", recolor = false, path = Callback:GetContextIcon_Redirect(QUEST_INFO.questID) }
							end

							--------------------------------

							Callback:Waypoint_SetTint(TINT_COLOR)
							Callback:Waypoint_SetContext(contextIcon, TINT_COLOR, 1)
							Callback:Waypoint_SetContextVFX(QUEST_INFO.completed and "QuestCompletion" or "")
							Callback:Waypoint_SetType("CONTEXT")
						else
							local pinInfo = (Callback:GetPinInfo())
							local contextIcon = (Callback:GetContextIcon_Pin())

							--------------------------------

							Callback:Waypoint_SetTint(TINT_COLOR)
							Callback:Waypoint_SetContext(contextIcon, TINT_COLOR, 1)
							Callback:Waypoint_SetContextVFX(nil)
							Callback:Waypoint_SetType("CONTEXT")
						end

						--------------------------------

						Callback:Waypoint_SetDistanceText(L["Distance - Prefix"] .. addon.C.API.Util:FormatNumber(string.format("%.0f", DISTANCE)) .. L["Distance - Suffix"])
					end

					if not Frame_Pinpoint.hidden then
						if QUEST_INFO then
							local text = nil
							local contextIcon = { type = "TEXTURE", recolor = false, path = QUEST_INFO.contextIcon.texture }

							local isComplete = (QUEST_INFO.completed)
							local currentWaypointObjective = (C_QuestLog.GetNextWaypointText(QUEST_INFO.questID))
							local currentQuestObjective = ((QUEST_INFO.objectiveInfo.objectives and #QUEST_INFO.objectiveInfo.objectives >= QUEST_INFO.objectiveInfo.objectiveIndex and QUEST_INFO.objectiveInfo.objectives[QUEST_INFO.objectiveInfo.objectiveIndex].text) or "")
							local questName = (C_QuestLog.GetTitleForQuestID(QUEST_INFO.questID))

							--------------------------------

							if currentWaypointObjective then
								text = currentWaypointObjective
								contextIcon = { type = "TEXTURE", recolor = false, path = Callback:GetContextIcon_Redirect(QUEST_INFO.questID) }
							else
								if isComplete then
									if CONFIG_WS_PINPOINT_DETAIL then
										text = questName .. " — " .. L["WaypointSystem - Pinpoint - Quest - Complete"]
									else
										text = L["WaypointSystem - Pinpoint - Quest - Complete"]
									end
								elseif currentQuestObjective then
									text = currentQuestObjective
								end
							end

							Callback:Pinpoint_SetTint(TINT_COLOR)
							Callback:Pinpoint_SetText(text)
							Callback:Pinpoint_SetContext(contextIcon, TINT_COLOR, .25)
						else
							local text = nil
							local contextIcon = (Callback:GetContextIcon_Pin())

							local pinInfo = (Callback:GetPinInfo())

							--------------------------------

							if pinInfo.isWay then
								local wayInfo = WaypointUI_GetWay()

								--------------------------------

								if #wayInfo.name >= 1 then
									text = wayInfo.name
								else
									text = nil
								end
							elseif pinInfo.pinType == Enum.SuperTrackingType.UserWaypoint then
								text = nil
							else
								if CONFIG_WS_PINPOINT_DETAIL then
									if pinInfo.poiInfo and pinInfo.poiInfo.description and #pinInfo.poiInfo.description > 1 then
										text = pinInfo.pinName .. " — " .. pinInfo.poiInfo.description
									else
										text = pinInfo.pinName
									end
								else
									text = pinInfo.pinName
								end
							end

							Callback:Pinpoint_SetTint(TINT_COLOR)
							Callback:Pinpoint_SetText(text)
							Callback:Pinpoint_SetContext(contextIcon, TINT_COLOR, text and .25 or 1)
						end
					end
				end
			end
		end
	end

	--------------------------------
	-- FUNCTIONS (ANIMATION)
	--------------------------------

	do
		do -- WAYPOINT
			do -- SHOW
				function Frame_Waypoint:ShowWithAnimation_StopEvent(id)
					return NS.Variables.Session.id ~= id
				end

				function Frame_Waypoint:ShowWithAnimation(id, skipAnimation)
					Frame_Waypoint.hidden = false
					Frame_Waypoint:Show()

					--------------------------------

					if skipAnimation then
						Frame.REF_WAYPOINT_CONTEXT:SetScale(1)
						Frame.REF_WAYPOINT_CONTEXT:SetAlpha(1)
						Frame.REF_WAYPOINT_CONTEXT_VFX:SetAlpha(1)
						Frame.REF_WAYPOINT_FOOTER_TEXT:SetPoint("CENTER", Frame.REF_WAYPOINT_FOOTER.TextFrame, 0, 0)
						Frame.REF_WAYPOINT_FOOTER_TEXT:SetAlpha(1)
						Frame.REF_WAYPOINT_MARKER:SetAlpha(1)
					else
						addon.C.Animation:Scale({ ["frame"] = Frame.REF_WAYPOINT_CONTEXT, ["duration"] = .5, ["from"] = 2, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_CONTEXT, ["duration"] = 1, ["from"] = 0, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_CONTEXT_VFX, ["duration"] = 2, ["from"] = 0, ["to"] = 1, ["ease"] = nil, ["stopEvent"] = function() return Frame_Waypoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Translate({ ["frame"] = Frame.REF_WAYPOINT_FOOTER_TEXT, ["duration"] = 1, ["from"] = 15, ["to"] = 0, ["axis"] = "y", ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_FOOTER_TEXT, ["duration"] = .5, ["from"] = 0, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_MARKER, ["duration"] = 1, ["from"] = 0, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:ShowWithAnimation_StopEvent(id) end })
					end

					Frame.REF_WAYPOINT_CONTEXT:ShowWithAnimation(skipAnimation)
				end
			end

			do -- HIDE
				function Frame_Waypoint:HideWithAnimation_StopEvent(id)
					return NS.Variables.Session.id ~= id
				end

				function Frame_Waypoint:HideWithAnimation(id, skipAnimation)
					Frame_Waypoint.hidden = true

					--------------------------------

					local chain = addon.C.API.Util:AddMethodChain({ "onFinish" })

					--------------------------------

					if skipAnimation then
						Frame.REF_WAYPOINT_CONTEXT:SetScale(1.125)
						Frame.REF_WAYPOINT_CONTEXT:SetAlpha(0)
						Frame.REF_WAYPOINT_CONTEXT_VFX:SetAlpha(0)
						Frame.REF_WAYPOINT_FOOTER_TEXT:SetPoint("CENTER", Frame.REF_WAYPOINT_FOOTER_TEXT:GetParent(), 0, 7.5)
						Frame.REF_WAYPOINT_FOOTER_TEXT:SetAlpha(0)
						Frame.REF_WAYPOINT_MARKER:SetAlpha(0)
					else
						addon.C.Animation:Scale({ ["frame"] = Frame.REF_WAYPOINT_CONTEXT, ["duration"] = .5, ["from"] = Frame.REF_WAYPOINT_CONTEXT:GetScale(), ["to"] = 1.5, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_CONTEXT, ["duration"] = .25, ["from"] = Frame.REF_WAYPOINT_CONTEXT:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_CONTEXT_VFX, ["duration"] = .25, ["from"] = Frame.REF_WAYPOINT_CONTEXT_VFX:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Translate({ ["frame"] = Frame.REF_WAYPOINT_FOOTER_TEXT, ["duration"] = .25, ["from"] = 0, ["to"] = 5, ["axis"] = "y", ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_FOOTER_TEXT, ["duration"] = .25, ["from"] = Frame.REF_WAYPOINT_FOOTER_TEXT:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_WAYPOINT_MARKER, ["duration"] = .125, ["from"] = Frame.REF_WAYPOINT_MARKER:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Waypoint:HideWithAnimation_StopEvent(id) end })
					end

					--------------------------------

					if skipAnimation then
						Frame_Waypoint:Hide()

						--------------------------------

						if chain.onFinish.variable then
							chain.onFinish.variable()
						end
					else
						addon.C.Libraries.AceTimer:ScheduleTimer(function()
							if not Frame_Waypoint:HideWithAnimation_StopEvent(id) then
								Frame_Waypoint:Hide()

								--------------------------------

								if chain.onFinish.variable then
									chain.onFinish.variable()
								end
							end
						end, .25)
					end

					---------------------------------

					return { onFinish = chain.onFinish.set }
				end
			end
		end

		do -- PINPOINT
			do -- SHOW
				function Frame_Pinpoint:ShowWithAnimation_StopEvent(id)
					return NS.Variables.Session.id ~= id
				end

				function Frame_Pinpoint:ShowWithAnimation(id, skipAnimation)
					Frame_Pinpoint.hidden = false
					Frame_Pinpoint:Show()

					--------------------------------

					if skipAnimation then
						Frame.REF_PINPOINT_BACKGROUND_CONTEXT:SetScale(1)
						Frame.REF_PINPOINT_BACKGROUND_CONTEXT:SetAlpha(1)
						Frame.REF_PINPOINT_BACKGROUND_ARROW:SetAlpha(1)
						Frame.REF_PINPOINT_FOREGROUND:SetPoint("CENTER", Frame.REF_PINPOINT_FOREGROUND:GetParent(), 0, 0)
						Frame.REF_PINPOINT_FOREGROUND:SetAlpha(1)
					else
						addon.C.Animation:Scale({ ["frame"] = Frame.REF_PINPOINT_BACKGROUND_CONTEXT, ["duration"] = .75, ["from"] = 3, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_PINPOINT_BACKGROUND_CONTEXT, ["duration"] = .75, ["from"] = 0, ["to"] = .25, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_PINPOINT_BACKGROUND_ARROW, ["duration"] = .25, ["from"] = 0, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Translate({ ["frame"] = Frame.REF_PINPOINT_FOREGROUND, ["duration"] = .75, ["from"] = -15, ["to"] = 0, ["axis"] = "y", ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:ShowWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_PINPOINT_FOREGROUND, ["duration"] = .5, ["from"] = 0, ["to"] = 1, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:ShowWithAnimation_StopEvent(id) end })
					end

					Frame.REF_PINPOINT_BACKGROUND_CONTEXT:ShowWithAnimation(skipAnimation)
					Frame.REF_PINPOINT_BACKGROUND_ARROW:Animation_Playback_Start()
				end
			end

			do -- HIDE
				function Frame_Pinpoint:HideWithAnimation_StopEvent(id)
					return NS.Variables.Session.id ~= id
				end

				function Frame_Pinpoint:HideWithAnimation(id, skipAnimation)
					Frame_Pinpoint.hidden = true

					--------------------------------

					local chain = addon.C.API.Util:AddMethodChain({ "onFinish" })

					--------------------------------

					if skipAnimation then
						Frame.REF_PINPOINT_BACKGROUND_CONTEXT:SetScale(1.125)
						Frame.REF_PINPOINT_BACKGROUND_CONTEXT:SetAlpha(0)
						Frame.REF_PINPOINT_BACKGROUND_ARROW:SetAlpha(0)
						Frame.REF_PINPOINT_FOREGROUND:SetPoint("CENTER", Frame.REF_PINPOINT_FOREGROUND:GetParent(), 0, 7.5)
						Frame.REF_PINPOINT_FOREGROUND:SetAlpha(0)
					else
						addon.C.Animation:Scale({ ["frame"] = Frame.REF_PINPOINT_BACKGROUND_CONTEXT, ["duration"] = .5, ["from"] = Frame.REF_PINPOINT_BACKGROUND_CONTEXT:GetScale(), ["to"] = 2, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_PINPOINT_BACKGROUND_CONTEXT, ["duration"] = .5, ["from"] = Frame.REF_PINPOINT_BACKGROUND_CONTEXT:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_PINPOINT_BACKGROUND_ARROW, ["duration"] = .5, ["from"] = Frame.REF_PINPOINT_BACKGROUND_ARROW:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Translate({ ["frame"] = Frame.REF_PINPOINT_FOREGROUND, ["duration"] = .5, ["from"] = 0, ["to"] = -15, ["axis"] = "y", ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:HideWithAnimation_StopEvent(id) end })
						addon.C.Animation:Alpha({ ["frame"] = Frame.REF_PINPOINT_FOREGROUND, ["duration"] = .5, ["from"] = Frame.REF_PINPOINT_FOREGROUND:GetAlpha(), ["to"] = 0, ["ease"] = "EaseExpo", ["stopEvent"] = function() return Frame_Pinpoint:HideWithAnimation_StopEvent(id) end })
					end

					--------------------------------

					if skipAnimation then
						Frame_Pinpoint:Hide()

						--------------------------------

						if chain.onFinish.variable then
							chain.onFinish.variable()
						end
					else
						addon.C.Libraries.AceTimer:ScheduleTimer(function()
							if not Frame_Pinpoint:HideWithAnimation_StopEvent(id) then
								Frame_Pinpoint:Hide()

								--------------------------------

								if chain.onFinish.variable then
									chain.onFinish.variable()
								end
							end
						end, .25)
					end

					---------------------------------

					return { onFinish = chain.onFinish.set }
				end
			end
		end
	end

	--------------------------------
	-- SETTINGS
	--------------------------------

	do
		local function CONFIG_WAYPOINT_SCALE()
			local variable = addon.C.Database.Variables.DB_GLOBAL.profile.WS_WAYPOINT_SCALE
			Frame_Waypoint:SetScale(variable)
		end

		local function CONFIG_PINPOINT_SCALE()
			local variable = addon.C.Database.Variables.DB_GLOBAL.profile.WS_PINPOINT_SCALE
			Frame_Pinpoint:SetScale(variable)
		end

		local function CONFIG_WS_TYPE()
			Callback:Waypoint_Reset(true)
		end

		CONFIG_WAYPOINT_SCALE()
		CONFIG_PINPOINT_SCALE()
		CONFIG_WS_TYPE()

		--------------------------------

		CallbackRegistry:Add("CONFIG_WAYPOINT_SCALE", CONFIG_WAYPOINT_SCALE)
		CallbackRegistry:Add("CONFIG_PINPOINT_SCALE", CONFIG_PINPOINT_SCALE)
		CallbackRegistry:Add("CONFIG_WS_TYPE", CONFIG_WS_TYPE)
	end

	--------------------------------
	-- EVENTS
	--------------------------------

	do
		local _ = CreateFrame("Frame")
		_:RegisterEvent("SUPER_TRACKING_CHANGED")
		_:RegisterEvent("SUPER_TRACKING_PATH_UPDATED")
		_:SetScript("OnUpdate", function()
			Callback:Update(false)
		end)
		_:SetScript("OnEvent", function(_, event)
			if event == "SUPER_TRACKING_CHANGED" then
				Callback:Update(true)
			end
		end)
	end
end
