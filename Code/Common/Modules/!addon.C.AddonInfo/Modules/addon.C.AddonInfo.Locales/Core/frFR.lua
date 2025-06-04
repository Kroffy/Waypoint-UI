---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.frFR = {}
local NS = L.frFR; L.frFR = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "frFR" then
		return
	end
end

NS:Load()
