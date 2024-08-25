package request;

import math.ComputationEngine;
import utils.Response;
import utils.Statistics;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public class RequestHandler {

    public static final DecimalFormat decimalFormat;
    public static double responseTime;

    static {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.US);
        symbols.setDecimalSeparator('.');
        decimalFormat = new DecimalFormat("#0.000000", symbols);
    }

    public RequestHandler() {
    }

    public static Response handleRequest(String request) {
        long startTime = System.nanoTime(); // Inizia la misurazione del tempo

        if (request.equals("BYE")) {
            return new Response("OK;0.000;BYE", true);
        } else {
            try {
                // Controlla se la richiesta è una delle richieste statistiche
                if (request.equals("STAT_REQS") || request.equals("STAT_AVG_TIME") || request.equals("STAT_MAX_TIME")) {
                    return handleStatRequest(request);
                }

                // Altrimenti, trattala come una richiesta di calcolo
                Request parsedRequest = RequestParser.parse(request);
                Response response = ComputationEngine.compute(parsedRequest);

                long endTime = System.nanoTime(); // Termina la misurazione del tempo
                responseTime = (endTime - startTime) / 1_000_000_000.0; // Converti il tempo in secondi

                Statistics.logRequest(responseTime); // Registra il tempo di risposta

                return response;
            } catch (Exception e) {
                return new Response("ERR;" + e.getMessage(), false);
            }
        }
    }

    private static Response handleStatRequest(String request) {
        return switch (request) {
            case "STAT_REQS" -> new Response("OK;0.000;" + Statistics.getNumberOfRequests(), false);
            case "STAT_AVG_TIME" ->
                    new Response("OK;0.000;" + decimalFormat.format(Statistics.getAverageResponseTime()), false);
            case "STAT_MAX_TIME" ->
                    new Response("OK;0.000;" + decimalFormat.format(Statistics.getMaxResponseTime()), false);
            default -> new Response("ERR;Invalid stat request", false);
        };
    }
}