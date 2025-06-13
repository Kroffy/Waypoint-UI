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
		L["Config - General"] = "General"
		L["Config - General - Title"] = "General"
		L["Config - General - Title - Subtext"] = "Customize overall settings."
		L["Config - General - Preferences"] = "Preferences"
		L["Config - General - Preferences - Meter"] = "Use Meters instead of Yards"
		L["Config - General - Preferences - Meter - Description"] = "Changes the unit of measurement to Metric."
		L["Config - General - Reset"] = "Reset"
		L["Config - General - Reset - Button"] = "Reset to Default"
		L["Config - General - Reset - Confirm"] = "Are you sure you want to reset all settings?"
		L["Config - General - Reset - Confirm - Yes"] = "Confirm"
		L["Config - General - Reset - Confirm - No"] = "Cancel"

		L["Config - WaypointSystem"] = "Waypoint"
		L["Config - WaypointSystem - Title"] = "Waypoint"
		L["Config - WaypointSystem - Title - Subtext"] = "Manage behavior of in-world marker and in-world objective pin."
		L["Config - WaypointSystem - Type"] = "Enable"
		L["Config - WaypointSystem - Type - Both"] = "All"
		L["Config - WaypointSystem - Type - Waypoint"] = "Waypoint"
		L["Config - WaypointSystem - Type - Pinpoint"] = "Pinpoint"
		L["Config - WaypointSystem - General"] = "General"
		L["Config - WaypointSystem - General - Transition Distance"] = "Pinpoint Distance"
		L["Config - WaypointSystem - General - Transition Distance - Description"] = "Distance before Pinpoint is shown."
		L["Config - WaypointSystem - General - Hide Distance"] = "Minimum Distance"
		L["Config - WaypointSystem - General - Hide Distance - Description"] = "Distance before hidden."
		L["Config - WaypointSystem - Waypoint"] = "Waypoint"
		L["Config - WaypointSystem - WaypointScale"] = "Waypoint Size"
		L["Config - WaypointSystem - WaypointScale - Description"] = "Size changes based on distance. This option sets the overall size."
		L["Config - WaypointSystem - WaypointMinScale"] = "Minimum %"
		L["Config - WaypointSystem - WaypointMinScale - Description"] = "Size can reduce to."
		L["Config - WaypointSystem - WaypointMaxScale"] = "Maximum %"
		L["Config - WaypointSystem - WaypointMaxScale - Description"] = "Size can enlarge to."
		L["Config - WaypointSystem - Pinpoint"] = "Pinpoint"
		L["Config - WaypointSystem - PinpointScale"] = "Pinpoint Size"
		L["Config - WaypointSystem - PinpointDetail"] = "Show Extended Info"
		L["Config - WaypointSystem - PinpointDetail - Description"] = "Such as name and description."

		L["Config - Appearance"] = "Appearance"
		L["Config - Appearance - Title"] = "Appearance"
		L["Config - Appearance - Title - Subtext"] = "Customize the appearance of the user interface."

		L["Config - Audio"] = "Audio"
		L["Config - Audio - Title"] = "Audio"
		L["Config - Audio - Title - Subtext"] = "Configuration for Waypoint UI audio effects."
		L["Config - Audio - General"] = "General"
		L["Config - Audio - General - EnableGlobalAudio"] = "Enable Audio"

		L["Config - About"] = "About"
		L["Config - About - Contributors"] = "Contributors"
		L["Config - About - Developer"] = "Developer"
		L["Config - About - Developer - AdaptiveX"] = "AdaptiveX"
	end

	--------------------------------
	-- CONTRIBUTORS
	--------------------------------

	do
		L["Contributors - ZamestoTV"] = "ZamestoTV"
		L["Contributors - ZamestoTV - Description"] = "Translator — Russian"
		L["Contributors - huchang47"] = "huchang47"
		L["Contributors - huchang47 - Description"] = "Translator — Chinese (Simplified)"
		L["Contributors - BlueNightSky"] = "BlueNightSky"
		L["Contributors - BlueNightSky - Description"] = "Translator — Chinese (Traditional)"
		L["Contributors - y45853160"] = "y45853160"
		L["Contributors - y45853160 - Description"] = "Code — Beta Bug Fix"
	end
end

NS:Load()
