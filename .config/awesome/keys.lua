local gears = require("gears")
local awful = require("awful")
local popup = require("awful.hotkeys_popup")

local modkey = "Mod4"

local key_groups = {
    apps = "Applications",
    awesome = "Awesome",
    current_screen = "Current Screen",
    current_window = "Current Window",
    tag = "Tag",
    screen = "Screen",
    prompts = "Prompts",
    other = "Other",
}

clientkeys = gears.table.join(
    awful.key(
        { modkey },
        "f",
        function (client)
            client.fullscreen = not client.fullscreen
            client:raise()
        end,
        { 
            description = "Toggle currently selected window fullscreen",
            group = key_groups.current_window
        }
     ),

    awful.key(
        { 
            modkey,
            "Shift"   
        },
        "c",
        function (client) 
            client:kill()                         
        end,
        { 
            description = "Close currently selected window",
            group = key_groups.current_window
        }
    ),

    awful.key(
        {
            modkey,
            "Control"
        },
        "space",
        awful.client.floating.toggle,
        { 
            description = "Toggle currently selected window to floating",
            group = key_groups.current_window
        }
    ),

    awful.key(
        {
            modkey,
            "Control"
        },
        "Return",
        function (client) 
            client:swap(awful.client.getmaster())
        end,
        { 
            description = "Make currently selected window master",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "o",
        function (client) 
            client:move_to_screen()               
        end,
        { 
            description = "Move currently selected window to next screen",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "t",
        function (client) 
            client.ontop = not client.ontop
        end,
        { 
            description = "Toggle current selected window on top",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "n",
        function (client)
            client.minimized = true
        end,
        { 
            description = "Minimize currently selected window",
            group = key_groups.current_window
        }
     ),

    awful.key(
        { modkey },
        "m",
        function (client)
            client.maximized = not client.maximized
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window",
            group = key_groups.current_window
        }
    ),

    awful.key(
        {
            modkey,
            "Control" 
        },
        "m",
        function (client)
            client.maximized_vertical = not client.maximized_vertical
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window vertically",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "m",
        function (client)
            client.maximized_horizontal = not client.maximized_horizontal
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window horizontally",
            group = key_groups.current_window
        }
    )
)

globalkeys = gears.table.join(
    awful.key(
        { modkey },
        "c",
        function () 
            awful.util.spawn_with_shell("google-chrome --password-store=gnome")
        end,
        { 
            description = "Start chrome",
            group = key_groups.apps
        }
    ),

    awful.key(
        { modkey },
        "s",
        popup.show_help,
        { 
            description="Open key combo help",
            group = key_groups.other
        }
    ),

    awful.key(
        { modkey },
        "Left",
        awful.tag.viewprev,
        { 
            description = "Go to previous desktop",
            group = key_groups.tag
        }
    ),

    awful.key(
        { modkey },
        "Right",
        awful.tag.viewnext,
       { 
           description = "Go to next tag",
           group = key_groups.tag
       }
    ),

    awful.key(
        { modkey }, 
        "Escape",
        awful.tag.history.restore,
        { 
            description = "Go to last visited tag",
            group = key_groups.tag
        }
    ),

    awful.key(
        { modkey },
        "j",
        function ()
            awful.client.focus.byidx(-1)
        end,
        { 
            description = "Focus previous window in current screen",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { modkey },
        "k",
        function ()
            awful.client.focus.byidx(1)
        end,
        { 
            description = "Focus next window in current screen",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "j",
        function () 
            awful.client.swap.byidx(-1)
        end,
        { 
            description = "Swap with previous window in current screen",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "k",
        function () 
            awful.client.swap.byidx(1)
        end,
        { 
            description = "Swap with next window in current screen",
            group = key_groups.current_screen
        }
     ),

    awful.key(
        { 
            modkey,
            "Control"
        },
        "j",
        function () 
            awful.screen.focus_relative(-1)
        end,
        { 
            description = "Focus previous screen",
            group = key_groups.screen
        }
    ),

    awful.key(
        {
            modkey,
            "Control"
        },
        "k",
        function () 
            awful.screen.focus_relative(1)
        end,
        { 
            description = "Focus next screen",
            group = key_groups.screen
        }
    ),

    awful.key(
        { modkey },
        "u",
        awful.client.urgent.jumpto,
        { 
            description = "Jump to urgent client",
            group = key_groups.other
        }
    ),

    awful.key(
        { modkey },
        "Tab",
        function ()
            awful.client.focus.history.previous()

            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = "Switch between windows in current screen",
            group = key_groups.current_screen
        }
     ),


    awful.key(
        { modkey },
        "Return",
        function () 
            awful.spawn(terminal) 
        end,
        { 
            description = "Start terminal",
            group = key_groups.apps
        }
    ),

    awful.key(
       { 
           modkey,
           "Control"
       },
       "r",
       awesome.restart,
       { 
           description = "Restart awesome",
           group = key_groups.awesome
       }
     ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "q",
        awesome.quit,
        { 
            description = "Quit awesome",
            group = key_groups.awesome
        }
     ),

    awful.key(
        { modkey },
        "l",
        function () 
            awful.tag.incmwfact(0.05)          
        end,
        { 
            description = "Increase current window width",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "h",
        function () 
            awful.tag.incmwfact(-0.05)          
        end,
        { 
            description = "Decrease current window width",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "h",
        function () 
            awful.tag.incnmaster(1, nil, true) 
        end,
        { 
            description = "Increase the number of master clients",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "l",
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        { 
            description = "Decrease the number of master clients",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Control"
        },
        "h",
        function () 
            awful.tag.incncol(1, nil, true)    
        end,
        { 
            description = "Increase the number of columns",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey, 
            "Control"
        },
        "l",     
        function () 
            awful.tag.incncol(-1, nil, true)    
        end,
        { 
            description = "Decrease the number of columns",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { modkey },
        "space",
        function () 
            awful.layout.inc(1)                
        end,
        { 
            description = "Make selected window only one on the screen",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey, 
            "Shift"   
        },
        "space",
        function () 
            awful.layout.inc(-1)                
        end,
        { 
            description = "Return window from being the only one on desktop to that desktop layout",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey,
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
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { modkey },
        "r",
        function () 
            awful.screen.focused().mypromptbox:run()
        end,
        { 
            description = "Open run prompt",
            group = key_groups.prompts
        }
    ),

    awful.key(
        { modkey },
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
            group = key_groups.prompts
        }
    ),

    awful.key(
        { modkey },
        "p",
        function() 
            menubar.show() 
        end,
        { 
            description = "Open menubar",
            group = key_groups.other
        }
    )
)

-- Bind key numbers to tags
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,

        awful.key(
            { modkey },
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
                group = key_groups.tag
            }
        ),

        awful.key(
            { 
                modkey,
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
                group = key_groups.tag
            }
        ),
    
        awful.key(
            {
                modkey,
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
                group = key_groups.tag
            }
        ),
    
        awful.key(
            {
                modkey,
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
                group = key_groups.tag
            }
        )
    )
end
