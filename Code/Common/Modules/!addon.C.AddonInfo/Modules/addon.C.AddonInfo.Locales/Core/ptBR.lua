---@class addon
local addon = select(2, ...)
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

NS:Load()
