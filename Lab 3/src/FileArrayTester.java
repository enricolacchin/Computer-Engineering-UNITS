import java.io.File;
import java.util.Random;

public class FileArrayTester {
  public static void main(String[] args) {

    // Arguments check
    if (args.length < 1) {
      System.err.println("Usage: java Main <file> [<command> ...]");
      System.exit(1);
    }

    String filePathName = args[0];
    FileArray fileArray;

    if (new File(filePathName).exists()) {
      fileArray = new FileArray(filePathName);
    }
    else {
      int n = new Random().nextInt(32) + 1; // from 1 to 32
      fileArray = new FileArray(filePathName, n);
    }

    for (int i = 1; i < args.length; i++)
      switch (args[i]) {
        case "i" -> fileArray.incrementAll();
        case "p" -> fileArray.print();
        default -> System.err.println("Unknown command: " + args[i]);
      }
  }
}
