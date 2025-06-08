-- Base Localization
-- Languages with no translations will default to this:

---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.enUS = {}
local NS = L.enUS; L.enUS = NS

--------------------------------

function NS:Load()
	--------------------------------
	-- GENERAL
	--------------------------------

	do
		L["Distance - Prefix"] = ""
		L["Distance - Prefix - Singular"] = ""
		L["Distance - Suffix"] = " yds"
		L["Distance - Suffix - Singular"] = " yd"
	end

	--------------------------------
	-- WAYPOINT SYSTEM
	--------------------------------

	do
		-- PINPOINT
		L["WaypointSystem - Pinpoint - Quest - Complete"] = "Ready for Turn-in"
	end

	--------------------------------
	-- SLASH COMMAND
	--------------------------------

	do
		L["SlashCommand - /way - Map ID - Prefix"] = "Current Map ID: "
		L["SlashCommand - /way - Map ID - Suffix"] = ""
		L["SlashCommand - /way - Position - Axis (X) - Prefix"] = "X: "
		L["SlashCommand - /way - Position - Axis (X) - Suffix"] = ""
		L["SlashCommand - /way - Position - Axis (Y) - Prefix"] = ", Y: "
		L["SlashCommand - /way - Position - Axis (Y) - Suffix"] = ""
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

		L["Config - Appearance - WaypointSystem - General"] = "General"
		L["Config - Appearance - WaypointSystem - General - Transition Distance"] = "Pinpoint Distance"
		L["Config - Appearance - WaypointSystem - General - Transition Distance - Description"] = "Maximum distance before Pinpoint is shown."
		L["Config - Appearance - WaypointSystem - General - Hide Distance"] = "Minimum Distance"
		L["Config - Appearance - WaypointSystem - General - Hide Distance - Description"] = "Distance before Waypoint / Pinpoint is hidden."

		L["Config - Appearance - WaypointSystem - Waypoint"] = "Waypoint"
		L["Config - Appearance - WaypointSystem - WaypointScale"] = "Waypoint Size"

		L["Config - Appearance - WaypointSystem - Pinpoint"] = "Pinpoint"
		L["Config - Appearance - WaypointSystem - PinpointScale"] = "Pinpoint Size"
		L["Config - Appearance - WaypointSystem - PinpointDetail"] = "Show Extended Info"
		L["Config - Appearance - WaypointSystem - PinpointDetail - Description"] = "Include additional info, such as name / description."
	end
end

NS:Load()
