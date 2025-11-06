C guide

This is all subjective.

Resources

- [linux coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html)
- [c style](https://github.com/mcinglis/c-style)

Guide

- Develop with warnings and optimization

```make
CFLAGS += -Wall -Wextra -Wpedantic \
          -Wformat=2 -Wno-unused-parameter -Wshadow \
          -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
          -Wredundant-decls -Wnested-externs -Wmissing-include-dirs -O2

# gcc-only extras
ifeq ($(CC),gcc)
  CFLAGS += -Wjump-misses-init -Wlogical-op
endif
```

- Target a modern standard

```make
CFLAGS += -std=c11
```

- Indentation and width

  - 2 spaces
  - no mixed tab/space indentation
  - hard line limit: 79 characters

- Braces

```c
if (cond) {
  /* body */
} else {
  /* body */
}


/* functions: brace on the next line */
int func(int x)
{
  return x + 1;
}

/* always use braces for multi-statement branches; if only one
   branch needs braces, use them on both branches */
```

- Spaces and operators

```c
/* space after keywords, not after sizeof/typeof/alignof/__attribute__ */
if (x > 0) { ... }
s = sizeof(struct file);

/* pointer stars hug the name */
char *buf, **v;

/* binary/ternary get spaces - unary does not - no spaces around . and -> */
p->field = q ? a + b : c;
++i; j--; x = -y;
```

- Includes

```c
#include "trie.h" // includes alphabet.h
/* don't rely on transitive includes */
#include "alphabet.h"


#ifndef _CONFIG_FOOBAR_H_
#define _CONFIG_FOOBAR_H_

#endif /* _CONFIG_FOOBAR_H_ */
```

- Comments
  - prefer `//`
  - longer blocks `/* ... */`

I don't typically write comments but your commments
should explain why not what.

- Naming
  - descriptive globals and exported functions
  - locals short and clear: `i`, `n`, `tmp`
- Minimize visibility
- Avoid globals/statics. pass state explicitly via args/structs
- Immutability and const

```c
/* const on the right; read types right-to-left */
char const * const msg = "hi";
```

- Prototypes: drop arg names unless they add intent (esp. pointers)

```c
bool trie_eq(Trie, Trie);
void trie_add(Trie const *trie, char const *string);
```

- Prefer double to float unless benchmarks say otherwise

- Declare variables late - one definition per line

- Booleans and comparisons

```c
#include <stdbool.h>
bool ready = false;

if (ptr == NULL) return false;
while (count > 0) { ... }
```

- No hidden state changes in expressions

```c
x = calc();
if (x == 0) { ... }
i++;
```

- Keep conditions simple

```c
int r = listen(fd, backlog);
if (r == -1) { perror("listen"); }
if (is_ready(task)) start(task);
```

- Prefer if/ternary/function pointers over big switch - if you use switch align `switch` and `case`.

```c
switch (kind) {
case A: return X;
case B: return Y;
default: return ERR;
}
```

- Tighten variable scope, extract helpers to shorten lifetimes

```c
int accept_request(int listenfd)
{
	struct sockaddr addr;
	return accept(listenfd, &addr, &(socklen_t){ sizeof addr });
}
```

- Macros - Avoid control-flow surprises and magic locals

```c
#define CONSTEXP (CONSTANT | 3)

/* prefer static inline functions unless
  macro behaves unlike a function (repeats args, returns, etc.) */
#define MACRO_DO(a, b)                \
	do {                                \
		if ((a) == 5)                     \
			do_this((b));                   \
	} while (0)
```

Working on progress...
