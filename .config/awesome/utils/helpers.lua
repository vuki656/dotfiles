local gears = require("gears")
local wibox = require("wibox")

local colors = require("utils.colors")

local module = {}

module.create_topbar_button = function(content)
    return {
        {
            {
                content,
                left = 5,
                right = 5,
                top = 5,
                bottom = 5,
                widget = wibox.container.margin,
            },
            layout = wibox.container.background,
            bg = colors.blue_dark_transparent,
            fg = colors.white,
            shape = function(cairo, width, height)
                gears.shape.rounded_rect(cairo, width, height, 3)
            end,
        },
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
        layout = wibox.container.margin,
    }
end

return module
