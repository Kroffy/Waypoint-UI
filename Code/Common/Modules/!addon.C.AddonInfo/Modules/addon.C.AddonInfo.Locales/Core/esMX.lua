---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

L.esMX = {}
local NS = L.esMX; L.esMX = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "esMX" then
		return
	end
end
