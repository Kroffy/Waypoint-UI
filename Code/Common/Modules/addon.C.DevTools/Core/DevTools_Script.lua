---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.DevTools; addon.C.DevTools = NS

--------------------------------

NS.Script = {}

--------------------------------

function NS.Script:Load()
	--------------------------------
	-- REFERENCES
	--------------------------------

	local Callback = NS.Script; NS.Script = Callback

	--------------------------------
	-- FUNCTIONS (MAIN)
	--------------------------------

	do
		function Callback:Print(text)
			if text then
				if addon.C.AddonInfo.Variables.General.IS_DEVELOPER_MODE then
					print(text)
				end
			end
		end
	end
end
