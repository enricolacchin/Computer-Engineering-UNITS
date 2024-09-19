public interface ControlSystem<Input, Output> {
  default Output process(Input input) {
    return null;
  }
}