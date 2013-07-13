# OS detected
ifeq ($(OS),Windows_NT)
	ifneq ($(findstring .exe,$(SHELL)),)
    OS_TYPE := Windows
	else
    OS_TYPE := Cygwin
	endif
else
    OS_TYPE := $(shell uname -s)
endif

all:unpack example doc

unpack:FORCE
	make -C ./hustbeamer unpack

example ./hustbeamer/hustbeamer-example.pdf:
	make -C ./hustbeamer example

doc ./hustbeamer/hustbeamer.pdf:
	make -C ./hustbeamer doc

clean:
	make -C ./hustbeamer clean

reallyclean:
	make -C ./hustbeamer reallyclean

install:unpack ./hustbeamer/hustbeamer-example.pdf ./hustbeamer/hustbeamer.pdf
ifeq ($(OS_TYPE),Windows)
	./install/win32.bat install
else
	./install/unix.sh install
endif

uninstall:
ifeq ($(OS_TYPE),Windows)
	./install/win32.bat uninstall
else
	./install/unix.sh uninstall
endif

FORCE:
.PHONY:all unpack example doc install uninstall clean reallyclean FORCE
