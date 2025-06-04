---@class addon
local addon = select(2, ...)
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

NS:Load()
