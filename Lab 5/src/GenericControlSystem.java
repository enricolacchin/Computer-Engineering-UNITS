import java.util.function.Function;

public class GenericControlSystem<Input, Output> implements ControlSystem<Input, Output> {
  private final Function<Input, Output> function;

  public GenericControlSystem(Function<Input, Output> function) {
    this.function = function;
  }

  @Override
  public Output process(Input input) {
    return function.apply(input);
  }
}
