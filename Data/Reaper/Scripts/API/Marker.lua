local Common = require ('API.Common')
local Take = require ('API.Take')

local Marker = {}
Marker.__index = Marker

function Marker:Create(markerIndex)
    local m = {}
    setmetatable(m, Marker)
    local _, isRegion, markerPos, regionEnd, markerName, markerRegionIndex =  reaper.EnumProjectMarkers(markerIndex)
    m.Index = markerIndex
    m.Name = markerName
    m.IsRegion = isRegion
    m.Position = markerPos
    m.PositionEnd = regionEnd
    m.RegionIndex = markerRegionIndex
    return m
end

function Marker:ToString()
    local type = ""
    if self.IsRegion == true then
        type = "Region"
    else
        type = "Marker"
    end
    return type .. " { Index=" .. self.Index .. ", Name='" .. self.Name .. "', Position=" .. self.Position .. ", PositionEnd=" .. self.PositionEnd .. " }"
end

function Marker:GetStartingRegionForMediaItem(item)
    local take = Take:Create(reaper.GetActiveTake(item))
    Common.LogInfo(take:ToString())

    countMarkers, _ = reaper.CountProjectMarkers(0)
    for markerIndex = 0, countMarkers - 1 do
        local marker = Marker:Create(markerIndex)

        if marker.IsRegion == true then
            if (marker.Position <= take.Position) and (marker.PositionEnd >= take.Position) then
                Common.LogInfo(" > " .. marker:ToString())

                return marker
            end
        end

        markerIndex = markerIndex + 1
    end
end

return Marker
