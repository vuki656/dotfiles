----------------------------------------------------------------------------------------------
----------------------------- BAR DISPLAYED AT THE TOP OF WORKSPACE --------------------------
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

awful.screen.connect_for_each_screen(function(screen)
    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, 
        screen,
        awful.layout.layouts[1]
    )

    -- Create topbar
    screen.mywibox = awful.wibar({ 
        position = "top",
        screen = screen,
        bg = beautiful.bg_normal .. "00",
        height = 25,
    })
                          
    -- Create taglist
    screen.mytaglist = awful.widget.taglist {
        screen  = screen,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout  = {
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
        },
    }

    -- Create taglist
    screen.mytasklist = awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = keys.tasklist_buttons,
        style = {
            shape  = gears.shape.rounded_bar,
            bg_normal = colors.transparent,
            bg_focus = colors.transparent,
            bg_minimize = colors.transparent,
        },
    }

    -- Configure left side widgets
    local left_widgets = { 
        screen.mytaglist,
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
        layout = wibox.container.margin,
    }

    screen.layout_button = awful.widget.layoutbox(s)
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

    -- Configure middle widgets
    local middle_widgets = gears.table.join(screen.mytasklist)

    -- Configure right side widgets
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
        screen.layout_button,
        logout_menu_widget(),
    }

    screen.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        top = 5, 
        bottom = 5,
        left_widgets,
        middle_widgets,
        right_widgets
    }
end)

