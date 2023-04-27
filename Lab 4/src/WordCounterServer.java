import java.io.*;

public class WordCounterServer extends SimpleLineProcessingServer {

  private static final int PORT = 10000;
  private static final String QUIT_COMMAND = "bye";

  public WordCounterServer(int port, String quitCommand, OutputStream os) {
    super(port, quitCommand, os);
  }

  @Override
  protected String process(String input) {
    if (input.trim().isEmpty()) { // Check if the input string is empty after trimming
      return "0"; // If it's empty, return "0"
    } else {
      String[] words = input.trim().split("\\s+"); // Split the input line into words using whitespace as the delimiter
      return String.valueOf(words.length); // Return the number of words
      // return String.format("The number of words is: %d ", words.length); // Return the number of words formatted
    }
  }

  public static void main(String[] args) throws IOException {
    WordCounterServer server = new WordCounterServer(PORT, QUIT_COMMAND, System.out);
    server.run();
  }
}