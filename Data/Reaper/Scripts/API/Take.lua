local Take = {}
Take.__index = Take

function Take:Create(take)
    local t = {}
    setmetatable(t, Take)
    t.Take = take
    t.Name = reaper.GetTakeName(take)
    local item = reaper.GetMediaItemTakeInfo_Value(take, "P_ITEM")
    t.Position = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    return t
end

function Take:ToString()
    return "Take { Name='" .. self.Name .. "', Position=" .. self.Position .. " }"
end

return Take
