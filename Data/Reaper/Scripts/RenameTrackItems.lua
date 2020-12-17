package.path = debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "?.lua;" .. package.path
local Common = require('API.Common')
local Marker = require('API.Marker')
local Take = require('API.Take')
local Track = require('API.Track')

debug = false
Common.Init()

-- --------------------------------------------------------------------------------------------------------------------------------------------------

local trackCount = reaper.CountTracks(0)
for trackIndex = 0, trackCount - 1 do
    local track = Track:Create(reaper.GetTrack(0, trackIndex))
    Common.LogInfo(track:ToString())
    Common.LogInfo()
  
    local lastRegionName = ""
    local nextId = 1
    local itemCount = reaper.GetTrackNumMediaItems(track.Track)
    for itemIndex = 0, itemCount - 1 do
        local item = reaper.GetTrackMediaItem(track.Track, itemIndex)

        local marker = Marker:GetStartingRegionForMediaItem(item)
        if lastRegionName == marker.Name then
            nextId = nextId + 1
        else
            nextId = 1
        end
        lastRegionName = marker.Name
        local newTakeName = "" .. track.Name .. " - " .. marker.Name .. " - " .. nextId

        local take = reaper.GetActiveTake(item)
        reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", newTakeName, 1)
        Common.LogInfo(" > Renamed to: " .. newTakeName)

        Common.LogInfo()
    end

    Common.LogInfo()
end
