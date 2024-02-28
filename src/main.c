// vim:foldmethod=marker

// {{{ include

#include "lualib.h"
#include "lauxlib.h"
#include "luajit.h"

#include <arpa/inet.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <sys/sysinfo.h>
#include <linux/version.h>
#include <unistd.h>

#define lua_main "/usr/lib/sdx6/leaf/main.lua" /* installed file path */
#define lua_main_local "~/.local/share/sdx6/leaf/main.lua" /* local file path */

// }}}
// {{{ LICENSE

//  ,------------------------------------------------,
// | Permission is hereby granted, free of charge, to |
// | any person obtaining a copy of this software and |
// | associated documentation files (the "Software"), |
// | to deal in the Software without restriction,     |
// | including without limitaion the rights to use,   |
// | copy, modify, merge, publish, distribute,        |
// | sublicense, and/or sell copies of the Software,  |
// | and to permit persons to whom the Software is    |
// | furnished to do so, subject to the following     |
// | contidions:                                      |
// |                                                  |
// | The above copyright notice and this permission   |
// | notice shall be included in all copies or        |
// | substantial portions of the Software.            |
// |                                                  |
// | THE SOFTWARE IS PROIVDED "AS IS", WITHOUT        |
// | WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,        |
// | INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   |
// | MERCHANTABILITY, FITNESS FOR A PARTICULAR        |
// | PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL   |
// | THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR   |
// | ANY CLAIM, DAMAGES, OR OTHER LIABILITY, WHETHER  |
// | IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE,    |
// | ARISING FROM, OUT OF OR IN CONNECTION WITH THE   |
// | SOFTWARE OR THE USE OR OTHER DEALINGS IN THE     |
// | SOFTWARE.                                        |
//  '-_   _------------------------------------------'
//      V         ,----------------------------------,
//   /\ _ /\     / The Software IS NOT INTENDED to    |
// =( > w < )=_ <  run on OSX OR Windows!!!           |
//   )  v  (_/ | \ Tested ONLY on Linux, FOR Linux!!! |
//  ( _\|/_ )_/   '----------------------------------'

// }}}
// {{{ main

int main(int argc, char* argv[])
{
  lua_State* lua = lua_open();
  luaL_openlibs(lua);
  
  // {{{ ip

  int fd;
  struct ifreq ifr;

  fd = socket(AF_INET, SOCK_DGRAM, 0);
  ifr.ifr_addr.sa_family = AF_INET;
  snprintf(ifr.ifr_name, IFNAMSIZ, "wlan0");
  ioctl(fd, SIOCGIFADDR, &ifr);
  lua_pushstring(lua, inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
  lua_setglobal(lua, "wlanip");

  fd = socket(AF_INET, SOCK_DGRAM, 0);
  ifr.ifr_addr.sa_family = AF_INET;
  snprintf(ifr.ifr_name, IFNAMSIZ, "eth0");
  ioctl(fd, SIOCGIFADDR, &ifr);
  lua_pushstring(lua, inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
  lua_setglobal(lua, "ethip");

  // }}}
  // {{{ uptime

  struct sysinfo linuxinfo;
  if(sysinfo(&linuxinfo) != 0) perror("linuxinfo");

  int days, hours, mins, x = 1;
  lua_pushinteger(lua, linuxinfo.uptime);
  lua_setglobal(lua, "uptime");
  days = linuxinfo.uptime / 86400;
  lua_pushinteger(lua, days);
  lua_setglobal(lua, "days");
  hours = (linuxinfo.uptime / 3600) - (days * 24);
  lua_pushinteger(lua, hours);
  lua_setglobal(lua, "hours");
  mins = (linuxinfo.uptime / 60) - (days * 1440) - (hours * 60);
  lua_pushinteger(lua, mins);
  lua_setglobal(lua, "minutes");

  // }}}
  // {{{ args

  lua_newtable(lua);
    for (int i = 0; i < argc; i++)
    {
      lua_pushstring(lua, argv[i]);
      lua_rawseti(lua, -2, i + 1);
    }
  lua_setglobal(lua, "arg");

  // }}}
  // {{{ oops

  if (!lua)
  {
    fprintf(stderr, "[FATAL ERROR]: Insufficient memory to open Lua...\n");
    return 1;
  }
  if (luaL_dofile(lua, lua_main_local)) /* isnt installed locally? */
  {
    if (luaL_dofile(lua, lua_main)) /* doesnt exist at all??? */
    {
      /* welp */
      fprintf(stderr, "[FATAL ERROR]: %s\n", lua_tostring(lua, -1));
      fprintf(stderr, "[FATAL ERROR]: %s\n", lua_tostring(lua, -2));
      lua_pop(lua, -1);
      lua_pop(lua, -1);
      lua_close(lua);
      fprintf(stderr, "\nSomething has probably gone horribly wrong, and the program is no longer able to proceed\n");
      fprintf(stderr, "If this seems like a bug, and not user error, please first ensure you are using the latest version\n");
      fprintf(stderr, "Then please submit a bug report with the error shown just above\n");
      fprintf(stderr, "\nBetter luck next time <3\n");
      return 1;
    }
  }

  // }}}

  lua_close(lua);
  return 0;
}
// }}}
