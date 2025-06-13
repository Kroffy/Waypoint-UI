---@class addon
local addon = select(2, ...)
local NS = addon.C.AddonInfo; addon.C.AddonInfo = NS

--------------------------------

NS.Variables = NS.Variables or {}
NS.Variables.Database = {}

--------------------------------
-- VARIABLES
--------------------------------

do -- MAIN

end

do -- CONSTANTS
	do -- REFERENCES
		NS.Variables.Database.GLOBAL_REFERENCE = WaypointDB_Global
		NS.Variables.Database.LOCAL_REFERENCE = WaypointDB_Local
		NS.Variables.Database.GLOBAL_PERSISTENT_REFERENCE = WaypointDB_Global_Persistent
		NS.Variables.Database.LOCAL_PERSISTENT_REFERENCE = WaypointDB_Local_Persistent

		NS.Variables.Database.GLOBAL_NAME = "WaypointDB_Global"
		NS.Variables.Database.LOCAL_NAME = "WaypointDB_Local"
		NS.Variables.Database.GLOBAL_PERSISTENT_NAME = "WaypointDB_Global_Persistent"
		NS.Variables.Database.LOCAL_PERSISTENT_NAME = "WaypointDB_Local_Persistent"
	end

	do -- DEFAULTS
		NS.Variables.Database.GLOBAL_DEFAULT = {
			profile = {
				-- WAYPOINT SYSTEM
				WS_TYPE = 1,
				WS_DISTANCE_TRANSITION = 225,
				WS_DISTANCE_HIDE = 25,
				WS_WAYPOINT_SCALE = 1,
				WS_WAYPOINT_MIN_SCALE = .25,
				WS_WAYPOINT_MAX_SCALE = 1.5,
				WS_PINPOINT_SCALE = 1,
				WS_PINPOINT_DETAIL = false,

				-- AUDIO
				AUDIO_GLOBAL = true,

				-- PREFERENCES
				PREF_METRIC = false,
			},
		}

		NS.Variables.Database.LOCAL_DEFAULT = {
			profile = {

			}
		}

		NS.Variables.Database.GLOBAL_PERSISTENT_DEFAULT = {
			profile = {

			}
		}

		NS.Variables.Database.LOCAL_PERSISTENT_DEFAULT = {
			profile = {
				SAVED_WAY = nil
			}
		}
	end
end
