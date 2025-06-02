---@class addon
local addon = select(2, ...)

--------------------------------

addon.CREF = {}
local NS = addon.CREF; addon.CREF = NS

--------------------------------
-- REFERENCES
--------------------------------

do
	-- Returns add-on version string.
	function NS:GetAddonVersionString() return addon.C.AddonInfo.Variables.General.VERSION_STRING end

	-- Returns add-on version number.
	function NS:GetAddonVersionNumber() return addon.C.AddonInfo.Variables.General.VERSION_NUMBER end

	-- Returns general add-on frame.
	function NS:GetAddonFrame() return addon.C.AddonInfo.Variables.General.ADDON_FRAME end

	-- Returns general Common Framework frame.
	function NS:GetCommonFrame() return addon.C.AddonInfo.Variables.General.COMMON_FRAME end

	-- Returns add-on general path.
	function NS:GetAddonPath() return addon.C.AddonInfo.Variables.General.ADDON_PATH end

	-- Returns add-on font path.
	function NS:GetAddonPathFont() return addon.C.AddonInfo.Variables.General.ADDON_PATH_FONT end

	-- Returns add-on element path.
	function NS:GetAddonPathElement() return addon.C.AddonInfo.Variables.General.ADDON_PATH_ELEMENT end

	-- Returns add-on audio path.
	function NS:GetAddonPathSound() return addon.C.AddonInfo.Variables.General.ADDON_PATH_SOUND end

	-- Returns Common Framework path.
	function NS:GetCommonPath() return addon.C.AddonInfo.Variables.General.COMMON_PATH end

	-- Returns Common Framework art path.
	function NS:GetCommonPathArt() return addon.C.AddonInfo.Variables.General.COMMON_PATH_ART end

	-- Returns Common Framework art -> config path.
	function NS:GetCommonPathConfig() return addon.C.AddonInfo.Variables.General.COMMON_PATH_ART .. "Config/" end

	-- Returns Common Framework art -> element path.
	function NS:GetCommonPathElement() return addon.C.AddonInfo.Variables.General.COMMON_PATH_ART .. "Elements/" end

	-- Returns shared variable / color.
	function NS:GetSharedColor() return addon.C.SharedVariables.Color end

	-- Returns shared variable / util.
	function NS:GetSharedUtil() return addon.C.SharedVariables.Util end

	-- Returns icon path using the specified name. File name only - exclude file extension.
	---@param iconName string
	---@return string iconPath
	function NS:NewIcon(iconName) return addon.C.AddonInfo.Variables.General.COMMON_PATH_ART .. "Icons/" .. iconName .. ".png" end
end
