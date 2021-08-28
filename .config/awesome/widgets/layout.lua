local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local helpers = require("utils.helpers")
local keys = require("keys")

local function layout_button(screen)
    screen.layout_button = awful.widget.layoutbox(screen)

    screen.layout_button:buttons(gears.table.join(
        awful.button({}, keys.mouse_buttons.left, function()
            awful.layout.inc(1)
        end),
        awful.button({}, keys.mouse_buttons.right, function()
            awful.layout.inc(-1)
        end)
    ))

    return helpers.create_topbar_button({
        screen.layout_button,
        layout = wibox.layout.fixed.horizontal,
    })
end

return layout_button
