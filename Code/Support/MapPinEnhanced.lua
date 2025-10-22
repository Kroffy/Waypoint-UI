local env               = select(2, ...)
local pairs, ipairs     = pairs, ipairs

local Support           = env.WPM:Import("@/Support")
local MapPinEnhanced    = env.WPM:New("@/Support/MapPinEnhanced")

local MPE_TRACKER_FRAME = MapPinEnhancedSuperTrackedPin
local MPE_DATABASE      = MapPinEnhancedDB



local function hideMPEFrame()
    assert(MPE_TRACKER_FRAME,
           "Invalid variable `MPE_TRACKER_FRAME`")

    MPE_TRACKER_FRAME:HookScript("OnShow", function()
        MPE_TRACKER_FRAME:Hide()
    end)
end

--[[
	function NS:GetSets()
		for set, setContent in pairs(MPE_DATABASE.sets) do
			for pin, pinContent in pairs(setContent.pins) do
				-- Pin content
			end
		end
	end
]]



local function OnAddonLoad()
    hideMPEFrame()
end
Support:Add("MapPinEnhanced", OnAddonLoad)
