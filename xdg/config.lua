---@diagnostic disable: lowercase-global
---@diagnostic disable: duplicate-set-field
---@diagnostic disable: undefined-global
---@diagnostic disable: unused-local
-- vim:foldmethod=marker

--[[

functions:

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

variables:

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

  version:
    the default version path, "/proc/version"

  hostname:
    the default hostname path, "/etc/hostname"

  os_release:
    the default os-release path, "/etc/os-release"

  uptime:
    the uptime, written in a nice format that automatically removes 0s and concatenates the rest

default configuration:

--]]

return function(get, ip, separator, distro, icon, tc, version, hostname, os_release, uptime)
  version = "/proc/version"
  hostname = "/etc/hostname"
  os_release = "/etc/os-release"

  separator = "▎"

  display =
  {
    icon[1]..tc.normal..icon.text..separator.."os"..tc.normal.." "..separator..distro.."\n",
    icon[2]..tc.normal..icon.text..separator.."kv"..tc.normal.." "..separator..get.kernel(version).."\n",
    icon[3]..tc.normal..icon.text..separator.."up"..tc.normal.." "..separator..uptime.."\n",
    icon[4]..tc.normal..icon.text..separator.."ip"..tc.normal.." "..separator..ip.."\n",
    icon[5]..tc.normal..icon.text..separator.."hn"..tc.normal.." "..separator..get.host(hostname).."\n",
  }
end
