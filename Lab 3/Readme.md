# Lab 3

## File array

1. Design and implement a class `FileArray` that mantains a **binary file-backed** array of `int` values, with constructors/methods to:
- build a new array with $n$ random values $\sim U(\\{0,\dots,2^{10}\\})$
- load an existing array
- print the array
- increment all elements of the arrays
2. Write an application that "uses" `FileArray`
- receives $m \ge 1$ parameters at command line
- 1st is a file pathname
    - if not existing, create with $n \sim U(\\{1,\dots,2^5\\})$, otherwise, load
- from 2nd on, a list of one-char commands:
    - `i` for increment
    - `p` for print

### `FileArray`

```java
public class FileArray {
  // loads an existing file
  public FileArray(String filePathName) { /* ... */ }
  // creates new file with n random elements
  public FileArray(String filePathName, int n) { /* ... */ }
  // pretty print with at most 5 aligned elements per row
  public void print();
  //increment all elements
  public void incrementAll();
}
```
Hints:
- for (pseudo)random generation, see [`Random`](https://docs.oracle.com/en/java/javase/13/docs/api/java.base/java/util/Random.html)`.nextInt()`
- "ignore" exceptions
- use two "internal" methods:
    - read: file $\rightarrow$ `int[]`
    - write: `int[]` $\rightarrow$ file
    - e.g.: print=read,print; incrementAll=read,inc,write

### Application using `FileArray`

Assuming `test.bin` exists with 13 values:

```bash
user@cpu:~$ java FileArrayTester test.bin p i i p
[00-04]  8 73 12  4 99
[05-09] 13 23 75 33  9
[10-12] 18  6 78
[00-04]  10  75  14   6 101
[05-09]  15  25  77  35  11
[10-12]  20   8  80
```
And the file content is left accordingly.

Note:
- **alignment** and (zero-padded aligned) **indexes**
- column width is the shortest possible (2 at 1st `p`, 3 at 2nd `p`)

Hint: use `printf` or `String.format()`, e.g., `%3d`

# Lab 3 bis

## GZIP file array

1. Design and implement a class `GZIPFileArray` that **extends** `FileArray` and mantains a **compressed** binary file-backed array of `int` values
- with same functionalities of `FileArray` (see [specifications](../Lab%203/Readme.md))
2. Write an application that "uses" `FileArray` or `GZIPFileArray`
- receives $m \ge 1$ parameters at command line
- 1st is a file pathname
  - if not existing, create with $n \sim U(\\{1,\dots,2^5\\})$, otherwise, load
  - if filename ends with `.zip`, use `GZIPFileArray`, otherwise use `FileArray`
- from 2nd on, a list of one-char commands (see [specifications](../Lab%203/Readme.md))