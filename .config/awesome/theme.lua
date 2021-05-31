local beautiful = require("beautiful")
local gears = require("gears")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")     -- Set default theme
beautiful.useless_gap = 10                                                   -- Set window gap
beautiful.gap_single_client = true                                           -- Enable gaps for single window
