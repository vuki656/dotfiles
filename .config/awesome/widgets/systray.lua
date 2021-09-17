local wibox = require("wibox")

local helpers = require("utils.helpers")

return helpers.create_topbar_button({
    {
        widget = wibox.widget.systray(),
        font = "Montserrat Bold 5",
    },
    layout = wibox.layout.fixed.horizontal,
})
