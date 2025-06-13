-- ♡ Translation // ZamestoTV (Hubbotu)
-- Переводчик ZamestoTV

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
		L["WaypointSystem - Pinpoint - Quest - Complete"] = "Готов к сдаче"
	end

	--------------------------------
	-- SLASH COMMAND
	--------------------------------

	do
		L["SlashCommand - /way - Map ID - Prefix"] = "Текущий ID карты: "
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
		L["Config - WaypointSystem - Type"] = "Включить"
		L["Config - WaypointSystem - Type - Both"] = "ВСЕ"
		L["Config - WaypointSystem - Type - Waypoint"] = "Точка маршрута"
		L["Config - WaypointSystem - Type - Pinpoint"] = "Точка привязки"
		L["Config - WaypointSystem - General"] = "Общие"
		L["Config - WaypointSystem - General - Transition Distance"] = "Точное расстояние"
		L["Config - WaypointSystem - General - Transition Distance - Description"] = "Показано максимальное расстояние до точечного обнаружения."
		L["Config - WaypointSystem - General - Hide Distance"] = "Минимальное расстояние"
		L["Config - WaypointSystem - General - Hide Distance - Description"] = "Расстояние до точки маршрута/точке привязки скрыто."
		L["Config - WaypointSystem - Waypoint"] = "Точка маршрута"
		L["Config - WaypointSystem - WaypointScale"] = "Размер точки маршрута"
		L["Config - WaypointSystem - WaypointScale - Description"] = "Размер точки маршрута меняется в зависимости от расстояния. Эта опция задает общий размер."
		L["Config - WaypointSystem - WaypointMinScale"] = "Минимум %"
		L["Config - WaypointSystem - WaypointMinScale - Description"] = "Минимальный % размер, до которого можно уменьшить."
		L["Config - WaypointSystem - WaypointMaxScale"] = "Максимум %"
		L["Config - WaypointSystem - WaypointMaxScale - Description"] = "Максимальный % размер, до которого можно увеличить."
		L["Config - WaypointSystem - Pinpoint"] = "Точка привязки"
		L["Config - WaypointSystem - PinpointScale"] = "Размер точки привязки"
		L["Config - WaypointSystem - PinpointDetail"] = "Показать расширенную информацию"
		L["Config - WaypointSystem - PinpointDetail - Description"] = "Включите дополнительную информацию, например, имя/описание."

		L["Config - Appearance"] = "Появление"
		L["Config - Appearance - Title"] = "Появление"
		L["Config - Appearance - Title - Subtext"] = "Настройте внешний вид пользовательского интерфейса."

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
