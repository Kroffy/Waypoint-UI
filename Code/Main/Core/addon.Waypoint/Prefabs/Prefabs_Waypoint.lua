---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.Waypoint; addon.Waypoint = NS

--------------------------------

NS.Prefabs = {}

--------------------------------
-- PREFABS
--------------------------------

function NS.Prefabs:Load()
	do -- GENERAL
		do -- CONTEXT FRAME
			local PADDING = NS.Variables.PADDING

			--------------------------------

			PrefabRegistry:Add("Waypoint.General.ContextFrame", function(parent, frameStrata, frameLevel, name)
				local Frame = CreateFrame("Frame", name, parent)
				Frame:SetFrameStrata(frameStrata)
				Frame:SetFrameLevel(frameLevel)

				--------------------------------

				do -- ELEMENTS
					do -- BACKGROUND
						Frame.Background = CreateFrame("Frame", "$parent.Background", Frame)
						Frame.Background:SetPoint("CENTER", Frame)
						Frame.Background:SetFrameStrata(frameStrata)
						Frame.Background:SetFrameLevel(frameLevel + 1)
						addon.C.API.FrameUtil:SetDynamicSize(Frame.Background, Frame, 0, 0)

						local Background = Frame.Background

						--------------------------------

						do -- FOREGROUND
							Background.Foreground, Background.ForegroundTexture = addon.C.FrameTemplates:CreateTexture(Frame, frameStrata, NS.Variables.PATH .. "waypoint-context.png", "$parent.Foreground")
							Background.Foreground:SetPoint("CENTER", Frame)
							Background.Foreground:SetFrameStrata(frameStrata)
							Background.Foreground:SetFrameLevel(frameLevel + 3)
							addon.C.API.FrameUtil:SetDynamicSize(Background.Foreground, Background, 0, 0)
						end

						do -- BACKGROUND
							Background.Background, Background.BackgroundTexture = addon.C.FrameTemplates:CreateTexture(Frame, frameStrata, NS.Variables.PATH .. "waypoint-context-background.png", "$parent.Background")
							Background.Background:SetPoint("CENTER", Frame)
							Background.Background:SetFrameStrata(frameStrata)
							Background.Background:SetFrameLevel(frameLevel + 2)
							addon.C.API.FrameUtil:SetDynamicSize(Background.Background, Background, -12.5, -12.5)
						end
					end

					do -- CONTENT
						Frame.Content = CreateFrame("Frame", "$parent.Content", Frame)
						Frame.Content:SetPoint("CENTER", Frame)
						Frame.Content:SetFrameStrata(frameStrata)
						Frame.Content:SetFrameLevel(frameLevel + 4)
						addon.C.API.FrameUtil:SetDynamicSize(Frame.Content, Frame, function(relativeWidth, relativeHeight) return relativeHeight * .5 end, function(relativeWidth, relativeHeight) return relativeHeight * .5 end)

						local Content = Frame.Content

						--------------------------------

						do -- IMAGE FRAME
							Content.ImageFrame = CreateFrame("Frame", "$parent.ImageFrame", Content)
							Content.ImageFrame:SetPoint("CENTER", Content)
							Content.ImageFrame:SetFrameStrata(frameStrata)
							Content.ImageFrame:SetFrameLevel(frameLevel + 5)
							addon.C.API.FrameUtil:SetDynamicSize(Content.ImageFrame, Content, 0, 0)

							local ImageFrame = Content.ImageFrame

							--------------------------------

							do -- BACKGROUND
								ImageFrame.Background, ImageFrame.BackgroundTexture = addon.C.FrameTemplates:CreateTexture(ImageFrame, frameStrata, nil, "$parent.Background")
								ImageFrame.Background:SetPoint("CENTER", ImageFrame)
								ImageFrame.Background:SetFrameStrata(frameStrata)
								ImageFrame.Background:SetFrameLevel(frameLevel + 6)
								addon.C.API.FrameUtil:SetDynamicSize(ImageFrame.Background, ImageFrame, 0, 0)
							end
						end
					end
				end

				do -- REFERENCES
					-- CORE
					Frame.REF_BACKGROUND = Frame.Background
					Frame.REF_CONTENT = Frame.Content

					-- BACKGROUND
					Frame.REF_BACKGROUND_FOREGROUND = Frame.REF_BACKGROUND.Foreground
					Frame.REF_BACKGROUND_FOREGROUND_TEXTURE = Frame.REF_BACKGROUND.ForegroundTexture
					Frame.REF_BACKGROUND_BACKGROUND = Frame.REF_BACKGROUND.Background
					Frame.REF_BACKGROUND_BACKGROUND_TEXTURE = Frame.REF_BACKGROUND.BackgroundTexture

					-- CONTENT
					Frame.REF_CONTENT_IMAGE = Frame.REF_CONTENT.ImageFrame
					Frame.REF_CONTENT_IMAGE_BACKGROUND = Frame.REF_CONTENT_IMAGE.Background
					Frame.REF_CONTENT_IMAGE_BACKGROUND_TEXTURE = Frame.REF_CONTENT_IMAGE.BackgroundTexture
				end

				do -- ANIMATIONS
					do -- SHOW
						function Frame:ShowWithAnimation_StopEvent()

						end

						function Frame:ShowWithAnimation()

						end
					end

					do -- HIDE
						function Frame:HideWithAnimation_StopEvent()

						end

						function Frame:HideWithAnimation()

						end
					end
				end

				do -- LOGIC
					do -- FUNCTIONS
						do -- SET
							function Frame:SetImage(texture)
								Frame.REF_CONTENT_IMAGE_BACKGROUND_TEXTURE:SetTexture(texture)
							end

							function Frame:SetTint(color)
								Frame.REF_BACKGROUND_FOREGROUND_TEXTURE:SetVertexColor(color.r, color.g, color.b, color.a)
								Frame.REF_BACKGROUND_BACKGROUND_TEXTURE:SetVertexColor(color.r, color.g, color.b, color.a)
							end

							function Frame:SetInfo(image, tintColor)
								Frame:SetImage(image)
								Frame:SetTint(tintColor)
							end
						end

						do -- LOGIC

						end
					end

					do -- EVENTS

					end
				end

				do -- SETUP

				end

				--------------------------------

				return Frame
			end)
		end
	end

	do -- PINPOINT
		do -- ARROW
			PrefabRegistry:Add("Waypoint.Pinpoint.ArrowFrame", function(parent, frameStrata, frameLevel, data, name)
				local size, offset = data.size, data.offset

				--------------------------------

				local Frame = CreateFrame("Frame", name, parent)
				Frame:SetFrameStrata(frameStrata)
				Frame:SetFrameLevel(frameLevel)

				--------------------------------

				do -- ELEMENTS
					do -- CONTENT
						Frame.Content = CreateFrame("Frame", "$parent.Content", Frame)
						Frame.Content:SetPoint("CENTER", Frame)
						Frame.Content:SetFrameStrata(frameStrata)
						Frame.Content:SetFrameLevel(frameLevel + 1)
						addon.C.API.FrameUtil:SetDynamicSize(Frame.Content, Frame, 0, 0)

						local Content = Frame.Content

						--------------------------------

						do -- LAYOUT GROUP
							Content.LayoutGroup, Content.LayoutGroup_Sort = addon.C.FrameTemplates:CreateLayoutGroup(Content, { point = "TOP", direction = "vertical", resize = false, padding = offset, distribute = false, distributeResizeElements = false, excludeHidden = true, autoSort = true, customOffset = nil, customLayoutSort = nil }, "$parent.LayoutGroup")
							Content.LayoutGroup:SetPoint("CENTER", Content)
							Content.LayoutGroup:SetFrameStrata(frameStrata)
							Content.LayoutGroup:SetFrameLevel(frameLevel + 2)
							addon.C.API.FrameUtil:SetDynamicSize(Content.LayoutGroup, Content, 0, 0)
							Frame.LGS_Content = Content.LayoutGroup_Sort

							local LayoutGroup = Content.LayoutGroup

							--------------------------------

							do -- ELEMENTS
								local function CreateArrow(name)
									local Arrow = PrefabRegistry:Create("Waypoint.Pinpoint.ArrowFrame.Element", Content, frameStrata, frameLevel + 3, name)
									Arrow:SetSize(size, size)
									Arrow:SetFrameStrata(frameStrata)
									Arrow:SetFrameLevel(frameLevel + 3)

									--------------------------------

									return Arrow
								end

								for i = 1, 3 do
									local Arrow = CreateArrow("$parent." .. "Arrow" .. i)
									LayoutGroup["Arrow" .. i] = Arrow

									--------------------------------

									LayoutGroup:AddElement(Arrow)
								end
							end
						end
					end
				end

				do -- ANIMATIONS
					do -- PLAYBACK
						local PlaybackSession = {
							["playbackID"] = nil,
							["loopTimer"] = nil
						}

						function Frame:Animation_Playback_Start_StopEvent()

						end

						function Frame:Animation_Playback_Start()
							PlaybackSession.playbackID = addon.C.API.Util:gen_hash()

							--------------------------------

							if PlaybackSession.loopTimer then
								PlaybackSession.loopTimer:Cancel()
							end

							Frame:Animation_Playback_Cycle()

							PlaybackSession.loopTimer = C_Timer.NewTicker(1.25, function()
								Frame:Animation_Playback_Cycle()
							end, nil)
						end

						function Frame:Animation_Playback_Stop_StopEvent()

						end

						function Frame:Animation_Playback_Stop()

						end

						function Frame:Animation_Playback_Cycle()
							for i = 1, #Frame.Elements do
								addon.C.Libraries.AceTimer:ScheduleTimer(function() Frame.Elements[i].Animation_Playback(PlaybackSession.playbackID) end, i * .075)
							end
						end
					end
				end

				do -- LOGIC
					Frame.Elements = {
						[1] = Frame.Content.LayoutGroup.Arrow1,
						[2] = Frame.Content.LayoutGroup.Arrow2,
						[3] = Frame.Content.LayoutGroup.Arrow3
					}

					--------------------------------

					do -- FUNCTIONS
						do -- SET
							function Frame:SetTint(tintColor)
								for i = 1, #Frame.Elements do
									Frame.Elements[i]:SetTint(tintColor)
								end
							end
						end

						do -- LOGIC

						end
					end

					do -- EVENTS

					end
				end

				--------------------------------

				return Frame
			end)

			PrefabRegistry:Add("Waypoint.Pinpoint.ArrowFrame.Element", function(parent, frameStrata, frameLevel, name)
				local Frame = CreateFrame("Frame", name, parent)
				Frame:SetFrameStrata(frameStrata)
				Frame:SetFrameLevel(frameLevel)

				--------------------------------

				do -- ELEMENTS
					do -- CONTENT
						Frame.Content = CreateFrame("Frame", "$parent.Content", Frame)
						Frame.Content:SetPoint("CENTER", Frame)
						Frame.Content:SetFrameStrata(frameStrata)
						Frame.Content:SetFrameLevel(frameLevel + 1)
						addon.C.API.FrameUtil:SetDynamicSize(Frame.Content, Frame, 0, 0)

						local Content = Frame.Content

						--------------------------------

						do -- BACKGROUND
							Content.Background, Content.BackgroundTexture = addon.C.FrameTemplates:CreateTexture(Content, frameStrata, NS.Variables.PATH .. "pinpoint-arrow.png", "$parent.Background")
							Content.Background:SetPoint("CENTER", Content)
							Content.Background:SetFrameStrata(frameStrata)
							Content.Background:SetFrameLevel(frameLevel + 2)
							addon.C.API.FrameUtil:SetDynamicSize(Content.Background, Content, 0, 0)
						end
					end
				end

				do -- ANIMATIONS
					do -- PLAYBACK
						function Frame:Animation_Playback_StopEvent()
							return not Frame:IsVisible()
						end

						function Frame:Animation_Playback()
							do -- START
								addon.C.Animation:Alpha( { ["frame"] = Frame.Content, ["duration"] = .25, ["from"] = 0, ["to"] = 1, ["ease"] = nil, ["stopEvent"] = Frame.Animation_Playback_StopEvent } )
								addon.C.Animation:Translate( { ["frame"] = Frame.Content, ["duration"] = .25, ["from"] = 15, ["to"] = 0, ["axis"] = "y", ["ease"] = nil, ["stopEvent"] = Frame.Animation_Playback_StopEvent } )
							end

							do -- END
								addon.C.Libraries.AceTimer:ScheduleTimer(function()
									if not Frame:Animation_Playback_StopEvent() then
										addon.C.Animation:Alpha( { ["frame"] = Frame.Content, ["duration"] = .25, ["from"] = Frame.Content:GetAlpha(), ["to"] = 0, ["ease"] = nil, ["stopEvent"] = Frame.Animation_Playback_StopEvent } )
									end
								end, .25)
							end
						end
					end
				end

				do -- LOGIC
					do -- FUNCTIONS
						do -- SET
							function Frame:SetTint(tintColor)
								Frame.Content.BackgroundTexture:SetVertexColor(tintColor.r, tintColor.g, tintColor.b, tintColor.a)
							end
						end

						do -- LOGIC

						end
					end

					do -- EVENTS

					end
				end

				do -- SETUP

				end

				--------------------------------

				return Frame
			end)
		end
	end
end
