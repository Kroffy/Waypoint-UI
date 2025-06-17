-- ♡ Translation // huchang47

---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.zhCN = {}
local NS = L.zhCN; L.zhCN = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "zhCN" then
		return
	end

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
		L["WaypointSystem - Pinpoint - Quest - Complete"] = "可交任务"
	end

	--------------------------------
	-- SLASH COMMAND
	--------------------------------

	do
		L["SlashCommand - /way - Map ID - Prefix"] = "当前地图ID: "
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
		L["Config - WaypointSystem - Type"] = "启用"
		L["Config - WaypointSystem - Type - Both"] = "所有"
		L["Config - WaypointSystem - Type - Waypoint"] = "路径点"
		L["Config - WaypointSystem - Type - Pinpoint"] = "标记点"
		L["Config - WaypointSystem - General"] = "通用"
		L["Config - WaypointSystem - General - Transition Distance"] = "标记点距离"
		L["Config - WaypointSystem - General - Transition Distance - Description"] = "标记点显示的最大距离。"
		L["Config - WaypointSystem - General - Hide Distance"] = "最小距离"
		L["Config - WaypointSystem - General - Hide Distance - Description"] = "超出距离后隐藏路径点和标记点。"
		L["Config - WaypointSystem - Waypoint"] = "路径点"
		L["Config - WaypointSystem - WaypointFooterType"] = "Additional Info"
		L["Config - WaypointSystem - WaypointFooterType - Both"] = "All"
		L["Config - WaypointSystem - WaypointFooterType - Distance"] = "Distance"
		L["Config - WaypointSystem - WaypointFooterType - ETA"] = "Arrival Time"
		L["Config - WaypointSystem - WaypointFooterType - None"] = "None"
		L["Config - WaypointSystem - WaypointFooterOpacity"] = "Transparency"
		L["Config - WaypointSystem - WaypointScale"] = "路径点大小"
		L["Config - WaypointSystem - WaypointScale - Description"] = "路径点的大小会跟随距离变化。此选项用于调整整体大小。"
		L["Config - WaypointSystem - WaypointMinScale"] = "最小%"
		L["Config - WaypointSystem - WaypointMinScale - Description"] = "可缩小到的最小百分比。"
		L["Config - WaypointSystem - WaypointMaxScale"] = "最大%"
		L["Config - WaypointSystem - WaypointMaxScale - Description"] = "可放大到的最大百分比。"
		L["Config - WaypointSystem - Pinpoint"] = "标记点"
		L["Config - WaypointSystem - PinpointScale"] = "标记点大小"
		L["Config - WaypointSystem - PinpointDetail"] = "显示扩展信息"
		L["Config - WaypointSystem - PinpointDetail - Description"] = "包含额外的信息，例如名称/描述。"

		L["Config - Appearance"] = "外观"
		L["Config - Appearance - Title"] = "外观"
		L["Config - Appearance - Title - Subtext"] = "自定义用户界面的外观。"

		L["Config - Audio"] = "Audio"
		L["Config - Audio - Title"] = "Audio"
		L["Config - Audio - Title - Subtext"] = "Configuration for Waypoint UI audio effects."
		L["Config - Audio - General"] = "General"
		L["Config - Audio - General - EnableGlobalAudio"] = "Enable Audio"

		L["Config - About"] = "About"
		L["Config - About - Contributors"] = "Contributors"
		L["Config - About - Developer"] = "Developer"
	end

	--------------------------------
	-- CONTRIBUTORS
	--------------------------------

	do
		L["Contributors - ZamestoTV - Description"] = "Translator — Russian"
		L["Contributors - huchang47 - Description"] = "Translator — Chinese (Simplified)"
		L["Contributors - BlueNightSky - Description"] = "Translator — Chinese (Traditional)"
		L["Contributors - Crazyyoungs — Description"] = "Translator — Korean"
		L["Contributors - y45853160 - Description"] = "Code — Beta Bug Fix"
	end
end

NS:Load()
