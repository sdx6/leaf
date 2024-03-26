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
        tc.bg.black..tc.fg.green..[[  ,]]..tc.fg.white..[[\   \  ]],
        tc.bg.black..tc.fg.green..[[ |'\]]..tc.fg.white..[[()\,| ]],
        tc.bg.black..tc.fg.green..[[  \ __\'  ]],
        tc.bg.black..tc.fg.green..[[          ]],
        text = tc.fg.green,
      },
    }
  end,
}

-- }}}

-- }}}
-- {{{ handle C exposure

get = get or {}
leafver = leafver or "na"

-- }}}
-- {{{ the fetching

os_release = "/etc/os-release"
version = "/proc/version"
hostname = "/etc/hostname"
separator = "│"

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
    return tonumber(b).."%" or "na"
  end
  return "na"
end

-- }}}
-- {{{ process arguments

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
      ["-s"] = function(i)
        separator = arg[i+1]
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
          "├── -s --separator       │ Set a character to separate the field from the value",
          "│   └── [STRING]         │ e.g, the default separator, \"│\"",
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
        dobreak = true
      end
    }
    args["--os-release"] = args["-os"]
    args["--hostname"] = args["-hn"]
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

  -- {{{ display

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

  distro = distro or get.distro(os_release)
  if construct[string.sub(distro,1,1)]()[distro] then
    icon = construct[string.sub(distro,1,1)]()[distro]
    if get.access(os.getenv("HOME").."/.config/sdx6/leaf/config.lua") then
      conf = dofile(os.getenv("HOME").."/.config/sdx6/leaf/config.lua")
      if conf then
        conf(get, ip, separator, distro, icon, tc, version, hostname)
      end
    end
    icon = construct[string.sub(get.distro(os_release),1,1)]()[get.distro(os_release)]
    display = display or
    {
      string.format("%s "..icon.text.."os"..tc.normal.." "..separator.." %s\n", icon[1]..tc.normal, distro),
      string.format("%s "..icon.text.."kv"..tc.normal.." "..separator.." %s\n", icon[2]..tc.normal, get.kernel(version)),
      string.format("%s "..icon.text.."up"..tc.normal.." "..separator.." %dd %dh %dm\n", icon[3]..tc.normal, get.days(), get.hours(), get.mins()),
      string.format("%s "..icon.text.."ip"..tc.normal.." "..separator.." %s\n", icon[4]..tc.normal, ip),
      string.format("%s "..icon.text.."hn"..tc.normal.." "..separator.." %s\n", icon[5]..tc.normal, get.host(hostname)),
    }
    for i = 1, #display do
      io.write(display[i])
    end
  else
    print(string.format("[FATAL ERROR]: Your OS, %s is not supported by leaf", distro))
    print("\nPlease submit an issue about this at https://github.com/sdx6/leaf to include it, or pull request including the required distribution icon")
  end
  break
end

-- }}}
