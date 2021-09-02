local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local HOME = os.getenv("HOME")
local ICON_DIR = HOME .. "/.config/awesome/images/"

local keys = require("keys")
local colors = require("utils.colors")

local trigger_icon = wibox.widget({
    {
        {
            {
                {
                    image = ICON_DIR .. "shutdown.png",
                    resize = true,
                    widget = wibox.widget.imagebox,
                    forced_height = 12,
                    forced_width = 12,
                },
                layout = wibox.container.margin(trigger_icon, 0, 0, 4),
            },
            left = 5,
            right = 5,
            widget = wibox.container.margin,
        },
        layout = wibox.container.background,
        bg = colors.blue_dark_transparent,
        fg = colors.blue_dark,
        shape = function(cairo, width, height)
            gears.shape.rounded_rect(cairo, width, height, 3)
        end,
    },
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
    layout = wibox.container.margin,
})

local popup = awful.popup({
    ontop = true,
    visible = false,
    shape = function(cairo, width, height)
        gears.shape.rounded_rect(cairo, width, height, 4)
    end,
    bg = colors.blue_dark_transparent,
    fg = colors.white,
    maximum_width = 400,
    offset = { y = 3 },
    widget = {},
})

local function worker()
    local rows = { layout = wibox.layout.fixed.vertical }

    local menu_items = {
        {
            name = "Log out",
            command = function()
                awesome.quit()
            end,
        },
        {
            name = "Lock",
            command = function()
                awful.spawn.with_shell("~/scripts/lock.sh")
            end,
        },
        {
            name = "Reboot",
            command = function()
                awful.spawn.with_shell("reboot")
            end,
        },
        {
            name = "Power off",
            command = function()
                awful.spawn.with_shell("shutdown now")
            end,
        },
    }

    for _, item in ipairs(menu_items) do
        local row = wibox.widget({
            {
                {
                    {
                        text = item.name,
                        widget = wibox.widget.textbox,
                    },
                    spacing = 12,
                    layout = wibox.layout.fixed.horizontal,
                },
                margins = 8,
                layout = wibox.container.margin,
            },
            bg = colors.blue_dark_transparent,
            widget = wibox.container.background,
        })

        -- Add highlight on mouse leave
        row:connect_signal("mouse::enter", function(client)
            client:set_bg(beautiful.bg_focus)
        end)

        -- Remove highlight on mouse leave
        row:connect_signal("mouse::leave", function(client)
            client:set_bg(beautiful.bg_normal)
        end)

        -- On item click execute command and hide popup
        row:buttons(awful.util.table.join(awful.button({}, keys.mouse_buttons.left, function()
            popup.visible = not popup.visible
            item.command()
        end)))

        table.insert(rows, row)
    end

    -- Hide popup on mouse leave
    popup:connect_signal("mouse::leave", function()
        popup.visible = false
    end)

    popup:setup(rows)

    trigger_icon:buttons(awful.util.table.join(awful.button({}, keys.mouse_buttons.left, function()
        if popup.visible then
            popup.visible = not popup.visible
        else
            popup:move_next_to(mouse.current_widget_geometry)
        end
    end)))

    return trigger_icon
end

return setmetatable(trigger_icon, {
    __call = function()
        return worker()
    end,
})
