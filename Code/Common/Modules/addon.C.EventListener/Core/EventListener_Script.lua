---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.EventListener; addon.C.EventListener = NS

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

	--------------------------------
	-- EVENTS
	--------------------------------

	do
		local _ = CreateFrame("Frame")
		_:RegisterEvent("GLOBAL_MOUSE_DOWN")
		_:RegisterEvent("GLOBAL_MOUSE_UP")
		_:SetScript("OnEvent", function(self, event, ...)
			if event == "GLOBAL_MOUSE_DOWN" then
				CallbackRegistry:Trigger("EVENT_MOUSE_DOWN", ...)
			elseif event == "GLOBAL_MOUSE_UP" then
				CallbackRegistry:Trigger("EVENT_MOUSE_UP", ...)
			end
		end)
	end

	--------------------------------
	-- SETUP
	--------------------------------
end
