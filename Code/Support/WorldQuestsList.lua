local env             = select(2, ...)
local Support         = env.WPM:Import("@/Support")
local WorldQuestsList = env.WPM:New("@/Support/WorldQuestsList")



local function removeWQLSlashCmd()
    env.C.SlashCommand.Script:RemoveSlashCommand("WQLSlashWay")
end



local function OnAddonLoad()
    C_Timer.After(10, function()
        removeWQLSlashCmd()
    end)
end
Support:Add("WorldQuestsList", OnAddonLoad)
