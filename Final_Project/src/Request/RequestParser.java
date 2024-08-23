package Request;

import java.util.HashMap;
import java.util.Map;

public class RequestParser {

  public static Request parse(String requestString) throws Exception {
    if (requestString.startsWith("STAT_")) {
      return new Request(RequestType.STAT, requestString);
    } else if (requestString.equals("BYE")) {
      return new Request(RequestType.BYE, requestString);
    } else if (isComputationRequest(requestString)) {
      return parseComputationRequest(requestString);
    } else {
      throw new Exception("Invalid request format");
    }
  }

  private static boolean isComputationRequest(String requestString) {
    return requestString.contains("_") && requestString.contains(";");
  }

  private static Request parseComputationRequest(String requestString) throws Exception {
    // Assumiamo che sia una richiesta di calcolo
    String[] parts = requestString.split(";");
    if (parts.length < 3 || parts[2].trim().isEmpty()) {
      throw new Exception("Invalid request format: must contain computation kind, variable values, and non-empty expressions");
    }

    String[] computationParts = parts[0].split("_");
    if (computationParts.length != 2) {
      throw new Exception("Invalid computation format: must contain computation kind and values kind");
    }

    String computationKind = computationParts[0];
    String valuesKind = computationParts[1];

    // Verifica la validità dei kind
    if (!isValidComputationKind(computationKind) || !isValidValuesKind(valuesKind)) {
      throw new Exception("Invalid computation or values kind");
    }

    // Parsing delle espressioni
    String[] expressions = parts[2].split(";");
    if (expressions.length == 0 || (expressions.length == 1 && expressions[0].trim().isEmpty())) {
      throw new Exception("No expressions provided");
    }

    return new Request(RequestType.COMPUTATION, requestString);
  }

  private static boolean isValidComputationKind(String kind) {
    return kind.equals("MAX") || kind.equals("MIN") || kind.equals("AVG") || kind.equals("COUNT");
  }

  private static boolean isValidValuesKind(String kind) {
    return kind.equals("GRID") || kind.equals("LIST");
  }

  public static Map<String, double[]> parseVariableValuesFunction(String functionString) throws Exception {
    Map<String, double[]> variableValues = new HashMap<>();

    String[] variables = functionString.split(",");
    for (String variable : variables) {
      String[] parts = variable.split(":");
      if (parts.length != 4) {
        throw new Exception("Invalid VariableValues format: " + variable);
      }

      String varName = parts[0];
      double lowerBound = Double.parseDouble(parts[1]);
      double step = Double.parseDouble(parts[2]);
      double upperBound = Double.parseDouble(parts[3]);

      if (step <= 0) {
        throw new Exception("Step value must be positive for variable: " + varName);
      }

      int size = (int) Math.ceil((upperBound - lowerBound) / step) + 1;
      double[] values = new double[size];
      for (int i = 0; i < size; i++) {
        values[i] = lowerBound + i * step;
      }

      variableValues.put(varName, values);
    }

    return variableValues;
  }
}