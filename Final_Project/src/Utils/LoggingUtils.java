package Utils;

import java.io.PrintStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LoggingUtils {

  // Costruttore vuoto, può essere omesso se non necessario
  public LoggingUtils() {
  }

  // Metodo per loggare un messaggio con timestamp
  public static void log(String message) {
    // Formatter per la data e l'ora
    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

    // Ottiene il timestamp corrente formattato
    String timestamp = dateTimeFormatter.format(LocalDateTime.now());

    // Stream di output
    PrintStream outputStream = System.out;

    // Logga il messaggio con il timestamp
    outputStream.println("[" + timestamp + "] " + message);
  }
}