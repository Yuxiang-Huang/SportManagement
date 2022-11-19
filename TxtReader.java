import java.util.*;
import java.io.*;

public class TxtReader{
  public static void main(String[] args) {
    //names to include
    ArrayList<String> allNames = new ArrayList<String>();
    allNames.add("Jack");
    allNames.add("Aden");
    allNames.add("Mitchell");
    allNames.add("Stefan");
    allNames.add("Ryan");
    allNames.add("Eben");
    allNames.add("Nicholas");
    allNames.add("Giles");
    allNames.add("Anselm");
    allNames.add("Soham");

    //data
    HashMap<String, ArrayList<ArrayList<String>>> data =
    new HashMap<String, ArrayList<ArrayList<String>>>();
    for (int i = 0; i < allNames.size(); i ++){
      data.put(allNames.get(i), new ArrayList<ArrayList<String>>());
    }

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

      //set up data
      for (String str : data.keySet()){
        for (int i = 0; i < statNames.size(); i ++){
          data.get(str).add(new ArrayList<String>());
        }
      }

      //read
      while (s.hasNextLine()){
        read(s.nextLine(), indices, data);
      }

      //output

      //stats
      for (int i = 0; i < statNames.size() - 1; i ++){
        System.out.print(statNames.get(i) + ", ");
      }

      System.out.println(statNames.get(statNames.size() - 1));

      //data
      for (String str : allNames){
        System.out.println(str);
        for (int i = 0; i < statNames.size(); i ++){
          System.out.print(data.get(str).get(i) + " ");
        }
        System.out.println("");
      }
      System.out.println("End");
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }

  public static void read(String str, ArrayList<Integer> indices,
  HashMap<String, ArrayList<ArrayList<String>>> allNames){
    //System.out.println(Arrays.toString(str.split("	")));
    String[] arr = str.split("	");
    String name = trimSpace(arr[2].split(" ")[0]);
    if (allNames.containsKey(name)){
      for (int i = 0; i < indices.size(); i ++){
        allNames.get(name).get(i).add(arr[indices.get(i)]);
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
