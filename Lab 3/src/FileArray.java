import java.io.*;
import java.util.*;

public class FileArray {
  public final int[] array;
  public final String filePathName;
  private static final int MAX_VALUE = 1024;
  private static final int ALIGNMENT = 5;

  // Loads an existing file
  public FileArray(String filePathName) {
    this.filePathName = filePathName;
    array = read();
  }

  // Creates new file with n random elements
  public FileArray(String filePathName, int n) {
    this.filePathName = filePathName;
    array = new int[n];
    Random random = new Random();
    for (int i = 0; i < n; i++) {
      array[i] = random.nextInt(MAX_VALUE);
    }
    write();
  }

  // Print with at most 5 elements per row
  public void print() {
    int start = 0;
    int end = ALIGNMENT - 1;
    while (start < array.length) {
      if(end > array.length){
        end = array.length;
      }
      System.out.printf("[%02d-%02d] ", start, end);
      for (int j = start; j <= end && j < array.length; j++) {
        System.out.printf("%" + ALIGNMENT + "d", array[j]);
      }
      System.out.println();
      start = end + 1;
      end = start + ALIGNMENT - 1;
    }
  }

  // Increment all elements
  public void incrementAll() {
    for (int i = 0; i < array.length; i++) {
      array[i]++;
    }
    write();
  }

  // Read file to array
  private int[] read() {
    try (DataInputStream input = new DataInputStream(createInputStream())) {
      int n = input.readInt();
      int[] array = new int[n];
      for (int i = 0; i < n; i++) {
        array[i] = input.readInt();
      }
      return array;
    } catch (IOException e) {
      return new int[0];
    }
  }

  // Write array to file
  private void write() {
    try (DataOutputStream output = new DataOutputStream(createOutputStream())) {
      output.writeInt(array.length);
      for (int value : array) {
        output.writeInt(value);
      }
    } catch (IOException e) {
      // ignore for now
    }
  }

  protected InputStream createInputStream() throws IOException {
    return new FileInputStream(filePathName);
  }

  protected OutputStream createOutputStream() throws IOException {
    return new FileOutputStream(filePathName);
  }
}