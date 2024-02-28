# leaf - LEAh's Fetch
A minimal, blazingly fast fetch program for Linux
Shows only the useful things, and does them pretty

I made this out of dissatisfaction with fetch scripts, either being way too slow or showing way too much information

`leaf` is intended to be used as a greeter to your shell, wherein over SSH, it would show important information to your session that can be looked at from a glance
# Screenshots

# Compiling from source
Clone the repository
```
 $ git clone https://github.com/sdx6/leaf/
```
# Dependencies
Depending on your distribution of choice, install the required programs using one of these commands:
```
 $ sudo apt install make clang luajit2
```
```
 $ sudo pacman -S make clang luajit
```
```
 $ sudo dnf install make clang luajit
```
```
 $ sudo zypper install make clang
```
```nix
environment.systemPackages = [
  pkgs.gnumake42
  pkgs.rocmPackages.llvm.clang
  pkgs.luajit
];
```
Move to the repository
```
 $ cd leaf/
```
Build and install
```
 $ make
 $ sudo make install
```
Optionally, install locally instead of system (~/.local/bin/)
```
 $ make local
```
