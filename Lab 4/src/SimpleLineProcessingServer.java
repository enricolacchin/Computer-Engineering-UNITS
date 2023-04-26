import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class SimpleLineProcessingServer {

  private final int port;
  private final String quitCommand;

  public SimpleLineProcessingServer(int port, String quitCommand) {
    this.port = port;
    this.quitCommand = quitCommand;
  }

  public void run() throws IOException {
    ServerSocket serverSocket = new ServerSocket(port);
    while (true) {
      Socket socket = serverSocket.accept();
      BufferedReader br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
      while (true) {
        String line = br.readLine();
        if (line.equals(quitCommand)) {
          break;
        }
        bw.write(process(line) + System.lineSeparator());
        bw.flush();
      }
      socket.close();
    }
  }

  protected String process(String input) {
    return input;
  }

}