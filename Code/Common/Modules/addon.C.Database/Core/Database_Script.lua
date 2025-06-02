---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.Database; addon.C.Database = NS
local AceDB = LibStub("AceDB-3.0")

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
		function Callback:CopyTable(original)
			if type(original) ~= "table" then
				return original
			end

			local copy = {}
			for k, v in pairs(original) do
				copy[copy(k)] = copy(v)
			end

			return copy
		end

		function Callback:ResetCache()
			NS.DB_GLOBAL = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.GLOBAL_DEFAULT)
			NS.DB_LOCAL = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.LOCAL_DEFAULT)

			addon.C.AddonInfo.Variables.Database.GLOBAL_REFERENCE = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.GLOBAL_DEFAULT)
			addon.C.AddonInfo.Variables.Database.LOCAL_REFERENCE = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.LOCAL_DEFAULT)
		end

		function Callback:ResetAll()
			NS.DB_GLOBAL = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.GLOBAL_DEFAULT)
			NS.DB_LOCAL = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.LOCAL_DEFAULT)
			NS.DB_GLOBAL_PERSISTENT = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.GLOBAL_PERSISTENT_DEFAULT)
			NS.DB_LOCAL_PERSISTENT = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.LOCAL_PERSISTENT_DEFAULT)

			addon.C.AddonInfo.Variables.Database.GLOBAL_REFERENCE = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.GLOBAL_DEFAULT)
			addon.C.AddonInfo.Variables.Database.LOCAL_REFERENCE = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.LOCAL_DEFAULT)
			addon.C.AddonInfo.Variables.Database.GLOBAL_PERSISTENT_REFERENCE = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.GLOBAL_PERSISTENT_DEFAULT)
			addon.C.AddonInfo.Variables.Database.LOCAL_PERSISTENT_REFERENCE = Callback:CopyTable(addon.C.AddonInfo.Variables.Database.LOCAL_PERSISTENT_DEFAULT)
		end
	end

	--------------------------------
	-- EVENTS
	--------------------------------

	--------------------------------
	-- SETUP
	--------------------------------
end

function NS.Script:OnInitialize()
	addon.C.Libraries.AceTimer:ScheduleTimer(function()
		NS.Variables.DB_GLOBAL = AceDB:New(addon.C.AddonInfo.Variables.Database.GLOBAL_NAME, addon.C.AddonInfo.Variables.Database.GLOBAL_DEFAULT, true)
		NS.Variables.DB_LOCAL = AceDB:New(addon.C.AddonInfo.Variables.Database.LOCAL_NAME, addon.C.AddonInfo.Variables.Database.LOCAL_DEFAULT, true)
		NS.Variables.DB_GLOBAL_PERSISTENT = AceDB:New(addon.C.AddonInfo.Variables.Database.GLOBAL_PERSISTENT_NAME, addon.C.AddonInfo.Variables.Database.GLOBAL_PERSISTENT_DEFAULT, true)
		NS.Variables.DB_LOCAL_PERSISTENT = AceDB:New(addon.C.AddonInfo.Variables.Database.LOCAL_PERSISTENT_NAME, addon.C.AddonInfo.Variables.Database.LOCAL_PERSISTENT_DEFAULT, true)
	end, 0)
end

LibStub("AceAddon-3.0"):NewAddon(NS.Script, addon.C.AddonInfo.Variables.General.IDENTIFIER)
