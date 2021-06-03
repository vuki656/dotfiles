----------------------------------------------------------------------------------------------
--------------------------------------- WINDOW SETTINGS --------------------------------------
----------------------------------------------------------------------------------------------

local awful = require("awful")
local keys = require('keys')

-- Rules to apply to all windows
local all = { 
        rule = { },
        properties = { 
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.client_keys,
            buttons = keys.client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
}

-- Rules to apply to floating windows
local floating = {
    rule_any = {
        instance = {},
        class = {},
        name = {},
        role = {}
    },
    properties = { floating = true }
}

-- Rules to apply to any windows
local any = {
    rule_any = {
        type = { 
            "normal",
            "dialog"
        }
    },
    properties = { titlebars_enabled = true }
}

awful.rules.rules = {
    all,
    floating,
    any,
}
