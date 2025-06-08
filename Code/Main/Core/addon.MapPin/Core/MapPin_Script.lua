---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.MapPin; addon.MapPin = NS

--------------------------------

NS.Script = {}

--------------------------------

function NS.Script:Load()
	--------------------------------
	-- REFERENCES
	--------------------------------

	local Callback = NS.Script; NS.Script = Callback

	--------------------------------
	-- FUNCTIONS (MAIN)
	--------------------------------

	do
		function Callback:GetCurrentPinPosition()
			local result = {}

			--------------------------------

			local pin = C_Map.GetUserWaypoint()
			local mapID = pin.uiMapID
			local pos = pin.position

			result = {
				pin = pin,
				mapID = mapID,
				pos = pos
			}

			--------------------------------

			return result
		end
	end

	--------------------------------
	-- FUNCTIONS (GLOBAL)
	--------------------------------

	do
		function WaypointUI_ResetWay()
			if WaypointUI_IsWay() then
				C_Map.ClearUserWaypoint()
			end

			--------------------------------

			WaypointUI_SetWay()
		end

		function WaypointUI_SetWay(name, mapID, x, y)
			NS.Variables.Way = {
				["name"] = name or nil,
				["mapID"] = mapID or nil,
				["x"] = x or nil,
				["y"] = y or nil,
			}
			addon.C.Database.Variables.DB_LOCAL_PERSISTENT.profile.SAVED_WAY = NS.Variables.Way
		end

		function WaypointUI_GetWay()
			NS.Variables.Way = addon.C.Database.Variables.DB_LOCAL_PERSISTENT.profile.SAVED_WAY

			--------------------------------

			return NS.Variables.Way
		end

		function WaypointUI_NewWay(name, mapID, x, y)
			if C_Map.CanSetUserWaypointOnMap(mapID) then
				local pos = CreateVector2D(x / 100, y / 100)
				local mapPoint = UiMapPoint.CreateFromVector2D(mapID, pos)

				WaypointUI_SetWay(name, mapID, pos.x, pos.y)
				C_Map.SetUserWaypoint(mapPoint)
				C_SuperTrack.SetSuperTrackedUserWaypoint(true)

				--------------------------------

				addon.WaypointSystem.Script:Update(true)

				--------------------------------

				addon.C.Sound.Script:PlaySound(89712)
			end
		end

		function WaypointUI_IsWay()
			if C_Map.HasUserWaypoint() then
				local pinTracked = C_SuperTrack.GetHighestPrioritySuperTrackingType() == Enum.SuperTrackingType.UserWaypoint

				local pin = Callback:GetCurrentPinPosition()
				local way = WaypointUI_GetWay()

				--------------------------------

				if (pinTracked) and (tostring(pin.mapID) == tostring(way.mapID)) and (math.ceil(pin.pos.x * 100) == math.ceil(way.x * 100)) and (math.ceil(pin.pos.y * 100) == math.ceil(way.y * 100)) then
					return true
				else
					return false
				end
			else
				return false
			end
		end
	end

	--------------------------------
	-- EVENTS
	--------------------------------

	--------------------------------
	-- SETUP
	--------------------------------
end
