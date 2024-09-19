# Lab 4

## Word counter server

1. Design and implement a line processing server *application* (i.e., a class that extends `SimpleLineProcessingServer`
   with a `main()`) that:

- returns the number of words in the input line $l$
- exits with `"bye"`
- listens on port 10000

2. Test it using telnet

- try removing `flush()` call

Note: It likely won't work on repl.

## SimpleLineProcessingServer class Protocol

Protocol (upon connection):

- client sends one text line $l$
- if $l=l_\text{quit}$, server closes connection, otherwise replies with processed line $l'=p(l)$

Server:

- listens on port $n_\text{port}$
- handles 1 client at a time
- never terminates
- **designed** to be extended
- $p:$ `String` $\to$ `String`, $l_\text{quit}$, port number are parameters