---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.SlashCommand; addon.C.SlashCommand = NS

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
		do -- UTILITIES
			function Callback:GetTokens(str)
				local wrongseparator = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
				local rightseparator = "%1" .. (tonumber("1.1") and "." or ",") .. "%2"
				str = str:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(wrongseparator, rightseparator)

				local tokens = {}
				for token in str:gmatch("%S+") do table.insert(tokens, token) end

				return tokens
			end
		end

		do -- SLASH COMMAND
			function Callback:GetSlashCommand(name)
				return SlashCmdList[name]
			end

			function Callback:AddSlashCommand(name, command, callback, index)
				_G["SLASH_" .. name .. index] = "/" .. command
				SlashCmdList[name] = function(msg) callback(msg, Callback:GetTokens(msg)) end
			end

			function Callback:HookSlashCommand(name, callback)
				local SLASH = Callback:GetSlashCommand(name)
				SlashCmdList[name] = function(msg)
					SLASH(msg)
					callback(msg, Callback:GetTokens(msg))
				end
			end
		end
	end

	--------------------------------
	-- EVENTS
	--------------------------------

	--------------------------------
	-- SETUP
	--------------------------------

	do
		for k, v in ipairs(addon.C.AddonInfo.Variables.SlashCommand.REGISTER) do
			if v.hook and Callback:GetSlashCommand(v.hook) then
				Callback:HookSlashCommand(v.hook, v.callback)
			else
				Callback:AddSlashCommand(v.name, v.command, v.callback, k)
			end
		end
	end
end
