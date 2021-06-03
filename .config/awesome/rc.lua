-- Imports
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")

-- Plugins
require("awful.autofocus")

-- Custom Config
require('utils.catch_errors')
require('menu')
require('sets')
require('top_bar')
require('title_bar')
require('rules')


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    c.shape = function(corner_radius, width, height)
        gears.shape.rounded_rect(corner_radius, width, height, 10)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Focus follows mouse across the screens
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
