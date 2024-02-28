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
-- =( > w < )=_ <  run on OSX OR Windows!!!           |
--   )  v  (_/ | \ Tested ONLY on Linux, FOR Linux!!! |
--  ( _\|/_ )_/   '----------------------------------'

-- }}}
--{{{ require("stdex")

function string.tokenize(s)
  local t = {}
  for i = 1, #s do
    table.insert(t,s:sub(i,i))
  end
  return t
end
function string.split(s)
  local t = {}
  for i in string.gmatch(s, "%S+") do
    table.insert(t, i)
  end
  return t
end

--}}}

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
  normal = string.char(27,91).."0m",
  bold = string.char(27,91).."1m",
}

-- }}}
-- {{{ icons

imgs =
{
  ["bedrock"] =
  {
    tc.bold..tc.bg.black..tc.fg.white..[[ __       ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.white..[[ \ \___   ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.white..[[  \  _ \  ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.white..[[   \___/  ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.white..[[          ]]..tc.normal,
    text = tc.fg.white,
  },
  ["endeavouros"] =
  {
    tc.bold..tc.bg.pink..tc.fg.black..[[     __   ]]..tc.normal,
    tc.bold..tc.bg.pink..tc.fg.black..[[    /  \  ]]..tc.normal,
    tc.bold..tc.bg.pink..tc.fg.black..[[  /     | ]]..tc.normal,
    tc.bold..tc.bg.pink..tc.fg.black..[[ '_____/  ]]..tc.normal,
    tc.bold..tc.bg.pink..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.pink,
  },
  ["arch"] =
  {
    tc.bold..tc.bg.cyan..tc.fg.black..[[          ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[    /\    ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[   /  \   ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[  /_/\_\  ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.cyan,
  },
  ["gentoo"] =
  {
    tc.bold..tc.bg.white..tc.fg.black..[[   ___    ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[  [  _ \  ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[   >   /  ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[  (__ /   ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.white,
  },
  ["debian"] =
  {
    tc.bold..tc.bg.red..tc.fg.black..[[     __   ]]..tc.normal,
    tc.bold..tc.bg.red..tc.fg.black..[[  '/  .\' ]]..tc.normal,
    tc.bold..tc.bg.red..tc.fg.black..[[  |  (_'  ]]..tc.normal,
    tc.bold..tc.bg.red..tc.fg.black..[[   \      ]]..tc.normal,
    tc.bold..tc.bg.red..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.red,
  },
  ["void"] =
  {
    tc.bold..tc.bg.green..tc.fg.black..[[    __    ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[  ,\   \  ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[ |'\()\,| ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[  \ __\'  ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.green,
  },
  ["fedora"] =
  {
    tc.bold..tc.bg.blue..tc.fg.black..[[   ____   ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[  /  _ \  ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[ | C/-  | ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[ |_____/  ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.blue,
  },
  ["alpine"] =
  {
    tc.bold..tc.bg.blue..tc.fg.black..[[          ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[   /\     ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[  //\\/\  ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[ //  \\\\ ]]..tc.normal,
    tc.bold..tc.bg.blue..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.blue,
  },
  ["manjaro"] =
  {
    tc.bold..tc.bg.black..tc.fg.green..[[ ,___,,_, ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.green..[[ | ,_]| | ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.green..[[ | |  | | ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.green..[[ |_|__|_| ]]..tc.normal,
    tc.bold..tc.bg.black..tc.fg.green..[[          ]]..tc.normal,
    text = tc.fg.green,
  },
  ["ubuntu"] =
  {
    tc.bold..tc.bg.yellow..tc.fg.black..[[    __    ]]..tc.normal,
    tc.bold..tc.bg.yellow..tc.fg.black..[[ ()'__'() ]]..tc.normal,
    tc.bold..tc.bg.yellow..tc.fg.black..[[ | |__| | ]]..tc.normal,
    tc.bold..tc.bg.yellow..tc.fg.black..[[  \ __ /  ]]..tc.normal,
    tc.bold..tc.bg.yellow..tc.fg.black..[[    ^^    ]]..tc.normal,
    text = tc.fg.yellow,
  },
  ["opensuse-leap"] =
  {
    tc.bold..tc.bg.green..tc.fg.black..[[    .___  ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[   _| ()\ ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[ /    --' ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[ \ __^/   ]]..tc.normal,
    tc.bold..tc.bg.green..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.green,
  },
  ["opensuse-tumbleweed"] =
  {
    tc.bold..tc.bg.cyan..tc.fg.black..[[  _    _  ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[ / \  / \ ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[ |  )(  | ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[ \_/  \_/ ]]..tc.normal,
    tc.bold..tc.bg.cyan..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.cyan,
  },
  [""] =
  {
    tc.bold..tc.bg.white..tc.fg.black..[[          ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[          ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[          ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[          ]]..tc.normal,
    tc.bold..tc.bg.white..tc.fg.black..[[          ]]..tc.normal,
    text = tc.fg.white,
  },

}

-- }}}

-- }}}
-- {{{ handle C variables 

wlanip = wlanip or "0.0.0.0"
if wlanip == "0.0.0.0" then
  wlanip = "na"
end

ethip = ethip or "0.0.0.0"
if ethip == "0.0.0.0" then
  ethip = "na"
end

days = days or 0
hours = hours or 0
minutes = minutes or 0

-- }}}
-- {{{ process arguments

os_release = "/etc/os-release"
version = "/proc/version"
hostname = "/etc/hostname"
while true do
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
        "└── -h --help            │ Shows this screen!!",
        "",
        "Examples:",
        "    leaf -os /bedrock/etc/os-release │ Shows Bedrock instead of the current stratum",
        "",
      }
      for x = 1, #help do print(help[x]) end
    end,
  }
  args["--os-release"] = args["-os"]
  args["--hostname"] = args["-hn"]
  args["--kernel-version"] = args["-kv"]
  args["--override"] = args["-o"]
  args["--help"] = args["-h"]
  local dobreak = false
  for i = 1, #arg do
    if arg[i] ~= "-h" and arg[i] ~= "--help" then
      if args[arg[i]] then
        args[arg[i]](i)
      end
    else
      args[arg[i]]()
      dobreak = true
    end
  end
  if dobreak then break end

  -- }}}
  -- {{{ the fetching

  get =
  {
    distro = function()
      local d = {}
      for l in io.lines(os_release) do
        table.insert(d, l)
      end
      for i = 1, #d do
        if d[i]:sub(1, 3) == "ID=" then
          local s = d[i]
          s = string.tokenize(s)
          for _ = 1, 3 do
            table.remove(s, 1)
          end
          if s[1] == "\"" and s[#s] == "\"" then
            table.remove(s, 1)
            table.remove(s, #s)
          end
          return table.concat(s)
        end
      end
    end,
    kernel = function()
      local k = {}
      for l in io.lines(version) do
        table.insert(k, l)
      end
      k = string.split(table.concat(k, " "))
      return k[3]
    end,
    host = function()
      local h = {}
      for l in io.lines(hostname) do
        table.insert(h, l)
      end
      return h[1]
    end,
  }

  -- }}}

  -- {{{ display

  if not distro then
    distro = get.distro()
  end
  if imgs[distro] then
    io.write(string.format("%s "..imgs[distro].text.."os"..tc.normal.." : %s\n", imgs[distro][1], distro))
    io.write(string.format("%s "..imgs[distro].text.."kv"..tc.normal.." : %s\n", imgs[distro][2], get.kernel()))
    io.write(string.format("%s "..imgs[distro].text.."up"..tc.normal.." : %s\n", imgs[distro][3], days.."d "..hours.."h "..minutes.."m"))
    io.write(string.format("%s "..imgs[distro].text.."ip"..tc.normal.." : %s\n", imgs[distro][4], wlanip or ethip))
    io.write(string.format("%s "..imgs[distro].text.."hn"..tc.normal.." : %s\n", imgs[distro][5], get.host()))
  else
    print("[FATAL ERROR]: Your OS, "..distro.." is not supported by leaf")
    print("\nPlease submit an issue about this to include it, or pull request including the required distribution icon")
  end
  break
end

  -- }}}
