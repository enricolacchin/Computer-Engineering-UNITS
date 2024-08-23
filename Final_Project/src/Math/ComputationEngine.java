package Math;

import Request.*;
import Utils.LogExecutionTime;
import Utils.Response;

import java.util.HashMap;
import java.util.Map;

public class ComputationEngine {
  private static final Map<String, Computation> computations = new HashMap<>();

  static {
    computations.put("MIN", new MinComputation());
    computations.put("MAX", new MaxComputation());
    computations.put("AVG", new AvgComputation());
    computations.put("COUNT", new CountComputation());
  }

  public ComputationEngine() {
  }

  @LogExecutionTime
  public static Response compute(Request request) {
    if (request.getType() != RequestType.COMPUTATION) {
      return new Response("ERR;Invalid request type for computation", false);
    }

    String[] requestParts = request.getContent().split(";");
    if (requestParts.length < 3) {
      return new Response("ERR;Invalid request format: Expected 3 parts but got " + requestParts.length, false);
    }

    String[] computationParts = requestParts[0].split("_");
    if (computationParts.length != 2) {
      return new Response("ERR;Invalid computation format: Expected 'ComputationKind_ValuesKind'", false);
    }

    String computationKind = computationParts[0];
    String valuesKind = computationParts[1];
    Computation computation = computations.get(computationKind);

    if (computation == null) {
      return new Response("ERR;Unsupported computation type: " + computationKind, false);
    }

    try {
      Map<String, double[]> variableValues = RequestParser.parseVariableValuesFunction(requestParts[1]);
      String[] expressions = requestParts[2].split(";");

      if (expressions.length == 0 || (expressions.length == 1 && expressions[0].trim().isEmpty())) {
        return new Response("ERR;No expressions provided", false);
      }

      double[] results = new double[expressions.length];

      for (int i = 0; i < expressions.length; i++) {
        results[i] = evaluateExpression(expressions[i], variableValues, valuesKind);
      }

      double finalResult = computation.compute(results);
      return new Response("OK;" + RequestHandler.decimalFormat.format(RequestHandler.responseTime) + ";" + finalResult, false);

    } catch (IllegalArgumentException e) {
      return new Response("ERR;Invalid variable or expression: " + e.getMessage(), false);
    } catch (ArithmeticException e) {
      return new Response("ERR;Arithmetic error: " + e.getMessage(), false);
    } catch (Exception e) {
      return new Response("ERR;An unexpected error occurred: " + e.getMessage(), false);
    }
  }

  private static double evaluateExpression(String expression, Map<String, double[]> variableValues, String valuesKind) throws Exception {
    double result;

    switch (valuesKind) {
      case "GRID" -> result = evaluateForGrid(expression, variableValues);
      case "LIST" -> result = evaluateForList(expression, variableValues);
      default -> throw new IllegalArgumentException("Invalid values kind: " + valuesKind);
    }

    return result;
  }

  private static double evaluateForGrid(String expression, Map<String, double[]> variableValues) throws Exception {
    Map<String, Double> singleValueMap = new HashMap<>();

    // Popoliamo singleValueMap con tutti i valori per GRID
    for (String varName : variableValues.keySet()) {
      double[] values = variableValues.get(varName);
      if (values.length > 0) {
        singleValueMap.put(varName, values[0]); // Prendi il primo valore della griglia per ogni variabile
      }
    }

    return ExpressionParser.evaluateExpression(expression, singleValueMap);
  }

  private static double evaluateForList(String expression, Map<String, double[]> variableValues) throws Exception {
    double totalResult = 0.0;
    int length = variableValues.values().iterator().next().length;

    for (int i = 0; i < length; i++) {
      Map<String, Double> singleValueMap = new HashMap<>();
      for (Map.Entry<String, double[]> entry : variableValues.entrySet()) {
        singleValueMap.put(entry.getKey(), entry.getValue()[i]);
      }

      totalResult += ExpressionParser.evaluateExpression(expression, singleValueMap);
    }

    return totalResult / length; // Calcola la media dei risultati se necessario
  }
}