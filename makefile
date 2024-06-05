###################################################

compiler = clang
options  = -march=native -O3 -flto=thin -fsanitize=scudo -pipe
linker   = -lluajit-5.1 -Wl,-O3
output   = leaf
sources  = ./src/main.c

$(output): $(sources)
	$(compiler) -o ./src/$(output) $(sources) $(options) $(linker)

###################################################   

clean:
	rm -f $(output) *.o

###################################################

install:
	mkdir -pv /usr/lib/sdx6/$(output)/
	luajit -b ./src/main.lua /usr/lib/sdx6/$(output)/main.lua
	mkdir -pv /usr/local/bin/
	cp ./src/$(output) /usr/local/bin/
	mkdir -pv /etc/xdg/sdx6/$(output)/
	cp ./xdg/config.lua /etc/xdg/sdx6/$(output)/

###################################################

local:
	mkdir -pv ~/.local/bin/
	cp ./src/$(output) ~/.local/bin/
	mkdir -pv ~/.local/share/sdx6/$(output)/
	luajit -b ./src/main.lua ~/.local/share/sdx6/$(output)/main.lua

###################################################

test:
	mkdir -pv /usr/lib/sdx6/$(output)/
	luajit -b ./src/main.lua /usr/lib/sdx6/$(output)/main.lua
	mkdir -pv /usr/local/bin/
	$(compiler) $(options) -o /usr/local/bin/$(output) $(sources) $(linker)

###################################################
