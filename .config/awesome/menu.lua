----------------------------------------------------------------------------------------------
--------------------------------------- RIGHT CLICK MENU -------------------------------------
----------------------------------------------------------------------------------------------

pcall(require, "luarocks.loader")

local has_fdo, freedesktop = pcall(require, "freedesktop")
local awful = require("awful")
local keys = require('keys')

-- Build custom menu buttons
local main_menu = freedesktop.menu.build({
    before = { 
        { 
            "System",
            {
                { 
                    "Restart",
                    awesome.restart 
                },
                { 
                    "Quit",
                    function() 
                        awesome.quit()
                    end
                },
                {
                    "Edit Config",
                    'gedit' .. " " .. awesome.conffile
                }
            }
        },
    },
})

-- Register menu
root.buttons(
    awful.button(
        {},
        keys.mouse_buttons.right,
        function () 
            main_menu:toggle()
        end
    )
)

