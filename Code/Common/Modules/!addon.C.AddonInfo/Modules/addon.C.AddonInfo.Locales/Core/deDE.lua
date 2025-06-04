---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.deDE = {}
local NS = L.deDE; L.deDE = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "deDE" then
		return
	end
end

NS:Load()
