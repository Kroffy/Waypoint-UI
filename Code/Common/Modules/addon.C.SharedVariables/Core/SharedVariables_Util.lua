---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.SharedVariables; addon.C.SharedVariables = NS

--------------------------------

NS.Util = {}

--------------------------------

function NS.Util:Load()
	--------------------------------
	-- VARIABLES
	--------------------------------

	do -- MAIN

	end

	do -- CONSTANTS

	end

	--------------------------------
	-- FUNCTIONS (TOOLTIP)
	--------------------------------

	do
		function NS.Util:NewTooltipDivider(width)
			return "\n" .. addon.C.API.Util:InlineIcon(addon.C.AddonInfo.Variables.SharedVariables.PATH_TOOLTIP_DIVIDER, 1, width, 0, 0) .. "\n"
		end
	end

	--------------------------------
	-- EVENTS
	--------------------------------

	do

	end
end
