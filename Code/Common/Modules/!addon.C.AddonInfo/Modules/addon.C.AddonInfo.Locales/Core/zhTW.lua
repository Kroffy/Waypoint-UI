-- ♡ Translation // BlueNightSky

---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.zhTW = {}
local NS = L.zhTW; L.zhTW = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "zhTW" then
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
		L["WaypointSystem - Pinpoint - Quest - Complete"] = "可交付任務"
	end

	--------------------------------
	-- SLASH COMMAND
	--------------------------------

	do
		L["SlashCommand - /way - Map ID - Prefix"] = "當前地圖ID: "
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

		L["Config - WaypointSystem"] = "General"
		L["Config - WaypointSystem - Title"] = "General"
		L["Config - WaypointSystem - Title - Subtext"] = "Manage general settings, such as waypoint system behavior."
		L["Config - WaypointSystem - Type"] = "啟用"
		L["Config - WaypointSystem - Type - Both"] = "所有"
		L["Config - WaypointSystem - Type - Waypoint"] = "路徑點"
		L["Config - WaypointSystem - Type - Pinpoint"] = "標記點"
		L["Config - WaypointSystem - General"] = "一般"
		L["Config - WaypointSystem - General - Transition Distance"] = "標記點距離"
		L["Config - WaypointSystem - General - Transition Distance - Description"] = "標記點顯示的最大距離。"
		L["Config - WaypointSystem - General - Hide Distance"] = "最小距離"
		L["Config - WaypointSystem - General - Hide Distance - Description"] = "路徑點/標記點 隱藏的最小距離。"
		L["Config - WaypointSystem - Waypoint"] = "路徑點"
		L["Config - WaypointSystem - WaypointScale"] = "路徑點大小"
		L["Config - WaypointSystem - WaypointScale - Description"] = "路徑點大小根據距離變化，此選項設置了整體尺寸。"
		L["Config - WaypointSystem - WaypointMinScale"] = "最小 %"
		L["Config - WaypointSystem - WaypointMinScale - Description"] = "可以減小到的最小 % 尺寸。"
		L["Config - WaypointSystem - WaypointMaxScale"] = "最大 %"
		L["Config - WaypointSystem - WaypointMaxScale - Description"] = "可以放大到的最大 % 尺寸。"
		L["Config - WaypointSystem - Pinpoint"] = "標記點"
		L["Config - WaypointSystem - PinpointScale"] = "標記點大小"
		L["Config - WaypointSystem - PinpointDetail"] = "顯示額外訊息"
		L["Config - WaypointSystem - PinpointDetail - Description"] = "包含額外的訊息，例如名稱/描述。"

		L["Config - Appearance"] = "外觀"
		L["Config - Appearance - Title"] = "外觀"
		L["Config - Appearance - Title - Subtext"] = "自定義用戶界面的外觀。"

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
		L["Contributors - y45853160 - Description"] = "Code — Beta Bug Fix"
	end
end

NS:Load()
