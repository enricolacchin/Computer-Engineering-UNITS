# Lab 4

## GZIP file array

1. Design and implement a class `GZIPFileArray` that **extends** `FileArray` and mantains a **compressed** binary file-backed array of `int` values
- with same functionalities of `FileArray` (see [specifications](../Lab%203/Readme.md))
2. Write an application that "uses" `FileArray` or `GZIPFileArray`
- receives $m \ge 1$ parameters at command line
- 1st is a file pathname
    - if not existing, create with $n \sim U(\\{1,\dots,2^5\\})$, otherwise, load
    - if filename ends with `.zip`, use `GZIPFileArray`, otherwise use `FileArray`
- from 2nd on, a list of one-char commands (see [specifications](../Lab%203/Readme.md))