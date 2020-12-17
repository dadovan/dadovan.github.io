local Config = {}

function Config._getConfigPrefix()
    return "donovans."
end

function Config.GetValueOrDefault(module, key, default)
    local configValue = reaper.GetExtState(Config:_getConfigPrefix() .. module, key)
    if (configValue == nil) or (configValue == "") then
        return default
    end
    return configValue
end

function Config.SetValue(module, key, value)
    reaper.SetExtState(Config:_getConfigPrefix() .. module, key, value, true)
end

return Config
