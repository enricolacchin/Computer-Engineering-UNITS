import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class SimpleLineProcessingServer {

  private final int PORT;
  private final String QUIT_COMMAND;
  private final PrintStream ps;

  public SimpleLineProcessingServer(int port, String quitCommand, OutputStream os) {
    this.PORT = port;
    this.QUIT_COMMAND = quitCommand;
    ps = new PrintStream(os);
  }

  public void run() throws IOException {
    ServerSocket serverSocket = new ServerSocket(PORT);
    while (true) {
      Socket socket = serverSocket.accept();
      handleClient(socket);
    }
  }

  protected void handleClient(Socket socket) throws IOException {
    ps.printf("[%1$tY-%1$tm-%1$td %1$tT] Connection from %2$s.%n", System.currentTimeMillis(), socket.getInetAddress());
    int requestsCounter = 0;
    BufferedReader br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
    while (true) {
      String line = br.readLine();
      if (line.equals(QUIT_COMMAND)) {
        break;
      }
      bw.write(process(line) + System.lineSeparator());
      bw.flush();
      requestsCounter += 1;
    }
    socket.close();
    ps.printf("[%1$tY-%1$tm-%1$td %1$tT] Disconnection of %2$s after %3$d requests.%n", System.currentTimeMillis(), socket.getInetAddress(), requestsCounter);
  }

  protected String process(String input) {
    return input;
  }

}