---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales

--------------------------------

addon.Waypoint = {}
local NS = addon.Waypoint; addon.Waypoint = NS

--------------------------------

function NS:Load()
	local function Variables()
		NS.Variables:Load()
	end

	local function Modules()
        NS.Elements:Load()
		NS.Script:Load()
	end

	local function Prefabs()
		NS.Prefabs:Load()
	end

	--------------------------------

	Variables()
	Prefabs()
	Modules()
end
