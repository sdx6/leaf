---@diagnostic disable: lowercase-global
---@diagnostic disable: duplicate-set-field
-- vim:foldmethod=marker

-- {{{ LICENSE

--  ,------------------------------------------------,
-- | Permission is hereby granted, free of charge, to |
-- | any person obtaining a copy of this software and |
-- | associated documentation files (the "Software"), |
-- | to deal in the Software without restriction,     |
-- | including without limitaion the rights to use,   |
-- | copy, modify, merge, publish, distribute,        |
-- | sublicense, and/or sell copies of the Software,  |
-- | and to permit persons to whom the Software is    |
-- | furnished to do so, subject to the following     |
-- | contidions:                                      |
-- |                                                  |
-- | The above copyright notice and this permission   |
-- | notice shall be included in all copies or        |
-- | substantial portions of the Software.            |
-- |                                                  |
-- | THE SOFTWARE IS PROIVDED "AS IS", WITHOUT        |
-- | WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,        |
-- | INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   |
-- | MERCHANTABILITY, FITNESS FOR A PARTICULAR        |
-- | PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL   |
-- | THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR   |
-- | ANY CLAIM, DAMAGES, OR OTHER LIABILITY, WHETHER  |
-- | IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE,    |
-- | ARISING FROM, OUT OF OR IN CONNECTION WITH THE   |
-- | SOFTWARE OR THE USE OR OTHER DEALINGS IN THE     |
-- | SOFTWARE.                                        |
--  '-_   _------------------------------------------'
--      V         ,----------------------------------,
--   /\ _ /\     / The Software IS NOT INTENDED to    |
-- =( > w < )=_ <  run on OSX, any BSD, or Windows.   |
--   )  v  (_/ | \ Tested only on Linux, FOR Linux!!! |
--  ( _\|/_ )_/   '----------------------------------'

-- }}}
-- {{{ require("stdex")

local function tokenize(s)
  local t = {}
  for i = 1, #s do
    table.insert(t,s:sub(i,i))
  end
  return t
end

local function split(s)
  local t = {}
  for i in string.gmatch(s, "%S+") do
    table.insert(t, i)
  end
  return t
end

-- }}}

