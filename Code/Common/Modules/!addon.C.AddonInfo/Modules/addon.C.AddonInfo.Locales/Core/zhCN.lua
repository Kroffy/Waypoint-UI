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
		L["Distance - Prefix"] = ""
		L["Distance - Prefix - Singular"] = ""
		L["Distance - Suffix"] = " 码"
		L["Distance - Suffix - Singular"] = " yd"
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
		L["Config - Appearance"] = "外观"
		L["Config - Appearance - Title"] = "外观"
		L["Config - Appearance - Title - Subtext"] = "自定义用户界面的外观。"

		L["Config - Appearance - WaypointSystem - Type"] = "启用"
		L["Config - Appearance - WaypointSystem - Type - Both"] = "所有"
		L["Config - Appearance - WaypointSystem - Type - Waypoint"] = "路径点"
		L["Config - Appearance - WaypointSystem - Type - Pinpoint"] = "标记点"

		L["Config - Appearance - WaypointSystem - Waypoint"] = "路径点"
		L["Config - Appearance - WaypointSystem - WaypointScale"] = "路径点尺寸"

		L["Config - Appearance - WaypointSystem - Pinpoint"] = "标记点"
		L["Config - Appearance - WaypointSystem - PinpointScale"] = "标记点尺寸"
		L["Config - Appearance - WaypointSystem - PinpointDetail"] = "显示扩展信息"
		L["Config - Appearance - WaypointSystem - PinpointDetail - Description"] = "包含额外的信息，例如名称/描述。"
	end
end

NS:Load()
