-- Pegar a variável LANG para o texto do relógio aparecer em português
os.setlocale(os.getenv("LANG"))
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
package.loaded["naughty.dbus"] = {}

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/rafael/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.max,
}
-- }}}

-- {{{ Menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

menu_energia = { 
                { "reiniciar", "reboot", "/usr/share/icons/Papirus-Dark/64x64/apps/system-reboot.svg" },
                { "desligar", "poweroff", "/usr/share/icons/Papirus-Dark/64x64/apps/system-shutdown.svg" }
               }

mymainmenu = awful.menu({ items = { 
                                    { "PcManFM", "pcmanfm", "/usr/share/icons/Papirus-Dark/64x64/places/folder-blue.svg"},
                                    { "Chromium", "chromium", "/usr/share/icons/Papirus-Dark/64x64/apps/chromium-browser.svg"},
                                    { "Google Chrome", "google-chrome-stable", "/usr/share/icons/Papirus-Dark/64x64/apps/google-chrome.svg"},
                                    { "QuteBrowser", "qutebrowser", "/usr/share/icons/Papirus-Dark/64x64/apps/qutebrowser.svg"},
                                    { "FreeTube", "freetube", "/usr/share/icons/Papirus-Dark/64x64/apps/freetube.svg"},
                                    { "Captura de Tela", "xfce4-screenshooter", "/usr/share/icons/Papirus-Dark/64x64/apps/screengrab.svg"},
                                    { "LibreOffice Writer", "libreoffice --writer", "/usr/share/icons/Papirus-Dark/64x64/apps/libreoffice-writer.svg"},
                                    { "LibreOffice Calc", "libreoffice --calc", "/usr/share/icons/Papirus-Dark/64x64/apps/libreoffice-calc.svg"},
                                    { "TexStudio", "texstudio", "/usr/share/icons/Papirus-Dark/64x64/apps/texstudio.svg"},
                                    { "Proxy UEM (chromium)", "chromium --proxy-server=\"proxy.uem.br:8080\"", "/usr/share/icons/Papirus-Dark/64x64/apps/chromium-browser.svg"},
                                    { "Calculadora", "galculator", "/usr/share/icons/Papirus-Dark/64x64/apps/galculator.svg"},
                                    { "Editor de texto", "mousepad", "/usr/share/icons/Papirus-Dark/64x64/apps/mousepad.svg"},
                                    { "Mendeley Desktop", "mendeleydesktop", "/usr/share/icons/Papirus-Dark/64x64/apps/mendeley-desktop.svg"},
                                    { "SciLab", "scilab", "/usr/share/icons/Papirus-Dark/64x64/apps/scilab.svg"},
                                    { "Xcos", "xcos", "/usr/share/icons/Papirus-Dark/64x64/apps/xcos.svg"},
                                    { "Planner", "flatpak run com.github.alainm23.planner", "/usr/share/icons/Papirus-Dark/64x64/apps/planner.svg"},
                                    { "KeePass", "keepassxc", "/usr/share/icons/Papirus-Dark/64x64/apps/keepassxc.svg"},
                                    { "Steam", "steam", "/usr/share/icons/Papirus-Dark/64x64/apps/steam.svg"},
                                    { "Audacious", "audacious", "/usr/share/icons/Papirus-Dark/64x64/apps/audacious.svg"},
                                    { "PavuControl", "pavucontrol", "/usr/share/icons/Papirus-Dark/64x64/apps/pavucontrol.svg"},
                                    { "Planos de fundo", "nitrogen", "/usr/share/icons/Papirus-Dark/64x64/apps/nitrogen.svg"},
                                    { "Gerenciador de Pacotes", "pamac-manager", "/usr/share/icons/Papirus-Dark/64x64/apps/package-manager-icon.svg"},
                                    { "Terminal", terminal , "/usr/share/icons/Papirus-Dark/64x64/apps/Alacritty.svg"},
                                    { "VirtualBox", "virtualbox", "/usr/share/icons/Papirus-Dark/64x64/apps/virtualbox.svg"},
                                    { "Windows 7", "VBoxManage startvm \"windows 7\"", "/usr/share/icons/Papirus-Dark/64x64/apps/microsoft.svg"},
                                    { "Energia", menu_energia, "/usr/share/icons/Papirus-Dark/64x64/apps/utilities-energy-monitor.svg" },
                                  }
                        })

-- mylauncher = awful.widget.launcher({ image = "/usr/share/icons/Papirus-Dark/64x64/apps/start-here-archlinux.svg",
--                                      menu = mymainmenu })
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %a %d/%m, %H:%M ")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function(c)
                                               c:kill()
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            mylauncher,
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
	          -- battery_widget(),
            -- Linha abaixo modificada para adicionar margem na systray para evitar ícones muito grandes
            wibox.layout.margin(wibox.widget.systray(), 3, 3, 3, 3),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, ",",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, ".",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Control" }, "Right",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "Left",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
  
  -- Meus Apps e atalhos
    awful.key({ modkey}, "e",     function ()
    awful.layout.set(awful.layout.suit.tile)  end, 
              {description = "switch to tile layout", group = "layout"}),
    awful.key({ modkey}, "v",     function ()
    awful.layout.set(awful.layout.suit.fair)  end, 
              {description = "switch to fair layout", group = "layout"}),
    awful.key({ modkey}, "w",     function ()
    awful.layout.set(awful.layout.suit.max)  end, 
              {description = "switch to max layout", group = "layout"}),
    awful.key({ modkey, "Shift"}, "f",     function ()
    awful.layout.set(awful.layout.suit.floating)  end, 
              {description = "switch to floating layout", group = "layout"}),
    awful.key({ altkey },            "f",     function ()
    awful.spawn("chromium") end,
              {description = "run chromium", group = "launcher"}),
    awful.key({ altkey },            "b",     function ()
    awful.spawn("qutebrowser") end,
              {description = "run qutebrowser", group = "launcher"}),
    awful.key({ altkey },            "l",     function ()
    awful.spawn.with_shell("sleep 1 && xset s activate && slock") end,
              {description = "lock the screen", group = "energy"}),
    awful.key({ altkey },            "s",     function ()
    awful.spawn("steam") end,
              {description = "run steam", group = "launcher"}),
    awful.key({ modkey },            "i",     function ()
    awful.spawn("alacritty -e nvim /home/rafael/.config/awesome/rc.lua") end,
              {description = "edit config", group = "awesome"}),
    awful.key({ modkey, "Shift" },            "i",     function ()
    awful.spawn("alacritty -e nvim /home/rafael/.config/awesome/theme.lua") end,
              {description = "edit theme config", group = "awesome"}),
    awful.key({ altkey },            "d",     function ()
    awful.spawn("alacritty -e mutt") end,
              {description = "run mutt", group = "launcher"}),
    awful.key({ altkey },            "m",     function ()
    awful.spawn("alacritty -e bashtop") end,
              {description = "run bashtop", group = "launcher"}),
    awful.key({ altkey },            "a",     function ()
    awful.spawn("pcmanfm") end,
              {description = "run pcmanfm", group = "launcher"}),
    awful.key({ "Control" },            "space",     function ()
    awful.spawn("alacritty -e ranger") end,
              {description = "run ranger", group = "launcher"}),
    awful.key({ altkey },            "g",     function ()
    awful.spawn("qutebrowser --nowindow \":session-load gmail\"") end,
              {description = "run qutebrowser gmail", group = "launcher"}),
    awful.key({ altkey },            "c",     function ()
    awful.spawn("google-chrome-stable") end,
              {description = "run google chrome", group = "launcher"}),
    awful.key({ altkey },            "e",     function ()
    awful.spawn("keepassxc") end,
              {description = "run keepassxc", group = "launcher"}),
    awful.key({  },            "F8",     function ()
    awful.spawn("audacious -s") end,
              {description = "stop", group = "media"}),
    awful.key({  },            "XF86AudioPrev",     function ()
    awful.spawn("audacious -r") end,
              {description = "previous", group = "media"}),
    awful.key({  },            "XF86AudioNext",     function ()
    awful.spawn("audacious -f") end,
              {description = "next", group = "media"}),
    awful.key({  },            "F7",     function ()
    awful.spawn("audacious -t") end,
              {description = "play/pause", group = "media"}),
    awful.key({ altkey, "Shift" },            "f",     function ()
    awful.spawn("chromium --proxy-server=\"proxy.uem.br:8080\"") end,
              {description = "run chromium (proxy UEM)", group = "launcher"}),
    awful.key({ altkey },       "r",     function ()
    awful.spawn("calibre") end,
              {description = "run calibre", group = "launcher"}),
    awful.key({  }, "XF86AudioRaiseVolume",     function ()
    awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
              {description = "increase volume", group = "media"}),
    awful.key({  }, "XF86AudioLowerVolume",     function ()
    awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
              {description = "decrease volume", group = "media"}),
    awful.key({  }, "F10",     function ()
    awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
              {description = "decrease volume", group = "media"}),
    awful.key({  }, "F11",     function ()
    awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
              {description = "increase volume", group = "media"}),
    awful.key({ modkey }, "End",     function ()
    awful.spawn.with_shell("poweroff") end,
              {description = "shutdown", group = "energy"}),
    awful.key({ modkey }, "Insert",     function ()
    awesome.spawn("reboot") end,
              {description = "restart", group = "energy"}),
    awful.key({ modkey }, "b",     function ()
    awful.spawn.with_shell("setxkbmap br") end,
              {description = "layout br", group = "teclado"}),
    awful.key({ modkey }, "u",     function ()
    awful.spawn.with_shell("setxkbmap us") end,
              {description = "layout us", group = "teclado"}),
    awful.key({ altkey }, "p",     function ()
    awful.spawn.with_shell("nitrogen --set-zoom-fill --random ~/.local/share/backgrounds/") end,
              {description = "change wallpaper", group = "awesome"}),
    awful.key({ altkey }, "y",     function ()
    awful.spawn.with_shell("freetube") end,
              {description = "run FreeTube", group = "launcher"}),
    awful.key({ modkey }, "d",     function ()
    awful.spawn.with_shell("dmenu_run -sb \"#004C99\" -fn \"Liberation-14\"") end,
              {description = "run dmenu", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "w",     function ()
    awful.spawn.with_shell("VBoxManage startvm \"windows 7\"") end,
              {description = "run windows 7", group = "launcher"}),

  -- Menubar
    awful.key({ modkey }, "space", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})

)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    -- working toggle titlebar
    awful.key({ modkey, "Control" }, "t", function (c) awful.titlebar.toggle(c)         end,
             {description = "Show/Hide Titlebars", group="client"}),
    awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ altkey }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey  }, "z", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Alacritty", "mpv", "Xfce4-terminal", "Galculator", "Pavucontrol", "Lxpolkit"}, -- Minhas adições

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "Friends List",  -- Para Steam
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true, placement = awful.placement.centered }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set windows to always map on the tag named "x" on screen 1.
    { rule = { class = "Google-chrome" },
      properties = { screen = 1, tag = " 3 ", switchtotag = true } },
    { rule = { class = "Audacious" },
      properties = { screen = 1, tag = " 4 ", switchtotag = true } },
    { rule = { class = "Steam" },
      properties = { screen = 1, tag = " 7 ", switchtotag = true } },
    { rule = { class = "calibre" },
      properties = { screen = 1, tag = " 6 ", switchtotag = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Auto Start Apps
-- awful.spawn.with_shell("app command")

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
  }
