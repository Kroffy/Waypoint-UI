---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
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
		NS.Variables.Config.TYPE_SECTION = "Section"
		NS.Variables.Config.TYPE_RANGE = "Range"
		NS.Variables.Config.TYPE_BUTTON = "Button"
		NS.Variables.Config.TYPE_CHECKBOX = "Checkbox"
		NS.Variables.Config.TYPE_DROPDOWN = "Dropdown"
		NS.Variables.Config.TYPE_COLOR = "Color"

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
		-- 	local colorValue = { r = 1, g = 1, b = 1, a = 1 }

		-- 	NS.Variables.Config.TABLE = {
		-- 		[1] = {
		-- 			["name"] = "Placeholder",
		--  		["type"] = NS.Variables.Config.TYPE_TAB,
		-- 			["elements"] = {
		-- 				[1] = {
		-- 					["name"] = "Placeholder",
		--  				["type"] = NS.Variables.Config.TYPE_TITLE,
		-- 					["var_title_imageTexture"] = addon.CREF:NewIcon("brush"),
		-- 					["var_title_text"] = "Placeholder",
		-- 					["var_title_subtext"] = "Placeholder",
		-- 				},
		-- 				[2] = {
		-- 					["name"] = "Placeholder",
		-- 					["type"] = NS.Variables.Config.TYPE_CONTAINER,
		-- 					["var_hidden"] = function() return false end,
		-- 					["elements"] = {
		-- 						[1] = {
		-- 							["name"] = "Section",
		-- 							["type"] = NS.Variables.Config.TYPE_SECTION,
		-- 							["descriptor"] = nil,
		-- 							["indent"] = 0,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[2] = {
		-- 							["name"] = "Range",
		-- 							["type"] = NS.Variables.Config.TYPE_RANGE,
		-- 							["descriptor"] = nil,
		-- 							["indent"] = 0,
		-- 							["var_range_min"] = 1,
		-- 							["var_range_max"] = 10,
		-- 							["var_range_step"] = 1,
		-- 							["var_range_text"] = function(value) return string.format("%.0f", value) end,
		-- 							["var_range_set_lazy"] = function(value) end,
		-- 							["var_get"] = function() return rangeValue end,
		-- 							["var_set"] = function(value) rangeValue = value end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[3] = {
		-- 							["name"] = "Button",
		-- 							["type"] = NS.Variables.Config.TYPE_BUTTON,
		-- 							["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		-- 							["indent"] = 0,
		-- 							["var_button_text"] = "Placeholder",
		-- 							["var_set"] = function() print("a") end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[4] = {
		-- 							["name"] = "Checkbox",
		-- 							["type"] = NS.Variables.Config.TYPE_CHECKBOX,
		-- 							["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		--  						["indent"] = 0,
		--  						["var_get"] = function() return checkboxValue end,
		--  						["var_set"] = function(value) checkboxValue = value end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[5] = {
		-- 							["name"] = "Dropdown",
		--  						["type"] = NS.Variables.Config.TYPE_DROPDOWN,
		--  						["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		-- 							["indent"] = 0,
		-- 							["var_dropdown_info"] = { "Option 1", "Option 2", "Option 3" },
		-- 							["var_get"] = function() return dropdownValue end,
		--  						["var_set"] = function(value) dropdownValue = value; return true end, -- Return true/false to close the context menu on option select
		--  						["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 						[6] = {
		-- 							["name"] = "Color",
		-- 							["type"] = NS.Variables.Config.TYPE_COLOR,
		-- 							["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, "Placeholder"),
		-- 							["indent"] = 0,
		-- 							["var_get"] = function() return colorValue end,
		-- 							["var_set"] = function(value) colorValue = value end,
		-- 							["var_disabled"] = function() return false end,
		-- 							["var_hidden"] = function() return false end,
		-- 						},
		-- 					}
		-- 				}
		-- 			}
		-- 		}
		-- 	}

		local function GetDatabase(name)
			if addon.C.Database and addon.C.Database.Variables then
				return addon.C.Database.Variables[name].profile
			end
		end

		NS.Variables.Config.TABLE = {
			[1] = {
				["name"] = L["Config - Appearance"],
				["type"] = NS.Variables.Config.TYPE_TAB,
				["elements"] = {
					[1] = {
						["name"] = L["Config - Appearance - Title"],
						["type"] = NS.Variables.Config.TYPE_TITLE,
						["var_title_imageTexture"] = addon.CREF:NewIcon("brush"),
						["var_title_text"] = L["Config - Appearance - Title"],
						["var_title_subtext"] = L["Config - Appearance - Title - Subtext"],
					},
					[2] = {
						["name"] = nil,
						["type"] = NS.Variables.Config.TYPE_CONTAINER,
						["var_transparent"] = true,
						["var_hidden"] = function() return false end,
						["elements"] = {
							[1] = {
								["name"] = L["Config - Appearance - WaypointSystem - Type"],
								["type"] = NS.Variables.Config.TYPE_DROPDOWN,
								["descriptor"] = nil,
								["indent"] = 0,
								["var_dropdown_info"] = { L["Config - Appearance - WaypointSystem - Type - Both"], L["Config - Appearance - WaypointSystem - Type - Waypoint"], L["Config - Appearance - WaypointSystem - Type - Pinpoint"] },
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_TYPE end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_TYPE = value; CallbackRegistry:Trigger("CONFIG_WS_TYPE"); return true end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end
							},
						}
					},
					[3] = {
						["name"] = L["Config - Appearance - WaypointSystem - General"],
						["type"] = NS.Variables.Config.TYPE_CONTAINER,
						["var_transparent"] = false,
						["var_hidden"] = function() return false end,
						["elements"] = {
							[1] = {
								["name"] = L["Config - Appearance - WaypointSystem - General - Transition Distance"],
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, L["Config - Appearance - WaypointSystem - General - Transition Distance - Description"]),
								["indent"] = 0,
								["var_range_min"] = 50,
								["var_range_max"] = 500,
								["var_range_step"] = 25,
								["var_range_text"] = function(value) return L["Distance - Prefix"] .. string.format("%.0f", value) .. L["Distance - Suffix"] end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("CONFIG_WS_DISTANCE_TRANSITION") end,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_DISTANCE_TRANSITION end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_DISTANCE_TRANSITION = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return GetDatabase("DB_GLOBAL").WS_TYPE ~= 1 end,
							},
							[2] = {
								["name"] = L["Config - Appearance - WaypointSystem - General - Hide Distance"],
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, L["Config - Appearance - WaypointSystem - General - Hide Distance - Description"]),
								["indent"] = 0,
								["var_range_min"] = 1,
								["var_range_max"] = 100,
								["var_range_step"] = 1,
								["var_range_text"] = function(value) return L["Distance - Prefix"] .. string.format("%.0f", value) .. L["Distance - Suffix"] end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("CONFIG_WS_DISTANCE_HIDE") end,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_DISTANCE_HIDE end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_DISTANCE_HIDE = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end,
							}
						}
					},
					[4] = {
						["name"] = L["Config - Appearance - WaypointSystem - Waypoint"],
						["type"] = NS.Variables.Config.TYPE_CONTAINER,
						["var_transparent"] = false,
						["var_hidden"] = function() return GetDatabase("DB_GLOBAL").WS_TYPE ~= 1 and GetDatabase("DB_GLOBAL").WS_TYPE ~= 2 end,
						["elements"] = {
							[1] = {
								["name"] = L["Config - Appearance - WaypointSystem - WaypointScale"],
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, L["Config - Appearance - WaypointSystem - WaypointScale - Description"]),
								["indent"] = 0,
								["var_range_min"] = .5,
								["var_range_max"] = 5,
								["var_range_step"] = .1,
								["var_range_text"] = function(value) return string.format("%.0f", value * 100) .. "%" end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("CONFIG_WAYPOINT_SCALE") end,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_WAYPOINT_SCALE end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_WAYPOINT_SCALE = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end,
							},
							[2] = {
								["name"] = L["Config - Appearance - WaypointSystem - WaypointMinScale"],
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, L["Config - Appearance - WaypointSystem - WaypointMinScale - Description"]),
								["indent"] = 1,
								["var_range_min"] = .125,
								["var_range_max"] = 1,
								["var_range_step"] = .125,
								["var_range_text"] = function(value) return string.format("%.0f", value * 100) .. "%" end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("CONFIG_WAYPOINT_MIN_SCALE") end,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_WAYPOINT_MIN_SCALE end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_WAYPOINT_MIN_SCALE = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end,
							},
							[3] = {
								["name"] = L["Config - Appearance - WaypointSystem - WaypointMaxScale"],
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, L["Config - Appearance - WaypointSystem - WaypointMaxScale - Description"]),
								["indent"] = 1,
								["var_range_min"] = 1,
								["var_range_max"] = 2,
								["var_range_step"] = .125,
								["var_range_text"] = function(value) return string.format("%.0f", value * 100) .. "%" end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("CONFIG_WAYPOINT_MAX_SCALE") end,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_WAYPOINT_MAX_SCALE end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_WAYPOINT_MAX_SCALE = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end,
							}
						}
					},
					[5] = {
						["name"] = L["Config - Appearance - WaypointSystem - Pinpoint"],
						["type"] = NS.Variables.Config.TYPE_CONTAINER,
						["var_transparent"] = false,
						["var_hidden"] = function() return GetDatabase("DB_GLOBAL").WS_TYPE ~= 1 and GetDatabase("DB_GLOBAL").WS_TYPE ~= 3 end,
						["elements"] = {
							[1] = {
								["name"] = L["Config - Appearance - WaypointSystem - PinpointScale"],
								["type"] = NS.Variables.Config.TYPE_RANGE,
								["descriptor"] = nil,
								["indent"] = 0,
								["var_range_min"] = .5,
								["var_range_max"] = 2,
								["var_range_step"] = .1,
								["var_range_text"] = function(value) return string.format("%.0f", value * 100) .. "%" end,
								["var_range_set_lazy"] = function(value) CallbackRegistry:Trigger("CONFIG_PINPOINT_SCALE") end,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_PINPOINT_SCALE end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_PINPOINT_SCALE = value end,
								["var_disabled"] = function() return false end,
								["var_hidden"] = function() return false end,
							},
							[2] = {
								["name"] = L["Config - Appearance - WaypointSystem - PinpointDetail"],
								["type"] = NS.Variables.Config.TYPE_CHECKBOX,
								["descriptor"] = NS.Variables.Config:NewDescriptor(nil, nil, L["Config - Appearance - WaypointSystem - PinpointDetail - Description"]),
								["indent"] = 0,
								["var_get"] = function() return GetDatabase("DB_GLOBAL").WS_PINPOINT_DETAIL end,
								["var_set"] = function(value) GetDatabase("DB_GLOBAL").WS_PINPOINT_DETAIL = value end,
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
