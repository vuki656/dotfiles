----------------------------------------------------------------------------------------------
--------------------------------- BUTTONS AND REMAPS -----------------------------------------
----------------------------------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local popup = require("awful.hotkeys_popup")

----------------------------------------------------------------------------------------------
--------------------------------------- CONFIG -----------------------------------------------
----------------------------------------------------------------------------------------------

local module = {}

module.mouse_buttons = {
    left = 1,
    middle = 2,
    right = 3,
    up = 4,
    down = 5
}

module.modkey = "Mod4"

module.key_groups = {
    apps = "Applications",
    awesome = "Awesome",
    current_screen = "Current Screen",
    current_window = "Current Window",
    tag = "Tag",
    screen = "Screen",
    prompts = "Prompts",
    other = "Other",
}

----------------------------------------------------------------------------------------------
-------------------------------------- TASKLIST BUTTONS ----------------------------------------
----------------------------------------------------------------------------------------------

module.tasklist_buttons = gears.table.join(
    -- Toggle visible/minimized on click
    awful.button(
        {},
        module.mouse_buttons.left,
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

    -- Open menu for task
    awful.button(
        {},
        module.mouse_buttons.right,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    ),

    -- Focus next task on scroll up
    awful.button(
        {},
        module.mouse_buttons.up,
        function ()
            awful.client.focus.byidx(1)
        end
    ),
    
    -- Focus previous task on scroll down
    awful.button(
        {}, 
        module.mouse_buttons.down,
        function ()
            awful.client.focus.byidx(-1)
        end
    )
)

----------------------------------------------------------------------------------------------
-------------------------------------- CLIENT BUTTONS ----------------------------------------
----------------------------------------------------------------------------------------------

module.client_buttons = gears.table.join(
    -- Focus and or toggle clicked client
    awful.button(
        {},
        module.mouse_buttons.left,
        function (client)
            client:emit_signal(
                "request::activate",
                "mouse_click",
                { raise = true } 
            )
        end
    ),

    -- Move client on click & drag anywhere in client
    awful.button(
        { module.modkey },
        module.mouse_buttons.left,
        function (client)
            client:emit_signal(
                "request::activate",
                "mouse_click",
                { raise = true }
            )

            awful.mouse.client.move(client)
        end
    ),

    -- Resize client on click & drag anywhere in client
    awful.button(
        { module.modkey },
        module.mouse_buttons.right,
        function (client)
            client:emit_signal(
                "request::activate",
                "mouse_click",
                { raise = true }
            )

            awful.mouse.client.resize(client)
        end
    )
)

----------------------------------------------------------------------------------------------
-------------------------------- CLIENT TOOLBAR BUTTONS --------------------------------------
----------------------------------------------------------------------------------------------

module.client_toolbar_buttons = function (client) 
    return gears.table.join(
        -- Move client on click & drag in toolbar
        awful.button(
            {},
            module.mouse_buttons.left,
            function()
                client:emit_signal(
                    "request::activate",
                    "titlebar",
                    { raise = true }
                )

                awful.mouse.client.move(client)
            end
        ),

        -- Resize client on click & drag in toolbar
        awful.button(
            {},
            module.mouse_buttons.right,
            function()
                client:emit_signal(
                    "request::activate",
                    "titlebar",
                    { raise = true }
                )

                awful.mouse.client.resize(client)
            end
        )
    )
end

----------------------------------------------------------------------------------------------
------------------------------------- TAG LIST BUTTONS ---------------------------------------
----------------------------------------------------------------------------------------------

module.taglist_buttons = gears.table.join(
    -- Switch to clicked tag
    awful.button(
        {},
        module.mouse_buttons.left,
        function(tag)
            tag:view_only() 
        end
    ),
    
    -- Move focues window to clicked tag
    awful.button(
        { module.modkey },
        module.mouse_buttons.left,
        function(tag)
            if client.focus then
                client.focus:move_to_tag(tag)
            end
        end
    ),

    -- Display windows from clicked tag in current screen on rmb click
    awful.button(
        {}, 
        module.mouse_buttons.right,
        awful.tag.viewtoggle
    ),

    -- TODO: Description of what it does
    awful.button(
        { module.modkey },
        module.mouse_buttons.right,
        function(tag)
            if client.focus then
                client.focus:toggle_tag(tag)
            end
        end
    ),

    -- Go to next tag on scroll up
    awful.button(
        {},
        module.mouse_buttons.up,
        function(tag) 
            awful.tag.viewnext(tag.screen)
        end
    ),

    -- Go to previous tag on scroll down
    awful.button(
        {},
        module.mouse_buttons.down,
        function(tag) 
            awful.tag.viewprev(tag.screen) 
        end
    )
)

----------------------------------------------------------------------------------------------
--------------------------------------- CLIENT KEY -------------------------------------------
----------------------------------------------------------------------------------------------

module.client_keys = gears.table.join(
    awful.key(
        { module.modkey },
        "f",
        function (client)
            client.fullscreen = not client.fullscreen
            client:raise()
        end,
        { 
            description = "Toggle currently selected window fullscreen",
            group = module.key_groups.current_window
        }
     ),

    awful.key(
        { 
            module.modkey,
            "Shift"   
        },
        "c",
        function (client) 
            client:kill()                         
        end,
        { 
            description = "Close currently selected window",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        {
            module.modkey,
            "Control"
        },
        "space",
        awful.client.floating.toggle,
        { 
            description = "Toggle currently selected window to floating",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        {
            module.modkey,
            "Control"
        },
        "Return",
        function (client) 
            client:swap(awful.client.getmaster())
        end,
        { 
            description = "Make currently selected window master",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { module.modkey },
        "o",
        function (client) 
            client:move_to_screen()               
        end,
        { 
            description = "Move currently selected window to next screen",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { module.modkey },
        "t",
        function (client) 
            client.ontop = not client.ontop
        end,
        { 
            description = "Toggle current selected window on top",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { module.modkey },
        "n",
        function (client)
            client.minimized = true
        end,
        { 
            description = "Minimize currently selected window",
            group = module.key_groups.current_window
        }
     ),

    awful.key(
        { module.modkey },
        "m",
        function (client)
            client.maximized = not client.maximized
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        {
            module.modkey,
            "Control" 
        },
        "m",
        function (client)
            client.maximized_vertical = not client.maximized_vertical
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window vertically",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Shift"
        },
        "m",
        function (client)
            client.maximized_horizontal = not client.maximized_horizontal
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window horizontally",
            group = module.key_groups.current_window
        }
    )
)

----------------------------------------------------------------------------------------------
--------------------------------------- GLOBAL KEYS ------------------------------------------
----------------------------------------------------------------------------------------------

module.global_keys = gears.table.join(
    awful.key(
        { module.modkey },
        "c",
        function () 
            awful.util.spawn_with_shell("google-chrome --password-store=gnome")
        end,
        { 
            description = "Start chrome",
            group = module.key_groups.apps
        }
    ),

    awful.key(
        { module.modkey },
        "s",
        popup.show_help,
        { 
            description="Open key combo help",
            group = module.key_groups.other
        }
    ),

    awful.key(
        { module.modkey },
        "Left",
        awful.tag.viewprev,
        { 
            description = "Go to previous desktop",
            group = module.key_groups.tag
        }
    ),

    awful.key(
        { module.modkey },
        "Right",
        awful.tag.viewnext,
       { 
           description = "Go to next tag",
           group = module.key_groups.tag
       }
    ),

    awful.key(
        { module.modkey }, 
        "Escape",
        awful.tag.history.restore,
        { 
            description = "Go to last visited tag",
            group = module.key_groups.tag
        }
    ),

    awful.key(
        { module.modkey },
        "j",
        function ()
            awful.client.focus.byidx(-1)
        end,
        { 
            description = "Focus previous window in current screen",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { module.modkey },
        "k",
        function ()
            awful.client.focus.byidx(1)
        end,
        { 
            description = "Focus next window in current screen",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Shift"
        },
        "j",
        function () 
            awful.client.swap.byidx(-1)
        end,
        { 
            description = "Swap with previous window in current screen",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Shift"
        },
        "k",
        function () 
            awful.client.swap.byidx(1)
        end,
        { 
            description = "Swap with next window in current screen",
            group = module.key_groups.current_screen
        }
     ),

    awful.key(
        { 
            module.modkey,
            "Control"
        },
        "j",
        function () 
            awful.screen.focus_relative(-1)
        end,
        { 
            description = "Focus previous screen",
            group = module.key_groups.screen
        }
    ),

    awful.key(
        {
            module.modkey,
            "Control"
        },
        "k",
        function () 
            awful.screen.focus_relative(1)
        end,
        { 
            description = "Focus next screen",
            group = module.key_groups.screen
        }
    ),

    awful.key(
        { module.modkey },
        "u",
        awful.client.urgent.jumpto,
        { 
            description = "Jump to urgent client",
            group = module.key_groups.other
        }
    ),

    awful.key(
        { module.modkey },
        "Tab",
        function ()
            awful.client.focus.history.previous()

            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = "Switch between windows in current screen",
            group = module.key_groups.current_screen
        }
     ),


    awful.key(
        { module.modkey },
        "Return",
        function () 
            awful.spawn('alacritty') 
        end,
        { 
            description = "Start terminal",
            group = module.key_groups.apps
        }
    ),

    awful.key(
       { 
           module.modkey,
           "Control"
       },
       "r",
       awesome.restart,
       { 
           description = "Restart awesome",
           group = module.key_groups.awesome
       }
     ),

    awful.key(
        { 
            module.modkey,
            "Shift"
        },
        "q",
        awesome.quit,
        { 
            description = "Quit awesome",
            group = module.key_groups.awesome
        }
     ),

    awful.key(
        { module.modkey },
        "l",
        function () 
            awful.tag.incmwfact(0.05)          
        end,
        { 
            description = "Increase current window width",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { module.modkey },
        "h",
        function () 
            awful.tag.incmwfact(-0.05)          
        end,
        { 
            description = "Decrease current window width",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Shift"
        },
        "h",
        function () 
            awful.tag.incnmaster(1, nil, true) 
        end,
        { 
            description = "Increase the number of master clients",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Shift"
        },
        "l",
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        { 
            description = "Decrease the number of master clients",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Control"
        },
        "h",
        function () 
            awful.tag.incncol(1, nil, true)    
        end,
        { 
            description = "Increase the number of columns",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { 
            module.modkey, 
            "Control"
        },
        "l",     
        function () 
            awful.tag.incncol(-1, nil, true)    
        end,
        { 
            description = "Decrease the number of columns",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { module.modkey },
        "space",
        function () 
            awful.layout.inc(1)                
        end,
        { 
            description = "Make selected window only one on the screen",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { 
            module.modkey, 
            "Shift"   
        },
        "space",
        function () 
            awful.layout.inc(-1)                
        end,
        { 
            description = "Return window from being the only one on desktop to that desktop layout",
            group = module.key_groups.current_window
        }
    ),

    awful.key(
        { 
            module.modkey,
            "Control"
        }, 
        "n",
        function ()
            local client = awful.client.restore()

            if client then
                client:emit_signal(
                    "request::activate",
                    "key.unminimize",
                    { raise = true }
                )
            end
        end,
        { 
            description = "Restore minimized window",
            group = module.key_groups.current_screen
        }
    ),

    awful.key(
        { module.modkey },
        "r",
        function () 
            awful.screen.focused().mypromptbox:run()
        end,
        { 
            description = "Open run prompt",
            group = module.key_groups.prompts
        }
    ),

    awful.key(
        { module.modkey },
        "x",
        function ()
            awful.prompt.run {
                prompt = "Run Lua Code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { 
            description = "Open lua execute prompt",
            group = module.key_groups.prompts
        }
    ),

    awful.key(
        { module.modkey },
        "p",
        function() 
            menubar.show() 
        end,
        { 
            description = "Open menubar",
            group = module.key_groups.other
        }
    )
)

-- Bind key numbers to tags
for i = 1, 9 do
    module.global_keys = gears.table.join(
        module.global_keys,

        awful.key(
            { module.modkey },
            "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    tag:view_only()
                end
            end,
            { 
                description = "Go to tag #" .. i,
                group = module.key_groups.tag
            }
        ),

        awful.key(
            { 
                module.modkey,
                "Control" 
            },
            "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
    
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {
                description = "Display tag #" .. i .. " in current tag",
                group = module.key_groups.tag
            }
        ),
    
        awful.key(
            {
                module.modkey,
                "Shift"
            },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
    
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {
                description = "Move focused window to tag #"..i,
                group = module.key_groups.tag
            }
        ),
    
        awful.key(
            {
                module.modkey,
                "Control",
                "Shift"
            },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
    
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {
                description = "Make currently selected window sticky on tag #" .. i,
                group = module.key_groups.tag
            }
        )
    )
end

-- Register global keys
root.keys(module.global_keys)

return module
