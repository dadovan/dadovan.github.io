local Common = {}

function Common.Init()
    reaper.ShowConsoleMsg("")
end

function Common.LogInfo(message)
    if debug then
        if message == nil then
            reaper.ShowConsoleMsg("\n")
        else
            reaper.ShowConsoleMsg(message .. "\n")
        end
    end
end

function Common.GetCurrentScripPath()
    return ({reaper.get_action_context()})[2]:match("^(.*[/\\])")
end

return Common
