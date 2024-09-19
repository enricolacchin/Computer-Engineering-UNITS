import java.io.File;
import java.util.Random;

public class Main {
  public static void main(String[] args) {

    // Arguments check
    if (args.length < 1) {
      System.err.println("Usage: java Main <file> [<command> ...]");
      System.exit(1);
    }

    // Set argument as path
    String filePathName = args[0];
    FileArray fileArray;

    // Checks if ends with .zip and exists
    if (filePathName.endsWith(".zip") && new File(filePathName).exists()){
      fileArray = new GZIPFileArray(filePathName);
    }
    else if (new File(filePathName).exists()){
      fileArray = new FileArray(filePathName);
    }
    else{
      int n = new Random().nextInt(32) + 1; // from 1 to 32
      fileArray = new FileArray(filePathName, n);
    }

    // Do print and/or increment
    for (int i = 1; i < args.length; i++)
      switch (args[i]) {
        case "i" -> fileArray.incrementAll();
        case "p" -> fileArray.print();
        default -> System.err.println("Unknown command: " + args[i]);
      }
  }
}
