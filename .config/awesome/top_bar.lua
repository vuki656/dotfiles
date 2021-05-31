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

local function set_wallpaper(s)
    awful.spawn.with_shell('feh --bg-scale ~/wallpapers/forest.jpg') 
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local taglist_buttons = gears.table.join(
    -- Switch to clicked tag
    awful.button(
        {},
        keys.mouse_buttons.left,
        function(tag)
            tag:view_only() 
        end
    ),
    -- Move focues window to clicked tag
    awful.button(
        { modkey },
        keys.mouse_buttons.left,
        function(tag)
            if client.focus then
                client.focus:move_to_tag(tag)
            end
        end
    ),
    -- Display windows from clicked tag in current screen on rmb click
    awful.button(
        {}, 
        keys.mouse_buttons.right,
        awful.tag.viewtoggle
    ),
    -- TODO: Description of what it does
    awful.button(
        { modkey },
        keys.mouse_buttons.right,
        function(tag)
            if client.focus then
                client.focus:toggle_tag(tag)
            end
        end
    ),
    -- Go to next tag on scroll up
    awful.button(
        {},
        keys.mouse_buttons.up,
        function(tag) 
            awful.tag.viewnext(tag.screen)
        end
    ),
    -- Go to previous tag on scroll down
    awful.button(
        {},
        keys.mouse_buttons.down,
        function(tag) 
            awful.tag.viewprev(tag.screen) 
        end
    )
)

local tasklist_buttons = gears.table.join(
    -- Toggle clicked window
    awful.button(
        {},
        keys.mouse_buttons.left,
        function (current_client)
            if current_client == client.focus then
                current_client.minimized = true
            else
                current_client:emit_signal(
                    "request::activate",
                    "tasklist",
                    { raise = true }
                )
            end
        end
    ),
    -- Open window menu on rmb click
    awful.button(
        {},
        keys.mouse_buttons.right,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    ),
    -- Focus next window on scroll up
    awful.button(
        {},
        keys.mouse_buttons.up,
        function ()
            awful.client.focus.byidx(1)
        end
    ),
    -- Focus previous window on scroll down
    awful.button(
        {},
        keys.mouse_buttons.down,
        function ()
            awful.client.focus.byidx(-1)
        end
    )
)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, 
        s,
        awful.layout.layouts[1]
    )

                          
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout  = {
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
        },
    }

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
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

