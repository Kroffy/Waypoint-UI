---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

L.koKR = {}
local NS = L.koKR; L.koKR = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "koKR" then
		return
	end
end
