# Installation

Apts
- `pavucontrol`

1. Add the following to the `.bashrc` `source ~/.bash_public.bash`
2. Install awesome widgets:
    - `cd ~/.config/awesome`
    - `git clone https://github.com/streetturtle/awesome-wm-widgets`
    - `wget -P ~/.config/awesome/ https://raw.githubusercontent.com/rxi/json.lua/master/json.lua`
3. Install `rofi`
    - `sudo apt-get install rofi`
4. Setup weather widget
    - Create `env_vars.lua` file in `awesome` folder
    - Put the following inside and grab a key [HERE](https://home.openweathermap.org/api_keys)
    ```lua
        local module = {}

        module.weather_api_key = "key"

        return module
    ```
5. Install `luarocks`
    - Follow sumenko stuff
    - Run `./configure --with-lua-include=/usr/include/lua5.1` when configuring luarocks
