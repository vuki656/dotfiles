----------------------------------------------------------------------------------------------
----------------------------- BAR DISPLAYED ABOVE THE WINDOW ---------------------------------
----------------------------------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require('keys')

local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

local colors = {
    transparent = '#2f282829'
}

awful.screen.connect_for_each_screen(function(s)
    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, 
        s,
        awful.layout.layouts[1]
    )
                          
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout  = {
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
        },
    }

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = keys.tasklist_buttons,
        style = {
            shape  = gears.shape.rounded_bar,
            bg_normal = colors.transparent,
            bg_focus = colors.transparent,
            bg_minimize = colors.transparent,
        },
    }

    s.mywibox = awful.wibar({ 
        position = "top",
        screen = s,
        bg = beautiful.bg_normal .. "00",
        height = 25,
    })

    local left_widgets = { 
        s.mytaglist,
        s.mypromptbox,
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
        layout = wibox.container.margin,
    }

    s.layout_button = awful.widget.layoutbox(s)
    s.layout_button:buttons(
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

    local middle_widgets = gears.table.join(s.mytasklist)

    local right_widgets = { 
        layout = wibox.layout.fixed.horizontal,
        volume_widget({ widget_type = "arc" }),
        weather_widget({
            api_key='d8ec854f0c75c3d11b05badeda7346f6',
            coordinates = { 45.774867,  15.996309 },
            time_format_12h = true,
            units = 'metric',
            show_hourly_forecast = true,
        }),
        wibox.widget.textclock(),
        s.layout_button,
        logout_menu_widget(),
    }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        top = 5, 
        bottom = 5,
        left_widgets,
        middle_widgets,
        right_widgets
    }
end)

