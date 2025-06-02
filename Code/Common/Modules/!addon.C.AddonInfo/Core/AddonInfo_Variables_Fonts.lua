---@class addon
local addon = select(2, ...)
local NS = addon.C.AddonInfo; addon.C.AddonInfo = NS

--------------------------------

NS.Variables = NS.Variables or {}
NS.Variables.Fonts = {}

--------------------------------
-- VARIABLES
--------------------------------

do -- MAIN

end

do -- CONSTANTS
	do -- FONTS
		NS.Variables.Fonts.FONT_TABLE = {
			["enUS"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = addon.CREF:GetAddonPathFont() .. "SemplicitaPro.otf",
				["CONTENT_MEDIUM"] = addon.CREF:GetAddonPathFont() .. "Content.ttf",
				["CONTENT_BOLD"] = addon.CREF:GetAddonPathFont() .. "SemplicitaPro-Bold.otf",
			},
			["deDE"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["esES"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["esMX"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["frFR"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["itIT"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["koKR"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["ptBR"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["ruRU"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["zhCN"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
			["zhTW"] = {
				["CONTENT_DEFAULT"] = GameFontNormal:GetFont(),
				["CONTENT_LIGHT"] = GameFontNormal:GetFont(),
				["CONTENT_MEDIUM"] = GameFontNormal:GetFont(),
				["CONTENT_BOLD"] = GameFontNormal:GetFont(),
			},
		}
	end
end
