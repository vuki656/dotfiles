-- Imports
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")

-- Plugins
require("awful.autofocus")

-- Custom Config
require("utils.catch_errors")
require("menu")
require("sets")
require("top_bar")
require("title_bar")
require("rules")

-- Function to execute when a new client appears
client.connect_signal("manage", function(client)
    -- Round client corners
    client.shape = function(cairo, width, height)
        gears.shape.rounded_rect(cairo, width, height, 5)
    end

    --  Set client as slave if master exists, else make master
    if awesome.startup and not client.size_hints.user_position and not client.size_hints.program_position then
        awful.placement.no_offscreen(client)
    end
end)

-- Focus follows mouse across the screens
client.connect_signal("mouse::enter", function(client)
    client:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Focus client where mouse is
-- https://stackoverflow.com/a/52802148/11266179
function focus_client_under_mouse()
    gears.timer({
        timeout = 0.1,
        autostart = true,
        single_shot = true,
        callback = function()
            local n = mouse.object_under_pointer()
            if n ~= nil and n ~= client.focus then
                client.focus = n
            end
        end,
    })
end

screen.connect_signal("tag::history::update", focus_client_under_mouse)
