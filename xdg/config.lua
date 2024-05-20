---@diagnostic disable: lowercase-global
---@diagnostic disable: duplicate-set-field
---@diagnostic disable: undefined-global
---@diagnostic disable: unused-local
-- vim:foldmethod=marker

--{{{ documentation
--[[

functions:

  all functions can be used any time for any purpose in the config file,
  you can even create new function if you want, some of these are designed to help simplify the process
  the get functions are provided by leaf and directly related to their C functions

  number get.days(nil):
    returns:
      the days part of the total uptime

  number get.hours(nil):
    returns:
      the hours part of the total uptime

  number get.mins(nil):
    returns:
      the minutes part of the total uptime

  number get.ip(string:device):
    device:
      the device to look in (ex: "wlan0")
    returns:
      IP address of device (ipv4)

  bool get.access(string:file):
    file:
      the full path to the file
    returns:
      true if the file exists
      false if the file does not exist

  table get.dir(string:directory):
    directory:
      directory to search
    returns:
      all items inside of the specified directory

  string get.distro(string:os_release):
    os_release:
      the full path to the os-release file
    returns:
      distribution ID (ex: "arch")

  string get.kernel(string:version):
    version:
      full path to Linux version file
    returns:
      kernel version (ex: "6.9.0-amd64")

  string get.bat(nil)
    returns:
      percentage battery level of BAT0, if there is a connected battery
      "na" if there is no connected battery, or is not a number

  string get.temp(nil)
    returns:
      the temperature of the CPU, rounded to the nearest whole number, or tens decimal place
      "na" if file opening fails, or is not a number

  string get.color(nil)
    returns:
      a string that showcases the terminal color palette in small 1x2 squares

  string get.term(nil)
    returns:
      the terminal that leaf is running under

  string get.shell(nil)
    returns:
      the shell that leaf is running under

  string get.date(nil)
    returns:
      the date, in MM/DD/YY format

  string get.time(nil)
    returns:
      the time, in HH:MM:SS format

  string get.cpu.model(nil)
    returns:
      the full CPU model and core information

  number get.cpu.threads(nil)
    returns:
      the total amount of CPUs in the CPU :)

  string get.ram.total(nil)
    returns:
      the total amount of RAM in GiB, with 2 decimal places for MiB

  string get.ram.free(nil)
    returns:
      the amount of RAM not in use in GiB, with 2 decimal places for MiB

  string get.ram.used(nil)
    returns:
      the amount of RAM currently in use in GiB, with 2 decimal places for MiB

  string get.user()
    returns:
      the user, equivalent to `whoami`

  string get.mobo()
    returns:
      the host manufacturer and model, may be related to libvirt / virtualbox on VMs

variables:

  variables that leaf provides to the config
  these are used to edit the appearance of the display without having to run the same code twice
  none of the variables are meant to be changed, but you can if you like

  ip:
    ip address auto selected from existing devices

  separator:
    the separator between the label and its value

  distro:
    the distribution icon using the default os-release location

  icon:
    a table with 5 elements that represent the distribution icon using the distro variable, and an additional one to specify the text color

  tc:
    a table of text colors and color states:
    {
      fg =
      {
        black,
        red,
        green,
        yellow,
        blue,
        pink,
        cyan,
        white.
      },
      bg =
      {
        black,
        red,
        green,
        yellow,
        blue,
        pink,
        cyan,
        white,
      },
      normal,
    }

  uptime:
    the uptime, written in a nice format that automatically removes 0s and concatenates the rest

  version:
    the path to the version file

  hostname:
    the path to the hostname file

arguments:

  these variables are called by leaf earlier in code
  after the args are parsed and before it starts drawing, the globals with the same name are replaced
  this lets you supply their value here, instead of using the program arguments

  string version:
    the path to the kernel version information, usually "/proc/version"

  string hostname:
    the path to the system hostname, usually "/etc/hostname"

  string os_release:
    the path to the operating system information, usually "/etc/os-release"

  string distro:
    the distribution ID to override the OS with

  bool force:
    whether not to use Linux generic in the case of missed support 

--]]
--}}}
--{{{ default configuration
--[[

return
{
  args =
  {
    version = "/proc/version",
    hostname = "/etc/hostname",
    os_release = "/etc/os-release",
    distro = nil,
    force = false,
  },

  config = function(get, ip, separator, distro, icon, tc, uptime, version, hostname)

    separator = "▎"

    display =
    {
      icon[1]..tc.normal..icon.text..separator.."os"..tc.normal.." "..separator..distro.."\n",
      icon[2]..tc.normal..icon.text..separator.."kv"..tc.normal.." "..separator..get.kernel(version).."\n",
      icon[3]..tc.normal..icon.text..separator.."up"..tc.normal.." "..separator..uptime.."\n",
      icon[4]..tc.normal..icon.text..separator.."ip"..tc.normal.." "..separator..ip.."\n",
      icon[5]..tc.normal..icon.text..separator.."hn"..tc.normal.." "..separator..get.host(hostname).."\n",
    }
  end,
}

--]]
--}}}

--{{{ example configurations
--[[

neofetch theme:

  return
  {
    config = function(get, ip, separator, distro, icon, tc, uptime, version, hostname)

      separator = ": "
      local header = get.user().."@"..get.host(hostname)
      local bar = ""
        for _ = 1, #header do
        bar = bar.."-"
      end
      display =
      {
        icon[1]..tc.normal..icon.text..tc.normal.." "..header.."\n",
        icon[2]..tc.normal..icon.text..tc.normal.." "..bar.."\n",
        icon[3]..tc.normal..icon.text.." OS"..tc.normal..separator..distro.."\n",
        icon[4]..tc.normal..icon.text.." Host"..tc.normal..separator..get.mobo().."\n",
        icon[5]..tc.normal..icon.text.." Kernel"..tc.normal..separator..get.kernel(version).."\n",
        icon.text.."           Shell"..tc.normal..separator..get.shell().."\n",
        icon.text.."           DE"..tc.normal..separator..get.de().."\n",
        icon.text.."           Terminal"..tc.normal..separator..get.term().."\n",
        icon.text.."           CPU"..tc.normal..separator..get.cpu.model().."\n",
        icon.text.."           RAM"..tc.normal..separator..get.ram.used().." / "..get.ram.total().."\n",
        "           "..get.color().."\n",
      }
    end,
  }

--]]
--}}}
--{{{ example configuration modules
--[[

RAM usage:

  get.ram.used().." "..separator..get.ram.total().."\n",

user@hostname(ip):

  tc.fg.red..get.user()..tc.fg.yellow.."@"..tc.fg.green..get.host(hostname)..tc.fg.cyan.."("..tc.fg.blue..ip..tc.fg.pink..")\n",

distro(kernel):
  
  icon.text..distro..tc.normal.." ("..get.kernel(version)..")\n", 

terminal information:
  
  get.shell().." "..separator..get.term().."\n", 


--]]
--}}}
