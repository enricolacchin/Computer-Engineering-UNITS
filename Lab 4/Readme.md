# Lab 4

## Word counter server

1. Design and implement a line processing server *application* (i.e., a class that extends `SimpleLineProcessingServer` with a `main()`) that:
- returns the number of words in the input line $l$
- exits with `"bye"`
- listens on port 10000
2. Test it using telnet
- try removing `flush()` call

Note: It likely won't work on repl.