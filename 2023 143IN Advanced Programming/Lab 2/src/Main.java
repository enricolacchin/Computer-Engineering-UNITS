import java.util.Scanner;

public class Main {
  public static void main(String[] args) {

    Scanner sc = new Scanner(System.in);

    System.out.print("Insert the first comma-separated multiset (eg 1, 2, 3, 4.123 etc.): ");
    String multisetOneInput = sc.nextLine();
    String[] multisetOneStrings = multisetOneInput.split(",");
    double[] multisetOneDouble = new double[multisetOneStrings.length];
    for (int i = 0; i < multisetOneStrings.length; i++) {
      multisetOneDouble[i] = Double.parseDouble(multisetOneStrings[i]);
    }
    RealMultiset multisetOne = new RealMultiset(multisetOneDouble);

    System.out.print("Insert the second comma-separated multiset (eg 1, 2, 3, 4.123 etc.): ");
    String multisetTwoInput = sc.nextLine();
    String[] multisetTwoStrings = multisetTwoInput.split(",");
    double[] multisetTwoDouble = new double[multisetTwoStrings.length];
    for (int i = 0; i < multisetTwoStrings.length; i++) {
      multisetTwoDouble[i] = Double.parseDouble(multisetTwoStrings[i]);
    }
    RealMultiset multisetTwo = new RealMultiset(multisetTwoDouble);

    boolean bol = multisetOne.equals(multisetTwo);
    System.out.println("The bags are equals? " + bol);

    System.out.println("The size of the first multiset is: " + multisetOne.size());
    System.out.println("The size of the second multiset is: " + multisetTwo.size());

    System.out.println(multisetOne);
    System.out.println(multisetTwo);
    
  }
}