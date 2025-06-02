---@class addon
local addon = select(2, ...)

--------------------------------

addon.C.AddonInfo = {}
local NS = addon.C.AddonInfo; addon.C.AddonInfo = NS

--------------------------------

function NS:Load()
	local function Modules()
		NS.Locales:Load()
	end

	--------------------------------

	Modules()
end
