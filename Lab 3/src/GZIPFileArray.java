import java.io.*;

public class GZIPFileArray extends FileArray {
  public GZIPFileArray(String filePathName) {
    super(filePathName);
  }

  public GZIPFileArray(String filePathName, int n) {
    super(filePathName, n);
  }

  @Override
  protected FileInputStream createInputStream() throws FileNotFoundException {
    return new FileInputStream(filePathName);
  }

  @Override
  protected FileOutputStream createOutputStream() throws FileNotFoundException {
    return new FileOutputStream(filePathName);
  }
}

/* TO DO:
    - Ensure that read is not duplicated
 */