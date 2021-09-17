----------------------------------------------------------------------------------------------
----------------------------- BAR DISPLAYED AT THE TOP OF WORKSPACE --------------------------
----------------------------------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local keys = require("keys")
local colors = require("utils.colors")

local logout_menu_widget = require("widgets.shutdown_menu")
local temperature_widget = require("widgets.temperature")
local layout_widget = require("widgets.layout")
local systray = require("widgets.systray")
local clock_widget = require("widgets.clock")
local battery_widget = require("widgets.battery_indicator")

local volume_widget = require("awesome-wm-widgets.volume-widget.volume")

awful.screen.connect_for_each_screen(function(screen)
    awful.tag({ "  ", "  ", " ", " ", " "}, screen,  awful.layout.layouts[1])

    -- Create topbar
    screen.mywibox = awful.wibar({
        position = "top",
        screen = screen,
        bg = colors.blue_dark,
        height = 30,
    })

    -- Create taglist
    screen.mytaglist = awful.widget.taglist({
        screen = screen,
        filter = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout = {
            spacing = 5,
            layout = wibox.layout.flex.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        widget = wibox.container.place,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    widget = wibox.container.place,
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = wibox.container.place,
                forced_width = 35,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
        style = {
            bg_occupied = colors.transparent,
            bg_empty = colors.transparent,
            bg_focus = colors.green,
            fg_empty = colors.white,
            fg_occupied = colors.white,
            fg_focus = colors.blue_dark,
            shape = function(cairo, width, height)
                gears.shape.rounded_rect(cairo, width, height, 3)
            end,
        },
    })

    -- Create tasklist
    screen.mytasklist = awful.widget.tasklist({
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = keys.tasklist_buttons,
        style = {
            tasklist_disable_icon = true,
            bg_normal = colors.transparent,
            bg_focus = colors.transparent,
            bg_minimize = colors.transparent,
            fg_normal = colors.white,
            fg_focus = colors.white,
            fg_minimize = colors.white,
        },
    })

    -- Configure left side widgets
    local left_widgets = {
        screen.mytaglist,
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
        layout = wibox.container.margin,
    }

    -- Configure middle widgets
    local middle_widgets = gears.table.join(screen.mytasklist)

    -- Configure right side widgets
    local right_widgets = {
        layout = wibox.layout.fixed.horizontal,
        volume_widget({ widget_type = "horizontal_bar" }),
        logout_menu_widget(),
        temperature_widget(),
        clock_widget,
        systray,
        layout_widget(screen),
        battery_widget({}),
    }

    screen.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        top = 5,
        bottom = 5,
        left_widgets,
        middle_widgets,
        right_widgets,
    })
end)
