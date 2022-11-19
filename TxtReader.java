import java.util.*;
import java.io.*;

public class TxtReader{
  public static void main(String[] args) {
    //names to include
    HashMap<String, ArrayList<ArrayList<String>>> allNames =
    new HashMap<String, ArrayList<ArrayList<String>>>();
    allNames.put("Jack", new ArrayList<ArrayList<String>>());
    allNames.put("Aden", new ArrayList<ArrayList<String>>());
    allNames.put("Mitchell", new ArrayList<ArrayList<String>>());
    allNames.put("Stefan", new ArrayList<ArrayList<String>>());
    allNames.put("Ryan", new ArrayList<ArrayList<String>>());
    allNames.put("Eben", new ArrayList<ArrayList<String>>());
    allNames.put("Nicholas", new ArrayList<ArrayList<String>>());
    allNames.put("Giles", new ArrayList<ArrayList<String>>());
    allNames.put("Anselm", new ArrayList<ArrayList<String>>());
    allNames.put("Soham Mukherjee", new ArrayList<ArrayList<String>>());

    File file = new File("Raw_9_15_2022.txt");

    try {
      //set up
      Scanner s = new Scanner(file);
      s.nextLine();

      ArrayList<String> statNames = new ArrayList<String>();
      ArrayList<Integer> indices = new ArrayList<Integer>();
      statNames.add("Distance Covered");
      indices.add(8);
      statNames.add("Top Speed");
      indices.add(16);
      statNames.add("Power Plays");
      indices.add(10);
      statNames.add("Player Load");
      indices.add(15);
      statNames.add("Work Ratio");
      indices.add(19);
      statNames.add("Distance/min");
      indices.add(17);

      for (String str : allNames.keySet()){
        for (int i = 0; i < statNames.size(); i ++){
          allNames.get(str).add(new ArrayList<String>());
        }
      }

      //read
      ArrayList<String> playerName = new ArrayList<String> ();
      while (s.hasNextLine()){
        read(s.nextLine(), indices, playerName, allNames);
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
  ArrayList<Integer> indices, ArrayList<String> playerName,
  HashMap<String, ArrayList<ArrayList<String>>> allNames){
    //System.out.println(Arrays.toString(str.split("	")));
    String[] arr = str.split("	");
    String name = trimSpace(arr[2].split(" ")[0]);
    if (allNames.containsKey(name)){
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
