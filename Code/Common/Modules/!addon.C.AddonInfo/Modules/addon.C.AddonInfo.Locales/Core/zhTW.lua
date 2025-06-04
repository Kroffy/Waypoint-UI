---@class addon
local addon = select(2, ...)
local L = addon.C.AddonInfo.Locales

--------------------------------

L.zhTW = {}
local NS = L.zhTW; L.zhTW = NS

--------------------------------

function NS:Load()
	if GetLocale() ~= "zhTW" then
		return
	end
end

NS:Load()
