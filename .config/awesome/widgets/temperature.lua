local watch = require("awful.widget.watch")
local json = require("json")
local wibox = require("wibox")

local env_vars = require('env_vars')

local api_call =
    (
        'https://api.openweathermap.org/data/2.5/onecall' ..
        '?lat=' .. env_vars.coords.lat ..
        '&lon=' .. env_vars.coords.long ..
        '&appid=' .. env_vars.weather_api_key ..
        '&units=metric' ..
        '&exclude=minutely'
    )


local weather_widget = {}

local function worker()
    -- Setup widget GUI
    weather_widget = wibox.widget {
        {
            {
                {
                    id = 'txt',
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left = 10,
            right = 10,
            layout = wibox.container.margin
        },
        widget = wibox.container.background,
        set_text = function(self, text)
            self:get_children_by_id('txt')[1].text = text
        end,
    }

    -- Parse results and set temperature text
    local function update_widget(widget, stdout)
        local temperature = json.decode(stdout).current.temp

        if temperature == nil then
            widget:set_text("ERR")
        end

        local formatter_string = string.format('%.0f', temperature) .. '°' .. 'C'

        widget:set_text(formatter_string)
    end

    -- Reload API call and GUI display every 5 minutes
    watch(
        string.format([[bash -c "curl -s --show-error -X GET '%s'"]], api_call),
        300,
        update_widget, weather_widget
    )

    return weather_widget
end

return setmetatable(
        weather_widget,
        {
            __call = function()
                return worker()
            end
        }
    )
