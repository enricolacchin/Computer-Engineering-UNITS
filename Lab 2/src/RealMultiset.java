import java.util.Arrays;

public class RealMultiset {
  private double[] elements;

  public RealMultiset() {
    elements = new double[0];
  }

  public RealMultiset(double... values) {
    this();
    addAll(values);
  }

  private void add(double value) {
    double[] newElements = new double[elements.length + 1];
    System.arraycopy(elements, 0, newElements, 0, elements.length);
    newElements[elements.length] = value;
    elements = newElements;
  }

  private void addAll(double... values) {
    for (double value : values) {
      add(value);
    }
  }

  public boolean equals(RealMultiset other) {
    if (elements.length != other.elements.length) {
      return false;
    }
    double[] elementsCopy = new double[elements.length];
    double[] otherCopy = new double[elements.length];

    System.arraycopy(elements, 0, elementsCopy, 0, elements.length);
    System.arraycopy(other.elements, 0, otherCopy, 0, elements.length);

    Arrays.sort(elementsCopy);
    Arrays.sort(otherCopy);
    for (int i = 0; i < elements.length; i++) {
      if (elementsCopy[i] != otherCopy[i]) {
        return false;
      }
    }
    return true;
  }

  public int size() {
    return elements.length;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("The elements inside the Multisets are: [ ");
    for (int i = 0; i < elements.length; i++) {
      sb.append(elements[i]);
      if (i < elements.length - 1) {
        sb.append(", ");
      }
    }
    sb.append(" ]");
    return sb.toString();
  }
}
