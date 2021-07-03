# Installation

1. Add the following to the `.bashrc` `source ~/.bash_public.bash`
2. Setup weather widget
    - Put the following inside and grab a key [HERE](https://home.openweathermap.org/api_keys)
    ```lua
        local module = {}

        module.weather_api_key = "key"
        module.coords = {
            lat = 22.2222,
            long = 22.22222
        }

        return module
    ```
