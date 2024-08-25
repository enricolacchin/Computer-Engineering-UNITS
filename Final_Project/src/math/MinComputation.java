package math;

public class MinComputation implements Computation {
    public MinComputation() {
    }

    public double compute(double... args) {
        double min = Double.MAX_VALUE;

        for (double value : args) {
            if (value < min) {
                min = value;
            }
        }

        return min;
    }
}