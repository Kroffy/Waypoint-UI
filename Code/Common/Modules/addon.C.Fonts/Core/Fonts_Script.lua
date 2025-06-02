---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.Fonts; addon.C.Fonts = NS

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
		function Callback:GetFonts()
			for locale, localeInfo in pairs(addon.C.AddonInfo.Variables.Fonts.FONT_TABLE) do
				if locale == NS.Variables.LOCALE then
					for fontKey, fontName in pairs(localeInfo) do
						NS[fontKey] = fontName
					end
				end
			end
		end
	end

	--------------------------------
	-- EVENTS
	--------------------------------

	--------------------------------
	-- SETUP
	--------------------------------

	do
		Callback:GetFonts()
	end
end
