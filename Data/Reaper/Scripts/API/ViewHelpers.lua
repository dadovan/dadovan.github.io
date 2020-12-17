local Common = require('API.Common')
local Config = require('API.Config')
local Track = require('API.Track')

local ViewHelpers = {}

function ViewHelpers.SetToTight(expandCurrent)
    local smallMcpLayout = Config.GetValueOrDefault("Global", "SmallMCPLayout", "Narrow")
    local mediumMcpLayout = Config.GetValueOrDefault("Global", "MediumMCPLayout", "Large")
    local separatorMcpLayout = Config.GetValueOrDefault("Global", "SeparatorMcpLayout", "MCP Small Separator")

    local smallTcpLayout = Config.GetValueOrDefault("Global", "SmallTCPLayout", "Default TCP")
    local mediumTcpLayout = Config.GetValueOrDefault("Global", "MediumTCPLayout", "Default TCP")

    Track:ForEachTrack(function(track)
        Common.LogInfo(track:ToString())

        if track.Name == "# Misc" and track.FxCount <= 0 then -- TODO: Make a configurable list
            track:SetHeightOverride(track.TrackHeightTiny, true)
            reaper.BR_SetMediaTrackLayouts(track.Track, separatorMcpLayout, smallTcpLayout)
        else
            local itemCount = reaper.GetTrackNumMediaItems(track.Track)
            if itemCount == 0 then
                track:SetHeightOverride(track.TrackHeightTiny, true)
                reaper.BR_SetMediaTrackLayouts(track.Track, mediumMcpLayout, smallTcpLayout)
            else
                if (expandCurrent == true) and (track.IsSelected == true) then
                    if (track.HeightOverride == track.TrackHeightMedium) then
                        track:SetHeightOverride(track.TrackHeightSmall, true)
                    else
                        track:SetHeightOverride(track.TrackHeightMedium, true)
                    end
                else
                    track:SetHeightOverride(track.TrackHeightSmall, true)
                end
                reaper.BR_SetMediaTrackLayouts(track.Track, smallMcpLayout, mediumTcpLayout)
            end
        end
    end)

    reaper.TrackList_AdjustWindows(false)
    reaper.UpdateArrange()
end

return ViewHelpers
