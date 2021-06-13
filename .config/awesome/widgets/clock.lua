local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local colors = require('utils.colors')

local widget = {
    {
        {
            {
                {
                    widget = wibox.widget.textclock(),
                    font = "Montserrat Bold 10"
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 5,
            right = 5,
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

return widget
