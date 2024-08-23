package Server;

import Request.RequestHandler;
import Utils.LoggingUtils;
import Utils.Response;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ClientHandler implements Runnable {
  private final Socket clientSocket;

  public ClientHandler(Socket socket) {
    this.clientSocket = socket;
  }

  @Override
  public void run() {
    try (
        BufferedReader in = new BufferedReader(new InputStreamReader(this.clientSocket.getInputStream()));
        PrintWriter out = new PrintWriter(this.clientSocket.getOutputStream(), true)
    ) {
      String request;
      while ((request = in.readLine()) != null) {
        LoggingUtils.log("Received request: " + request);
        Response response = RequestHandler.handleRequest(request);
        out.println(response.getFormattedResponse());

        if (response.isBye()) {
          break;
        }
      }
    } catch (IOException e) {
      LoggingUtils.log("Client handler exception: " + e.getMessage());
      e.printStackTrace();
    } finally {
      try {
        this.clientSocket.close();
      } catch (IOException e) {
        LoggingUtils.log("Failed to close client socket: " + e.getMessage());
      }
      LoggingUtils.log("Client " + clientSocket.getInetAddress().getHostAddress() + " disconnected.");
    }
  }
}