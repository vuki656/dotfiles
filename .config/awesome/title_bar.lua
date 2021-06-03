----------------------------------------------------------------------------------------------
---------------------- BAR DISPLAYED AT THE TOP OF WINDOW ------------------------------------
----------------------------------------------------------------------------------------------

local keys = require('keys')
local awful = require("awful")
local wibox = require("wibox")

client.connect_signal("request::titlebars", function(client)
    local left_section = { 
        layout  = wibox.layout.fixed.horizontal,
        buttons = keys.client_toolbar_buttons(client)
    }

    local midddle_section = { 
        buttons = keys.client_toolbar_buttons(client),
        layout  = wibox.layout.flex.horizontal
    }

    local right_section = {
        layout = wibox.layout.fixed.horizontal(),
        awful.titlebar.widget.floatingbutton(client),
        awful.titlebar.widget.maximizedbutton(client),
        awful.titlebar.widget.closebutton(client),
    }

    local style = {
        bg_normal = '#1a1a1b85',
        bg_focus = '#1a1a1bab',
        size = 20,
    }

    awful.titlebar(client, style) : setup {
        left_section,
        midddle_section,
        right_section,
        layout = wibox.layout.align.horizontal
    }
end)
