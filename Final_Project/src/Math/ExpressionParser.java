package Math;

import java.util.Map;
import java.util.Stack;
import java.util.StringTokenizer;

public class ExpressionParser {

  public static double evaluateExpression(String expression, Map<String, Double> variableValues) throws Exception {
    String postfix = toPostfix(expression);
    return evaluatePostfix(postfix, variableValues);
  }

  private static String toPostfix(String expression) throws Exception {
    StringBuilder output = new StringBuilder();
    Stack<String> operators = new Stack<>();
    StringTokenizer tokenizer = new StringTokenizer(expression, "+-*/^() ", true);

    while (tokenizer.hasMoreTokens()) {
      String token = tokenizer.nextToken().trim();

      if (token.isEmpty()) {
        continue;
      }

      if (isNumeric(token) || isVariable(token)) {
        output.append(token).append(' ');
      } else if (token.equals("(")) {
        operators.push(token);
      } else if (token.equals(")")) {
        while (!operators.isEmpty() && !operators.peek().equals("(")) {
          output.append(operators.pop()).append(' ');
        }
        if (!operators.isEmpty() && operators.peek().equals("(")) {
          operators.pop();
        } else {
          throw new Exception("Mismatched parentheses");
        }
      } else if (isOperator(token)) {
        while (!operators.isEmpty() && precedence(token) <= precedence(operators.peek())) {
          output.append(operators.pop()).append(' ');
        }
        operators.push(token);
      } else {
        throw new Exception("Invalid token: " + token);
      }
    }

    while (!operators.isEmpty()) {
      output.append(operators.pop()).append(' ');
    }

    return output.toString().trim();
  }

  private static double evaluatePostfix(String postfix, Map<String, Double> variableValues) throws Exception {
    Stack<Double> stack = new Stack<>();
    String[] tokens = postfix.split(" ");

    for (String token : tokens) {
      if (isOperator(token)) {
        double b = stack.pop();
        double a = stack.pop();
        stack.push(applyOperator(token, a, b));
      } else if (variableValues.containsKey(token)) {
        stack.push(variableValues.get(token));
      } else if (isNumeric(token)) {
        stack.push(Double.parseDouble(token));
      } else {
        throw new IllegalArgumentException("Invalid token or undefined variable: " + token);
      }
    }

    if (stack.size() != 1) {
      throw new Exception("Error in expression evaluation: Stack size is not 1 after evaluation.");
    }

    return stack.pop();
  }

  private static boolean isOperator(String token) {
    return "+-*/^".contains(token);
  }

  private static double applyOperator(String operator, double a, double b) throws Exception {
    return switch (operator) {
      case "+" -> a + b;
      case "-" -> a - b;
      case "*" -> a * b;
      case "/" -> {
        if (b == 0.0) throw new Exception("Division by zero");
        yield a / b;
      }
      case "^" -> Math.pow(a, b);
      default -> throw new Exception("Unsupported operator: " + operator);
    };
  }

  private static int precedence(String operator) {
    return switch (operator) {
      case "+", "-" -> 1;
      case "*", "/" -> 2;
      case "^" -> 3;
      default -> -1;
    };
  }

  private static boolean isNumeric(String token) {
    try {
      Double.parseDouble(token);
      return true;
    } catch (NumberFormatException e) {
      return false;
    }
  }

  private static boolean isVariable(String token) {
    return token.matches("[a-zA-Z][a-zA-Z0-9]*");
  }
}