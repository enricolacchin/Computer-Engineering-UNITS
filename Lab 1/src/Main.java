import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

public class Main {
  public static void main(String[] args) {
    // Obtain word and number of anagrams that are needed
    Scanner sc = new Scanner(System.in);

    System.out.print("Enter the word whose anagrams you want: ");
    String word = sc.nextLine();
    sc.close(); // Close scanner;

    System.out.println("Anagrams of " + word + ":");

    if (args.length == 0) {
      generateAllAnagrams(word);
    } else {
      int numAnagrams = Integer.parseInt(args[0]);
      generateAnagrams(word, numAnagrams);
    }
  }

  public static void generateAnagrams(String word, int numAnagrams) {
    String[] anagrams = new String[numAnagrams];

    // Convert the word to a char array, and sort it in alphabetical order
    char[] chars = word.toLowerCase().toCharArray();
    Arrays.sort(chars);

    // Keep generating anagrams until we have the desired number of unique anagrams
    String[] uniqueAnagrams = new String[numAnagrams];
    int wordGenerated = 0;
    int i = 0;
    while (i < numAnagrams) {
      shuffle(chars); // Shuffle the sorted char array to generate a random permutation
      String anagram = new String(chars);
      uniqueAnagrams[i] = anagram; // Add the anagram to the set of unique anagrams
      i++;
    }
    // Capitalize each unique anagram using the capitalization of the original word, and add it to the list of anagrams
    for (String uniqueAnagram : uniqueAnagrams) {
      anagrams[wordGenerated] = capitalize(uniqueAnagram);
      wordGenerated++;
    }

    if (numAnagrams > fatt(word.length())) {
      for (i = 0; i <= fatt(word.length()); i++) {
        System.out.println(anagrams[i]);
      }
    } else {
      for (String anagram : anagrams) {
        System.out.println(anagram);
      }
    }
  }

  public static void generateAllAnagrams(String word) {
    int possibleAnagrams = fatt(word.length());
    String[] anagrams = new String[possibleAnagrams];

    // Convert the word to a char array, and sort it in alphabetical order
    char[] chars = word.toLowerCase().toCharArray();
    Arrays.sort(chars);

    // Keep generating anagrams until we have the desired number of unique anagrams
    String[] uniqueAnagrams = new String[possibleAnagrams];
    int wordGenerated = 0;
    int i = 0;
    while (i < possibleAnagrams) {
      shuffle(chars); // Shuffle the sorted char array to generate a random permutation
      String anagram = new String(chars);
      uniqueAnagrams[i] = anagram; // Add the anagram to the set of unique anagrams
      i++;
    }
    // Capitalize each unique anagram using the capitalization of the original word, and add it to the list of anagrams
    for (String uniqueAnagram : uniqueAnagrams) {
      anagrams[wordGenerated] = capitalize(uniqueAnagram);
      wordGenerated++;
    }

    for (String anagram : anagrams) {
      System.out.println(anagram);
    }
  }

  // This method shuffles a given char array in place using the Fisher-Yates algorithm
  private static void shuffle(char[] chars) {
    Random rand = new Random();
    for (int i = chars.length - 1; i > 0; i--) {
      int j = rand.nextInt(i + 1);
      char temp = chars[i];
      chars[i] = chars[j];
      chars[j] = temp;
    }
  }

  // This method capitalizes a given anagram using the capitalization of a given word
  private static String capitalize(String anagram) {
    return anagram.substring(0, 1).toUpperCase() + anagram.substring(1);
  }

  // This method gives me the factorial of a number
  private static int fatt(int num) {
    int fact = 1;
    for (int i = 1; i <= num; i = i + 1) {
      fact = fact * i;
    }
    return fact;
  }
}