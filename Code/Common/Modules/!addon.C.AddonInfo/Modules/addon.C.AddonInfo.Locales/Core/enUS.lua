-- Base Localization
-- Languages with no translations will default to this:

---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

L.enUS = {}
local NS = L.enUS; L.enUS = NS

--------------------------------

function NS:Load()
	--------------------------------
	-- PINPOINT
	--------------------------------

	do
		L["Pinpoint - Quest - Complete"] = "Ready for Turn-in"
	end
end
