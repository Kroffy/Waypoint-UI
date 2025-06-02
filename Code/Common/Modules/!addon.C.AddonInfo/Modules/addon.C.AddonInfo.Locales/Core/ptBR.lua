---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

L.ptBR = {}
local NS = L.ptBR; L.ptBR = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "ptBR" then
		return
	end
end
