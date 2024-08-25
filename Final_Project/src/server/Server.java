package server;

import utils.LoggingUtils;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private final int port;

    public Server(int port) {
        this.port = port;
    }

    public static void main(String[] args) {
        int port = 10000;
        if (args.length > 0) {
            port = Integer.parseInt(args[0]);
        }

        new Server(port).start();
    }
  
    public void start() {
        try (ServerSocket serverSocket = new ServerSocket(this.port)) {
            LoggingUtils.log("Server started on port " + this.port);

            while (true) {
                try {
                    Socket clientSocket = serverSocket.accept();
                    String clientIpAddress = clientSocket.getInetAddress().getHostAddress();
                    LoggingUtils.log("New client connected: " + clientIpAddress);

                    new Thread(new ClientHandler(clientSocket)).start();
                } catch (IOException e) {
                    LoggingUtils.log("Error handling client connection: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            LoggingUtils.log("Server exception: " + e.getMessage());
            e.printStackTrace();
        }
    }
}