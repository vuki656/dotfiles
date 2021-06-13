----------------------------------------------------------------------------------------------
----------------------------- BAR DISPLAYED AT THE TOP OF WORKSPACE --------------------------
----------------------------------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local keys   = require('keys')
local colors = require('utils.colors')

local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local temperature_widget = require("widgets.temperature")
local volume_widget      = require('awesome-wm-widgets.volume-widget.volume')

awful.screen.connect_for_each_screen(function(screen)
    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, 
        screen,
        awful.layout.layouts[1]
    )

    -- Create topbar
    screen.mywibox = awful.wibar({ 
        position = "top",
        screen   = screen,
        bg       = colors.blue_light_transparet,
        height   = 30,
    })

    -- Create taglist
    screen.mytaglist = awful.widget.taglist {
        screen  = screen,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout   = {
            spacing = 5,
            layout  = wibox.layout.flex.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 8,
                right = 8,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
        style = {
            font = "11",
            bg_occupied = colors.transparent,
            bg_empty = colors.transparent,
            bg_focus = colors.green,
            fg_empty = colors.white,
            fg_occupied = colors.white,
            fg_focus = colors.blue_dark,
            shape = function(cairo, width, height)
                gears.shape.rounded_rect(cairo, width, height, 3)
            end
        },
    }

    -- Create tasklist
    screen.mytasklist = awful.widget.tasklist {
        screen  = screen,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = keys.tasklist_buttons,
        style = {
            tasklist_disable_icon = true,
            bg_normal             = colors.transparent,
            bg_focus              = colors.transparent,
            bg_minimize           = colors.transparent,
            fg_normal             = colors.white,
            fg_forcus             = colors.white,
            fg_minimize           = colors.white,
        },
    }

    -- Configure left side widgets
    local left_widgets = { 
        screen.mytaglist,
        left   = 5,
        right  = 5,
        top    = 5,
        bottom = 5,
        layout = wibox.container.margin,
    }

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

    -- Configure middle widgets
    local middle_widgets = gears.table.join(screen.mytasklist)

    -- Configure right side widgets
    local right_widgets = { 
        layout = wibox.layout.fixed.horizontal,
        volume_widget({ widget_type = "arc" }),
        temperature_widget(),
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

