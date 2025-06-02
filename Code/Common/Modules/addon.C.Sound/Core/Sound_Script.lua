---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.Sound; addon.C.Sound = NS

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
		function Callback:PlaySoundFile(filePath)
			if filePath then
				if addon.C.AddonInfo.Variables.Sound.ENABLE_AUDIO() then
					PlaySoundFile(filePath)
				end
			end
		end

		function Callback:PlaySound(soundID)
			if soundID then
				if addon.C.AddonInfo.Variables.Sound.ENABLE_AUDIO() then
					PlaySound(soundID)
				end
			end
		end
	end
end
