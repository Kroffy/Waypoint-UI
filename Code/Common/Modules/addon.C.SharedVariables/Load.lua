---@class addon
local addon = select(2, ...)

--------------------------------

addon.C.SharedVariables = {}
local NS = addon.C.SharedVariables; addon.C.SharedVariables = NS

--------------------------------

function NS:Load()
	local function Modules()
		NS.Color:Load()
		NS.Util:Load()
	end

	--------------------------------

	Modules()
end
