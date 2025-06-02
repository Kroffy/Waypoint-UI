---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script

--------------------------------

addon.C.AddonInfo.Locales = {}
local NS = addon.C.AddonInfo.Locales; addon.C.AddonInfo.Locales = NS

--------------------------------

function NS:Load()
	local function Modules()
		NS.deDE:Load()
		NS.enUS:Load()
		NS.esES:Load()
		NS.esMX:Load()
		NS.frFR:Load()
		NS.itIT:Load()
		NS.koKR:Load()
		NS.ptBR:Load()
		NS.ruRU:Load()
		NS.zhCN:Load()
		NS.zhTW:Load()
	end

	--------------------------------

	Modules()

	C_Timer.After(0, function()
		CallbackRegistry:Trigger("LOAD_LOCALE")
	end)
end
