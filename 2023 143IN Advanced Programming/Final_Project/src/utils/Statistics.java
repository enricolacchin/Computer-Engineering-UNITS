package utils;

public class Statistics {
    private static int numberOfRequests = 0;
    private static double totalResponseTime = 0.0;
    private static double maxResponseTime = 0.0;

    public static synchronized void logRequest(double responseTime) {
        numberOfRequests++;
        totalResponseTime += responseTime;
        if (responseTime > maxResponseTime) {
            maxResponseTime = responseTime;
        }
    }

    public static int getNumberOfRequests() {
        return numberOfRequests;
    }

    public static double getAverageResponseTime() {
        return numberOfRequests == 0 ? 0 : totalResponseTime / numberOfRequests;
    }

    public static double getMaxResponseTime() {
        return maxResponseTime;
    }
}