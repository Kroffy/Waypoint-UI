---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.zhCN = {}
local NS = L.zhCN; L.zhCN = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "zhCN" then
		return
	end
end

NS:Load()
