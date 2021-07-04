# Installation

1. Add the following to the `.bashrc` 
    - `source ~/.bash_public.bash`
2. Setup weather widget
    - Grab an API key [HERE](https://home.openweathermap.org/api_keys)
    - Grab lat/long [HERE](https://www.maps.ie/coordinates.html)
    - Put the following in '~/.config/awesome/env_vars.lua'
    ```lua
        local module = {}

        module.weather_api_key = "key"
        module.coords = {
            lat = 22.2222,
            long = 22.22222
        }

        return module
    ```
