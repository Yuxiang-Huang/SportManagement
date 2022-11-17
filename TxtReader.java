import java.util.*;
import java.io.*;

public class TxtReader{
  public static void main(String[] args) {
    //names to include
    ArrayList<String> allNames = new ArrayList<String>();
    allNames.add("Jack");
    allNames.add("Aden");
    allNames.add("Mitchell Deutsch");
    allNames.add("Stefan Broge");
    allNames.add("Ryan Petrauskas");
    allNames.add("Eben Eichenwald");
    allNames.add("Nicholas Jung");
    allNames.add("Giles El-Assal");
    allNames.add("Anselm");
    allNames.add("Soham Mukherjee");

    File file = new File("Raw_9_15_2022.txt");

    try {
      //set up
      Scanner s = new Scanner(file);
      s.nextLine();

      ArrayList<String> statNames = new ArrayList<String>();
      ArrayList<Integer> indices = new ArrayList<Integer>();
      statNames.add("Distance Covered (miles)");
      indices.add(8);
      statNames.add("Top Speed (mph)");
      indices.add(16);
      statNames.add("Power Plays (times)");
      indices.add(10);
      statNames.add("Player Load");
      indices.add(15);
      statNames.add("Work Ratio");
      indices.add(19);
      statNames.add("Distance/min (m/min)");
      indices.add(17);

      ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
      for (int i = 0; i < statNames.size(); i ++){
        data.add(new ArrayList<String>());
      }

      //read
      ArrayList<String> playerName = new ArrayList<String> ();
      while (s.hasNextLine()){
        read(s.nextLine(), data, indices, playerName, allNames);
      }

      //output
      for (int i = 0; i < statNames.size() - 1; i ++){
        System.out.print(statNames.get(i) + ", ");
      }

      System.out.println(statNames.get(statNames.size() - 1));

      for (int i = 0; i < playerName.size(); i ++){
        System.out.println(playerName.get(i));
        for (int j = 0; j < data.size(); j ++){
          System.out.print(data.get(j).get(i) + " ");
        }

        System.out.println("");
      }
      System.out.println("End");
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }

  public static void read(String str, ArrayList<ArrayList<String>> data,
  ArrayList<Integer> indices, ArrayList<String> playerName, ArrayList<String> allNames){
    //System.out.println(Arrays.toString(str.split("	")));
    String[] arr = str.split("	");
    if (allNames.contains(trimSpace(arr[2]))){
      playerName.add(trimSpace(arr[2]));
      for (int i = 0; i < indices.size(); i ++){
        data.get(i).add(arr[indices.get(i)]);
      }
    }
  }

  //take out space in end
  public static String trimSpace(String str){
    if (str.charAt(str.length()-1) == ' ') {
      return str.substring(0, str.length() - 1);
    }
    return str;
  }
}
