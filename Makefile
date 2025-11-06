CFLAGS=-Isrc -std=c11 -O2 -Wall -Wextra # -g -DDEBUG
CFLAGS+=-Wall -Wextra -Wpedantic \
				-Wformat=2 -Wno-unused-parameter -Wshadow \
				-Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
				-Wredundant-decls -Wnested-externs -Wmissing-include-dirs
SRC=src
BIN=bin

main: src/main.c | mkbin
	$(CC) $(CFLAGS) src/main.c -o $(BIN)/main

mkbin:
	@ mkdir -p $(BIN)

doc:
	doxygen

.PHONY: main mkbin doc clean
clean:
	@ rm -rf $(BIN)/* core* *~ src/*~ docs/* *.dSYM

