package math;

public class AvgComputation implements Computation {
    public AvgComputation() {
    }

    public double compute(double... args) {
        if (args.length == 0) {
            throw new IllegalArgumentException("No values provided");
        } else {
            double sum = 0.0;

            for (double value : args) sum += value;

            return sum / (double) args.length;
        }
    }
}