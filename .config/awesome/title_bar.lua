----------------------------------------------------------------------------------------------
---------------------- BAR DISPLAYED AT THE TOP OF WINDOW ------------------------------------
----------------------------------------------------------------------------------------------

local keys = require("keys")
local awful = require("awful")
local wibox = require("wibox")

local colors = require("utils.colors")

client.connect_signal("request::titlebars", function(client)
    local left_section = {
        layout = wibox.layout.fixed.horizontal,
        buttons = keys.client_toolbar_buttons(client),
    }

    local middle_section = {
        buttons = keys.client_toolbar_buttons(client),
        layout = wibox.layout.flex.horizontal,
    }

    local right_section = {
        layout = wibox.layout.fixed.horizontal(),
        awful.titlebar.widget.floatingbutton(client),
        awful.titlebar.widget.maximizedbutton(client),
        awful.titlebar.widget.closebutton(client),
    }

    local style = {
        bg_normal = colors.blue_light_transparet,
        bg_focus = colors.blue_dark_transparent,
        size = 20,
    }

    awful.titlebar(client, style):setup({
        left_section,
        middle_section,
        right_section,
        layout = wibox.layout.align.horizontal,
    })
end)
