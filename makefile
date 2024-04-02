###################################################

compiler = clang
options  = 
linker   = -lluajit-5.1
output   = leaf
sources  = ./src/main.c

$(output): $(sources)
	$(compiler) -o ./src/$(output) $(sources) $(options) $(linker)

###################################################   

clean:
	rm -f $(output) *.o

###################################################

install:
	mkdir -p /usr/lib/sdx6/$(output)/
	luajit -b ./src/main.lua /usr/lib/sdx6/$(output)/main.lua
	mkdir -p /usr/local/bin/
	cp ./src/$(output) /usr/local/bin/
	mkdir -p /etc/xdg/sdx6/$(output)/
	cp ./xdg/config.lua /etc/xdg/sdx6/$(output)/

###################################################

local:
	mkdir -p ~/.local/bin/
	cp ./src/$(output) ~/.local/bin/
	mkdir -p ~/.local/share/sdx6/$(output)/
	luajit -b ./src/main.lua ~/.local/share/sdx6/$(output)/main.lua

###################################################

test:
	mkdir -p /usr/lib/sdx6/$(output)/
	luajit -b ./src/main.lua /usr/lib/sdx6/$(output)/main.lua
	mkdir -p /usr/local/bin/
	$(compiler) $(options) -o /usr/local/bin/$(output) $(sources) $(linker)

###################################################
