local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local colors = require('utils.colors')
local keys   = require('keys')

local function layout_button(screen)
    screen.layout_button = awful.widget.layoutbox(screen)

    screen.layout_button:buttons(
        gears.table.join(
            awful.button(
                {},
                keys.mouse_buttons.left,
                function ()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                keys.mouse_buttons.right,
                function ()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    return {
        {
            {
                {
                    screen.layout_button,
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 5,
                right = 5,
                top = 5,
                bottom = 5,
                widget = wibox.container.margin
            },
            layout = wibox.container.background,
            bg = colors.blue_dark_transparent,
            fg = colors.white,
            shape = function(cairo, width, height)
                gears.shape.rounded_rect(cairo, width, height, 3)
            end,
        },
        left   = 5,
        right  = 5,
        top    = 5,
        bottom = 5,
        layout = wibox.container.margin,

    }
end

return layout_button



