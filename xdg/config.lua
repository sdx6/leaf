---@diagnostic disable: lowercase-global
---@diagnostic disable: duplicate-set-field
---@diagnostic disable: undefined-global
---@diagnostic disable: unused-local
-- vim:foldmethod=marker

--[[

functions:

  number get.days(nil):
    returns:
      the days uptime

  number get.hours(nil):
    returns:
      the hours uptime

  number get.mins(nil):
    returns:
      the mins uptime

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
      "na" if there is no connected battery

variables:

  ip:
    ip address auto selected from existing devices

  separator:
    the separator between the label and its value

  distro:
    the distribution icon using the default os-release location

  icon:
    a table with 5 elements that represent the distribution icon using the distro variable, and an additional one to specify the text color:

  tc:
    a table of colors and color states:
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

default configuration:

  return function(get, ip, separator, distro, icon, tc, version, hostname, os_release)
    version = "/proc/version"
    hostname = "/etc/hostname"
    os_release = "/etc/os-release"

    separator = "│"

    display =
    {
      string.format("%s "..icon.text.."os"..tc.normal.." "..separator.." %s\n", icon[1]..tc.normal, distro),
      string.format("%s "..icon.text.."kv"..tc.normal.." "..separator.." %s\n", icon[2]..tc.normal, get.kernel(version)),
      string.format("%s "..icon.text.."up"..tc.normal.." "..separator.." %dd %dh %dm\n", icon[3]..tc.normal, get.days(), get.hours(), get.mins()),
      string.format("%s "..icon.text.."ip"..tc.normal.." "..separator.." %s\n", icon[4]..tc.normal, ip),
      string.format("%s "..icon.text.."hn"..tc.normal.." "..separator.." %s\n", icon[5]..tc.normal, get.host(hostname)),
    }
  end

--]]
