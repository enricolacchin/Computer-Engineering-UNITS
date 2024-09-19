package math;

public class CountComputation implements Computation {
    public CountComputation() {
    }

    public double compute(double... args) {
        return args.length;
    }
}