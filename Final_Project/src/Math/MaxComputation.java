package Math;

public class MaxComputation implements Computation {
  public MaxComputation() {
  }

  public double compute(double... args) {
    double max = Double.MIN_VALUE;

    for (double value : args) {
      if (value > max) {
        max = value;
      }
    }

    return max;
  }
}
