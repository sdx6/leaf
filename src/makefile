###################################################   

compiler = clang
options  =
linker   = -lluajit-5.1
output   = leaf
sources  = main.c

$(output): $(sources)
	$(compiler) $(options) -o $(output) $(sources) $(linker)

###################################################   

clean:
	rm -f $(output) *.o

###################################################

install:
	mkdir -p /usr/lib/sdx6/$(output)/
	luajit -b main.lua /usr/lib/sdx6/$(output)/main.lua
	mkdir -p /usr/local/bin/
	cp $(output) /usr/local/bin/

###################################################

local:
	mkdir -p ~/.local/bin/
	cp $(output) ~/.local/bin/
	mkdir -p ~/.local/share/sdx6/$(output)/
	luajit -b main.lua ~/.local/share/sdx6/$(output)/main.lua

###################################################

test:
	mkdir -p /usr/lib/sdx6/$(output)/
	luajit -b main.lua /usr/lib/sdx6/$(output)/main.lua
	mkdir -p /usr/local/bin/
	$(compiler) $(options) -o /usr/local/bin/$(output) $(sources) $(linker)

###################################################
