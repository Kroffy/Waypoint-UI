---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

L.esES = {}
local NS = L.esES; L.esES = NS

--------------------------------

function NS:Load()
    if GetLocale() ~= "esES" then
        return
    end
end
