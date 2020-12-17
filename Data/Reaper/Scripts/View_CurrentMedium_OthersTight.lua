package.path = debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "?.lua;" .. package.path
local Common = require('API.Common')
local ViewHelpers = require('API.ViewHelpers')

debug = false
Common.Init()

-- --------------------------------------------------------------------------------------------------------------------------------------------------

ViewHelpers.SetToTight(true)
