import java.io.*;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class GZIPFileArray extends FileArray {
  public GZIPFileArray(String filePathName) {
    super(filePathName);
  }

  public GZIPFileArray(String filePathName, int n) {
    super(filePathName, n);
  }

  @Override
  protected InputStream createInputStream() throws IOException {
    return new GZIPInputStream(new FileInputStream(filePathName));
  }

  @Override
  protected OutputStream createOutputStream() throws IOException {
    return new GZIPOutputStream(new FileOutputStream(filePathName));
  }
}

/* TO DO:
    - Ensure that read is not duplicated
 */