---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

addon.Main = {}
local NS = addon.Main; addon.Main = NS

--------------------------------

function NS:Load()
	local function Modules()
		addon.ContextIcon:Load()
        addon.WaypointSystem:Load()
	end

	--------------------------------

	Modules()
end