-- {{{ variables

-- {{{ color

local tc =
{
  fg =
  {
    black = string.char(27, 91)..30 .."m",
    red = string.char(27, 91)..31 .."m",
    green = string.char(27, 91)..32 .."m",
    yellow = string.char(27, 91)..33 .."m",
    blue = string.char(27, 91)..34 .."m",
    pink = string.char(27, 91)..35 .."m",
    cyan = string.char(27, 91)..36 .."m",
    white = string.char(27, 91)..37 .."m",
  },
  bg =
  {
    black = string.char(27,91)..40 .."m",
    red = string.char(27,91)..41 .."m",
    green = string.char(27,91)..42 .."m",
    yellow = string.char(27,91)..43 .."m",
    blue = string.char(27,91)..44 .."m",
    pink = string.char(27,91)..45 .."m",
    cyan = string.char(27,91)..46 .."m",
    white = string.char(27,91)..47 .."m",
  },
  normal = string.char(27,91).."0m"
}

-- }}}
-- {{{ icons

local construct =
{
  ["a"] = function()
    return
    {
      ["arch"] =
      {
        tc.bg.cyan..tc.fg.black..[[          ]],
        tc.bg.cyan..tc.fg.black..[[    /\    ]],
        tc.bg.cyan..tc.fg.black..[[   /  \   ]],
        tc.bg.cyan..tc.fg.black..[[  /_/\_\  ]],
        tc.bg.cyan..tc.fg.black..[[          ]],
        text = tc.fg.cyan,
      },
      ["alpine"] =
      {
        tc.bg.blue..tc.fg.black..[[          ]],
        tc.bg.blue..tc.fg.black..[[   /\     ]],
        tc.bg.blue..tc.fg.black..[[  //\\/\  ]],
        tc.bg.blue..tc.fg.black..[[ //  \\\\ ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
      ["arco"] =
      {
        tc.bg.blue..tc.fg.black..[[          ]],
        tc.bg.blue..tc.fg.black..[[    /\    ]],
        tc.bg.blue..tc.fg.black..[[   //\\   ]],
        tc.bg.blue..tc.fg.black..[[  // -=\  ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
    }
  end,
  ["b"] = function()
    return
    {
      ["bedrock"] =
      {
        tc.bg.black..tc.fg.white..[[ __       ]],
        tc.bg.black..tc.fg.white..[[ \ \___   ]],
        tc.bg.black..tc.fg.white..[[  \  _ \  ]],
        tc.bg.black..tc.fg.white..[[   \___/  ]],
        tc.bg.black..tc.fg.white..[[          ]],
        text = tc.fg.white,
      },
    }
  end,
  ["c"] = function()
    return
    {
      ["chimera"] =
      {
        tc.bg.pink..tc.fg.black..[[ ,__,     ]],
        tc.bg.pink..tc.fg.black..[[ |  |     ]],
        tc.bg.pink..tc.fg.black..[[ ]=[()--, ]],
        tc.bg.pink..tc.fg.black..[[ |__||__| ]],
        tc.bg.pink..tc.fg.black..[[          ]],
        text = tc.fg.pink,
      }
    }
  end,
  ["d"] = function()
    return
    {
      ["debian"] =
      {
        tc.bg.red..tc.fg.black..[[     __   ]],
        tc.bg.red..tc.fg.black..[[  '/  .\' ]],
        tc.bg.red..tc.fg.black..[[  |  (_'  ]],
        tc.bg.red..tc.fg.black..[[   \      ]],
        tc.bg.red..tc.fg.black..[[          ]],
        text = tc.fg.red,
      },
    }
  end,
  ["e"] = function()
    return
    {
      ["endeavouros"] =
      {
        tc.bg.pink..tc.fg.black..[[     __   ]],
        tc.bg.pink..tc.fg.black..[[    /  \  ]],
        tc.bg.pink..tc.fg.black..[[  /     | ]],
        tc.bg.pink..tc.fg.black..[[ '_____/  ]],
        tc.bg.pink..tc.fg.black..[[          ]],
        text = tc.fg.pink,
      },
    }
  end,
  ["f"] = function()
    return
    {
      ["fedora"] =
      {
        tc.bg.black..tc.fg.blue..[[   ____   ]],
        tc.bg.black..tc.fg.blue..[[  /  ]]..tc.fg.white..[[_]]..tc.fg.blue..[[ \  ]],
        tc.bg.black..tc.fg.blue..[[ | ]]..tc.fg.white..[[C/-]]..tc.fg.blue..[[  | ]],
        tc.bg.black..tc.fg.blue..[[ |_____/  ]],
        tc.bg.black..tc.fg.blue..[[          ]],
        text = tc.fg.blue,
      },
    }
  end,
  ["g"] = function()
    return
    {
      ["gentoo"] =
      {
        tc.bg.white..tc.fg.black..[[   ___    ]],
        tc.bg.white..tc.fg.black..[[  [  _ \  ]],
        tc.bg.white..tc.fg.black..[[   >   /  ]],
        tc.bg.white..tc.fg.black..[[  (__ /   ]],
        tc.bg.white..tc.fg.black..[[          ]],
        text = tc.fg.white,
      },
    }
  end,
  ["h"] = function()
    return
    {
    }
  end,
  ["i"] = function()
    return
    {
    }
  end,
  ["j"] = function()
    return
    {
    }
  end,
  ["k"] = function()
    return
    {
    }
  end,
  ["l"] = function()
    return
    {
      ["linux"] =
      {
        tc.bg.black..tc.fg.white..[[ ,______, ]],
        tc.bg.black..tc.fg.white..[[ |      | ]],
        tc.bg.black..tc.fg.white..[[ |      | ]],
        tc.bg.black..tc.fg.white..[[ |______| ]],
        tc.bg.black..tc.fg.white..[[          ]],
        text = tc.fg.yellow,
      },
    }
  end,
  ["m"] = function()
    return
    {
      ["manjaro"] =
      {
        tc.bg.green..tc.fg.black..[[ ,___,,_, ]],
        tc.bg.green..tc.fg.black..[[ | ,_|| | ]],
        tc.bg.green..tc.fg.black..[[ | |  | | ]],
        tc.bg.green..tc.fg.black..[[ |_|__|_| ]],
        tc.bg.green..tc.fg.black..[[          ]],
        text = tc.fg.green,
      },
    }
  end,
  ["n"] = function()
    return
    {
      ["nixos"] =
      {
        tc.bg.black..tc.fg.black..[[          ]],
        tc.bg.black..tc.fg.blue..[[   ==]]..tc.fg.cyan..[[\\   ]],
        tc.bg.black..tc.fg.cyan..[[  // ]]..tc.fg.blue..[[ //  ]],
        tc.bg.black..tc.fg.blue..[[   \\]]..tc.fg.cyan..[[==   ]],
        tc.bg.black..tc.fg.black..[[          ]],
        text = tc.fg.cyan,
      },
    }
  end,
  ["o"] = function()
    return
    {
      ["opensuse-leap"] =
      {
        tc.bg.green..tc.fg.black..[[    ,___  ]],
        tc.bg.green..tc.fg.black..[[   _| ()\ ]],
        tc.bg.green..tc.fg.black..[[ /    --' ]],
        tc.bg.green..tc.fg.black..[[ \ __^/   ]],
        tc.bg.green..tc.fg.black..[[          ]],
        text = tc.fg.green,
      },
      ["opensuse-tumbleweed"] =
      {
        tc.bg.blue..tc.fg.black..[[  _    _  ]],
        tc.bg.blue..tc.fg.black..[[ / \  / \ ]],
        tc.bg.blue..tc.fg.black..[[ |  )(  | ]],
        tc.bg.blue..tc.fg.black..[[ \_/  \_/ ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
      ["osx"] =
      {
        tc.bg.black..tc.fg.green.. [[   _//_   ]],
        tc.bg.black..tc.fg.yellow..[[ /  "" \  ]],
        tc.bg.black..tc.fg.red..   [[ |    (   ]],
        tc.bg.black..tc.fg.pink..  [[  \____/  ]],
        tc.bg.black..tc.fg.green.. [[ --]]..tc.fg.yellow..[[--]]..tc.fg.red..[[--]]..tc.fg.pink..[[-- ]],
        text = tc.fg.white,
      },
    }
  end,
  ["p"] = function()
    return
    {
    }
  end,
  ["q"] = function()
    return
    {
    }
  end,
  ["r"] = function()
    return
    {
    }
  end,
  ["s"] = function()
    return
    {
      ["slackware"] =
      {
        tc.bg.blue..tc.fg.black..[[          ]],
        tc.bg.blue..tc.fg.black..[[   ,-=|   ]],
        tc.bg.blue..tc.fg.black..[[   '==,   ]],
        tc.bg.blue..tc.fg.black..[[   |=-'   ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
    }
  end,
  ["t"] = function()
    return
    {
    }
  end,
  ["u"] = function()
    return
    {
      ["ubuntu"] =
      {
        tc.bg.yellow..tc.fg.black..[[    __    ]],
        tc.bg.yellow..tc.fg.black..[[ () -- () ]],
        tc.bg.yellow..tc.fg.black..[[ | |  | | ]],
        tc.bg.yellow..tc.fg.black..[[  \ -- /  ]],
        tc.bg.yellow..tc.fg.black..[[    ''    ]],
        text = tc.fg.yellow,
      },
    }
  end,
  ["v"] = function()
    return
    {
      ["void"] =
      {
        tc.bg.black..tc.fg.white..[[    __    ]],
        tc.bg.black..tc.fg.green..[[  _]]..tc.fg.white..[[\   \  ]],
        tc.bg.black..tc.fg.green..[[ | \]]..tc.fg.white..[[()\_| ]],
        tc.bg.black..tc.fg.green..[[  \ __\]]..tc.fg.white..[[   ]],
        tc.bg.black..tc.fg.green..[[          ]],
        text = tc.fg.green,
      },
    }
  end,
  ["w"] = function()
    return
    {
      ["windows10"] =
      {
        tc.bg.blue..tc.fg.black..[[ ,__,,__, ]],
        tc.bg.blue..tc.fg.black..[[ |  ||  | ]],
        tc.bg.blue..tc.fg.black..[[ |==||==| ]],
        tc.bg.blue..tc.fg.black..[[ |__||__| ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
      ["windows11"] =
      {
        tc.bg.blue..tc.fg.black..[[ ,__,,__, ]],
        tc.bg.blue..tc.fg.black..[[ |  ||  | ]],
        tc.bg.blue..tc.fg.black..[[ |==||==| ]],
        tc.bg.blue..tc.fg.black..[[ |__||__| ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
      ["Windows7"] =
      {
        tc.bg.blue..tc.fg.black..[[ ,__,,__, ]],
        tc.bg.blue..tc.fg.black..[[ |  ||  | ]],
        tc.bg.blue..tc.fg.black..[[ |==||==| ]],
        tc.bg.blue..tc.fg.black..[[ |__||__| ]],
        tc.bg.blue..tc.fg.black..[[          ]],
        text = tc.fg.blue,
      },
    }
  end,
  ["x"] = function()
    return
    {
    }
  end,
  ["y"] = function()
    return
    {
    }
  end,
  ["z"] = function()
    return
    {
    }
  end,
}

-- }}}

-- }}}
-- {{{ handle C exposure

get = get or {}
leafver = leafver or "na"
exit = exit or 0

-- }}}
-- {{{ the fetching

local os_release = "/etc/os-release"
local version = "/proc/version"
local hostname = "/etc/hostname"
local separator = "▎"

get.distro = function(osr)
  local d = {}
  for l in io.lines(osr) do
    table.insert(d, l)
  end
  for i = 1, #d do
    if d[i]:sub(1, 3) == "ID=" then
      local s = d[i]
      s = tokenize(s)
      if s[4] == "\"" and s[#s] == "\"" then
        return string.lower(table.concat(s, "", 5, #s-1))
      end
      if s[5] == "'" and s[#s] == "'" then
        return string.lower(table.concat(s, "", 5, #s-1))
      end
      return string.lower(table.concat(s, "", 4, #s))
    end
  end
end

get.kernel = function(kv)
  local k = {}
  for l in io.lines(kv) do
    table.insert(k, l)
  end
  k = split(table.concat(k, " "))
  return k[3]
end

get.host = function(hn)
  local h = {}
  for l in io.lines(hn) do
    table.insert(h, l)
  end
  return h[1]
end

get.bat = function()
  if get.access("/sys/class/power_supply/BAT0/capacity") then
    local b = io.open("/sys/class/power_supply/BAT0/capacity", "r")
    if b then b = b:read("*a") end
    return tonumber(b).."%" or "na"
  end
  return "na"
end

get.temp = function()
  if get.access("/sys/class/thermal/thermal_zone0/temp") then
    local t = io.open("/sys/class/thermal/thermal_zone0/temp")
    if t then t = t:read("*a") end
    return (math.floor(t/1000*2+.5)/2).."°" or "na"
  end
  return "na"
end

get.color = function()
  return tc.bg.red.."  "..tc.bg.yellow.."  "..tc.bg.green.."  "..tc.bg.cyan.."  "..tc.bg.blue.."  "..tc.bg.pink.."  "..tc.bg.white.."  "..tc.bg.black.."  "..tc.normal
end

get.term = function()
  local tr = os.getenv("TERM")
  if tr == "" then
    return "na"
  end
  return tr
end

get.shell = function()
  local sh = tokenize(os.getenv("SHELL"))
  for i = #sh, 1, -1 do
    if sh[i] == "/" then
      return table.concat(sh, "", #sh-(#sh-i)+1, #sh)
    end
  end
  return "na"
end

get.date = function()
  return os.date("%D", os.time()) or "na"
end

get.time = function()
  return os.date("%H:%M:%S", os.time()) or "na"
end

get.de = function()
  return string.lower(tostring(os.getenv("XDG_SESSION_DESKTOP") or "na"))
end

get.cpu =
{
  model = function()
    local d = {}
    for l in io.lines("/proc/cpuinfo") do
      table.insert(d, l)
    end
    return string.lower(d[5]:sub(14, #d[5]))
  end,
  threads = function()
    local d = {}
    for l in io.lines("/proc/cpuinfo") do
      table.insert(d, l)
    end
    return d[11]:sub(12, #d[5])
  end
}

get.ram =
{
  total = function()
    local d = {}
    for l in io.lines("/proc/meminfo") do
      table.insert(d, l)
    end
    return string.format("%1.2f", d[1]:sub(17, #d[1] - 3) / 1024000).."gib"
  end,
  free = function()
    local d = {}
    for l in io.lines("/proc/meminfo") do
      table.insert(d, l)
    end
    return string.format("%1.2f", d[3]:sub(17, #d[2] - 3) / 1024000).."gib"
  end,
  used = function()
    local d = {}
    for l in io.lines("/proc/meminfo") do
      table.insert(d, l)
    end
    return string.format("%1.2f", d[1]:sub(17, #d[1] - 3) / 1024000) - string.format("%1.2f", d[3]:sub(17, #d[2] - 3) / 1024000).."gib"
  end,
}

get.user = function()
  return os.getenv("USER")
end

get.mobo = function()
  local v = io.open("/sys/devices/virtual/dmi/id/board_vendor")
  if v then
    v = v:read("*a"):sub(1, -2)
  end
  local m = io.open("/sys/devices/virtual/dmi/id/board_name")
  if m then
    m = m:read("*a"):sub(1, -2)
  end
  return string.lower((v or "na").." "..(m or "na"))
end

-- }}}
-- {{{ parse config

local conf = {}
if get.access(os.getenv("HOME").."/.config/sdx6/leaf/config.lua") then
  conf = dofile(os.getenv("HOME").."/.config/sdx6/leaf/config.lua")
end
if conf.args then
  version = conf.args.version or version
  hostname = conf.args.hostname or hostname
  os_release = conf.args.os_release or os_release
  if conf.args.force then
    distro = "linux"
  else
    distro = conf.args.distro or nil
  end
end

--}}}
--{{{ process arguments
while true do
  if #arg > 0 then
    local dobreak
    args =
    {
      ["-os"] = function(i)
        os_release = arg[i+1]
      end,

      ["-kv"] = function(i)
        version = arg[i+1]
      end,

      ["-hn"] = function(i)
        hostname = arg[i+1]
      end,

      ["-o"] = function(i)
        distro = arg[i+1]
      end,

      ["-f"] = function()
        distro = "linux"
      end,

      ["-s"] = function(i)
        separator = arg[i+1]
      end,

      ["-e"] = function(i)
        local s = loadstring(arg[i+1])
        if s then
          s()
        end
        dobreak = true
      end,

      ["-h"] = function()
        help =
        {
          "",
          "Usage: leaf [OPTION]...",
          "Possible options:",
          "├── -os --os-release     │ For OSes that don't put os-release in /etc/",
          "│   └── [STRING]         │ The path to your os-release file",
          "├── -kv --kernel-version │ For OSes that don't put version in /proc/",
          "│   └── [STRING]         │ The path to your version file",
          "├── -hn --hostname       │ For OSes that don't put hostname in /etc/",
          "│   └── [STRING]         │ The path to your hostname file",
          "├── -o --override        │ Manually set the icon and os field",
          "│   └── [STRING]         │ The distribution ID",
          "├── -f --force           │ Use Linux generic in the case of missed support",
          "├── -s --separator       │ Set a character to separate the field from the value",
          "│   └── [STRING]         │ e.g, the default separator, \"▎\"",
          "├── -e --execute         │ Execute a chunk (Lua) to execute, and don't display",
          "│   └── [STRING]         │ The chunk, e.g \"print(get.mobo())\"",
          "├── -h --help            │ Shows this screen!!",
          "└── -v --version         │ Display leaf version",
          "",
          "Examples:",
          "    leaf -os /bedrock/etc/os-release │ Shows Bedrock instead of the current stratum",
          "",
        }
        for x = 1, #help do print(help[x]) end
        dobreak = true
      end,

      ["-v"] = function()
        print("leaf v"..leafver)
        print("github.com/sdx6/leaf")
        dobreak = true
      end
    }
    args["--os-release"] = args["-os"]
    args["--hostname"] = args["-hn"]
    args["--override"] = args["-o"]
    args["--force"] = args["-f"]
    args["--kernel-version"] = args["-kv"]
    args["--separator"] = args["-s"]
    args["--help"] = args["-h"]
    args["--version"] = args["-v"]
    for i = 1, #arg do
      if args[arg[i]] then
        args[arg[i]](i)
      end
    end
    if dobreak then break end
  end

  -- }}}

  -- {{{ display result

  local ip = "na"
  local d = {}
  for l in io.lines("/proc/net/dev") do
    table.insert(d, l)
  end
  for i = 1, #d do
    d[i] = split(d[i])
  end
  table.remove(d, 1)
  table.remove(d, 1)
  for i = 1, #d do
    local dev = d[i][1]:sub(1, -2)
    if dev ~= "lo" and tonumber(d[i][2]) > 0 then
      local lip = get.ip(dev)
      if lip then
        ip = lip
        break
      end
    end
  end

  local uptime = ""
  local days = get.days()
  local hours = get.hours()
  local mins = get.mins()
  if days then
    uptime = days.."d "
  end
  if hours then
    uptime = uptime..hours.."h "
  end
  if mins then
    uptime = uptime..mins.."m"
  end

  distro = distro or get.distro(os_release)
  icon = construct[string.sub(distro,1,1)]()[distro]
  if icon then
    if get.access(os.getenv("HOME").."/.config/sdx6/leaf/config.lua") then
      if conf.config then
        conf.config(get, ip, separator, distro, icon, tc, uptime, version, hostname)
      end
    end
    display = display or
    {
      icon[1]..tc.normal..icon.text..separator.."os"..tc.normal.." "..separator..distro.."\n",
      icon[2]..tc.normal..icon.text..separator.."kv"..tc.normal.." "..separator..get.kernel(version).."\n",
      icon[3]..tc.normal..icon.text..separator.."up"..tc.normal.." "..separator..uptime.."\n",
      icon[4]..tc.normal..icon.text..separator.."ip"..tc.normal.." "..separator..ip.."\n",
      icon[5]..tc.normal..icon.text..separator.."hn"..tc.normal.." "..separator..get.host(hostname).."\n",
    }
    for i = 1, #display do
      io.write(display[i])
    end
    break
  end
  print("[FATAL ERROR]: Your OS, "..distro.." is not supported by leaf\n\nPlease submit an issue about this at https://github.com/sdx6/leaf to include it,\nor a pull request including the required distribution icon\n\nYou may also use the --force argument to ignore this message")
  exit = 1
  break
end

-- }}}
