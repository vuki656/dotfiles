local wibox = require("wibox")

local helpers = require("utils.helpers")

return helpers.create_topbar_button({
    {
        widget = wibox.widget.textclock(),
        font = "Montserrat Bold 10",
        format = "   %a %b %d, %H:%M",
    },
    layout = wibox.layout.fixed.horizontal,
})
