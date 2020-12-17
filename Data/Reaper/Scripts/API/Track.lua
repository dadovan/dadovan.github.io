local Common = require ('API.Common')

local Track = {}
Track.__index = Track

function Track:Create(track)
    local t = {}
    setmetatable(t, Track)
    local _, trackName = reaper.GetTrackName(track)
    t.Track = track
    t.Name = trackName
    t.IsSelected = reaper.IsTrackSelected(track)
    t.FolderDepth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
    t.HeightOverride = reaper.GetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE")
    t.FxCount = reaper.TrackFX_GetCount(track)

    t.TrackHeightTiny = 10
    t.TrackHeightSmall = 75
    t.TrackHeightMedium = 150
    t.TrackHeightLarge = 300
    return t
end

function Track:ToString()
    return "Track { Name='" .. self.Name .. "', IsSelected=" .. tostring(self.IsSelected) .. " }"
end

function Track:SetHeightOverride(height, updateEnvelopes)
    reaper.SetMediaTrackInfo_Value(self.Track, "I_HEIGHTOVERRIDE", height)
    if updateEnvelopes then
        Common.LogInfo("Type: " .. type(self))
        -- self.SetEnvelopeHeights(height)
    end
end

function Track:ForEachTrack(forEachTrack)
    local trackCount = reaper.CountTracks(0)
    for trackIndex = 0, trackCount - 1 do
        local track = Track:Create(reaper.GetTrack(0, trackIndex))
        forEachTrack(track)
    end
end

function SetEnvelopeHeight(envelope, height) -- TODO: Cleanup
    local BR_env = reaper.BR_EnvAlloc(envelope, false)
    local active, visible, armed, inLane, _, defaultShape, _, _, _, _, faderScaling = reaper.BR_EnvGetProperties( BR_env )
    reaper.BR_EnvSetProperties( BR_env, active, visible, armed, inLane, height, defaultShape, faderScaling )
    reaper.BR_EnvFree( BR_env, true )
end

function Track:SetEnvelopeHeights(height)
    Common.LogInfo("Type: " .. type(self))
    local envelopeCount = reaper.CountTrackEnvelopes(self.Track)
    if envelopeCount > 0 then
        Common.LogInfo("There are " .. envelopeCount .. " envelopes for this track")
        for envelopeIndex = 0, envelopeCount - 1 do
            local env = reaper.GetTrackEnvelope(self.Track, envelopeIndex)
            SetEnvelopeHeight(env, 200)
        end
    end
end

return Track
