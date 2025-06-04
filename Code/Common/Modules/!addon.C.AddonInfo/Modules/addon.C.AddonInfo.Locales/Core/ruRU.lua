-- ♡ Translation // ZamestoTV (Hubbotu)

---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.ruRU = {}
local NS = L.ruRU; L.ruRU = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "ruRU" then
		return
		L["Pinpoint - Quest - Complete"] = "Готов к сдаче"
	end

	--------------------------------
	-- WAYPOINT SYSTEM
	--------------------------------

	do
		-- WAYPOINT
		L["WaypointSystem - Waypoint - Distance - Prefix"] = ""
		L["WaypointSystem - Waypoint - Distance - Suffix"] = " yds"

		-- PINPOINT
		L["WaypointSystem - Pinpoint - Quest - Complete"] = "Готов к сдаче"
	end

	--------------------------------
	-- CONFIG
	--------------------------------

	do
		L["Config - Appearance"] = "Appearance"
		L["Config - Appearance - Title"] = "Appearance"
		L["Config - Appearance - Title - Subtext"] = "Customize the appearance of the user interface."
		L["Config - Appearance - WaypointSystem - Type"] = "Enable"
		L["Config - Appearance - WaypointSystem - Type - Both"] = "All"
		L["Config - Appearance - WaypointSystem - Type - Waypoint"] = "Waypoint"
		L["Config - Appearance - WaypointSystem - Type - Pinpoint"] = "Pinpoint"
		L["Config - Appearance - WaypointSystem - Waypoint"] = "Waypoint"
		L["Config - Appearance - WaypointSystem - Pinpoint"] = "Pinpoint"
		L["Config - Appearance - WaypointSystem - WaypointScale"] = "Waypoint Size"
		L["Config - Appearance - WaypointSystem - PinpointScale"] = "Pinpoint Size"
		L["Config - Appearance - WaypointSystem - PinpointDetail"] = "Show Extended Info"
		L["Config - Appearance - WaypointSystem - PinpointDetail - Description"] = "Include additional info, such as name / description."
	end
end

NS:Load()
