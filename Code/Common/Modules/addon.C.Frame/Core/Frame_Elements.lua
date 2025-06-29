---@class addon
local addon = select(2, ...)
local NS = addon.C.Frame; addon.C.Frame = NS

--------------------------------

NS.Elements = {}

--------------------------------

function NS.Elements:Load()
	--------------------------------
	-- CREATE ELEMENTS
	--------------------------------

	do -- CREATE ELEMENTS
		do -- ELEMENTS
			local Frame = CreateFrame("Frame", addon.C.AddonInfo.Variables.General.ADDON_FRAME_NAME, nil)
			Frame:SetSize(WorldFrame:GetSize())
			Frame:SetPoint("CENTER", nil)
			C_Timer.After(.1, function() Frame:SetScale(addon.C.AddonInfo.Variables.General.UI_SCALE) end)

			addon.C.AddonInfo.Variables.General.ADDON_FRAME = Frame
			_G[addon.C.AddonInfo.Variables.General.ADDON_FRAME_NAME] = Frame

			--------------------------------

			do -- COMMON
				Frame.Common = CreateFrame("Frame", "$parent.Common", Frame)
				Frame.Common:SetAllPoints(Frame)

				addon.C.AddonInfo.Variables.General.COMMON_FRAME = Frame.Common
			end
		end

		do -- REFERENCES
			local Frame = _G[addon.C.AddonInfo.Variables.General.ADDON_FRAME_NAME]
		end
	end

	--------------------------------
	-- REFERENCES
	--------------------------------

	local Frame = _G[addon.C.AddonInfo.Variables.General.ADDON_FRAME_NAME]
	local Callback = NS.Script; NS.Script = Callback

	--------------------------------
	-- SETUP
	--------------------------------

	do

	end
end
