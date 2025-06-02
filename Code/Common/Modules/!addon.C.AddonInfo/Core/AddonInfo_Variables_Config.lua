---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local NS = addon.C.AddonInfo; addon.C.AddonInfo = NS

--------------------------------

NS.Variables = NS.Variables or {}
NS.Variables.Config = {}

--------------------------------
-- VARIABLES
--------------------------------

do -- MAIN

end

do  -- CONSTANTS
	do -- REFERENCES
		NS.Variables.Config.TYPE_TAB = "Tab"
		NS.Variables.Config.TYPE_TITLE = "Title"
		NS.Variables.Config.TYPE_CONTAINER = "Container"
		NS.Variables.Config.TYPE_RANGE = "Range"
		NS.Variables.Config.TYPE_BUTTON = "Button"
		NS.Variables.Config.TYPE_CHECKBOX = "Checkbox"

		NS.Variables.Config.IMAGE_TYPE_LARGE = "Large"
		NS.Variables.Config.IMAGE_TYPE_SMALL = "Small"

		--------------------------------

		function NS.Variables.Config:NewDescriptor(imageType, imagePath, description)
			local descriptor = {
				["imageType"] = imageType,
				["imagePath"] = imagePath,
				["description"] = description,
			}

			return descriptor
		end
	end

	do -- CONSTRUCTOR
		--------------------------------
		-- Documentation
		--------------------------------

		-- 	local rangeValue = 0
		-- 	local checkboxValue = false
		-- 	local dropdownValue = 1

		-- 	NS.Variables.Config.TABLE = {
		-- 		[1] = {
		-- 			["name"] = "Placeholder",
		--	 		["type"] = NS.Variables.Config.TYPE_TAB,
		-- 			["elements"] = {
		-- 				[1] = {
		-- 					["name"] = "Placeholder",
		--	 				["type"] = NS.Variables.Config.TYPE_TITLE,
		-- 					["var_title_imageTexture"] = addon.CREF:NewIcon("brush"),
		-- 					["var_title_text"] = "Placeholder",
		-- 					["var_title_subtext"] = "Placeholder",
		-- 				},
		-- 				[2] = {
		-- 					["name"] = "Placeholder",
		-- 					["type"] = NS.Variables.Config.TYPE_CONTAINER,
		-- 					["elements"] = {
		-- 						[1] = {
		-- 							["name"] = "Range",
		-- 							["type"] = NS.Variables.Config.TYPE_RANGE,
		-- 							["descriptor"] = nil,
		-- 							["indent"] = 0,
		-- 							["var_range_min"] = 1,
		-- 							["var_range_max"] = 10,
		-- 							["var_range_step"] = 1,
		--							["var_range_text"] = function(value) return string.format("%.0f", value) end,
		--							["var_range_set_lazy"] = function(value) end,
		-- 							["var_get"] = function() return rangeValue end,
		-- 							["var_set"] = function(value) rangeValue = value end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[2] = {
		-- 							["name"] = "Button",
		-- 							["type"] = NS.Variables.Config.TYPE_BUTTON,
		-- 							["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		-- 							["indent"] = 0,
		-- 							["var_button_text"] = "Placeholder",
		-- 							["var_set"] = function() print("a") end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[3] = {
		-- 							["name"] = "Checkbox",
		-- 							["type"] = NS.Variables.Config.TYPE_CHECKBOX,
		-- 							["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		--	 						["indent"] = 0,
		--	 						["var_get"] = function() return checkboxValue end,
		--	 						["var_set"] = function(value) checkboxValue = value end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[4] = {
		-- 							["name"] = "Dropdown",
		--	 						["type"] = NS.Variables.Config.TYPE_DROPDOWN,
		--	 						["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		-- 							["indent"] = 0,
		-- 							["var_dropdown_info"] = { "Option 1", "Option 2", "Option 3" },
		-- 							["var_get"] = function() return dropdownValue end,
		--	 						["var_set"] = function(value) dropdownValue = value end,
		--	 						["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						}
		-- 					}
		-- 				}
		-- 			}
		-- 		}
		-- 	}

		NS.Variables.Config.TABLE = {
			[1] = {
				["name"] = "Appearance",
				["type"] = NS.Variables.Config.TYPE_TAB,
				["elements"] = {
					[1] = {
						["name"] = "Appearance",
						["type"] = NS.Variables.Config.TYPE_TITLE,
						["var_title_imageTexture"] = addon.CREF:NewIcon("brush"),
						["var_title_text"] = "Appearance",
						["var_title_subtext"] = "Customize the appearance of the user interface.",
					},
					[2] = {
						["name"] = "Waypoint",
						["type"] = NS.Variables.Config.TYPE_CONTAINER,
						["elements"] = {
							[1] = {
								["name"] = "Size",
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = nil,
								["indent"] = 0,
								["var_range_min"] = .5,
								["var_range_max"] = 2,
								["var_range_step"] = .1,
								["var_range_text"] = function(value) return string.format("%.0f", value * 100) .. "%" end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("WAYPOINT_CONFIG_SCALE") end,
								["var_get"] = function() return addon.C.Database.Variables.DB_GLOBAL.profile.WAYPOINT_SCALE end,
								["var_set"] = function(value) addon.C.Database.Variables.DB_GLOBAL.profile.WAYPOINT_SCALE = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end,
							}
						}
					}
				}
			}
		}
	end
end
