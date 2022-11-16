import java.util.*;
import java.io.*;

public class TxtReader{
  public static void main(String[] args) {
    File file = new File("Raw_9_15_2022.txt");
    try {
      //set up
      Scanner s = new Scanner(file);
      s.nextLine();

      ArrayList<String> statNames = new ArrayList<String>();
      ArrayList<Integer> indices = new ArrayList<Integer>();
      statNames.add("distance covered");
      indices.add(8);
      statNames.add("power plays");
      indices.add(10);
      // statNames.add("top speed");
      // statNames.add("player load");
      // statNames.add("work ratio");
      // statNames.add("distance/min");

      ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
      for (int i = 0; i < statNames.size(); i ++){
        data.add(new ArrayList<String>());
      }

      //read
      ArrayList<String> playerName = new ArrayList<String> ();
      while (s.hasNextLine()){
        read(s.nextLine(), data, indices, playerName);
      }

      //output
      for (int i = 0; i < statNames.size() - 1; i ++){
        System.out.print(statNames.get(i) + ", ");
      }

      System.out.println(statNames.get(statNames.size() - 1));

      for (int i = 0; i < playerName.size(); i ++){
        System.out.print(playerName.get(i) + ": ");
        for (int j = 0; j < data.size(); j ++){
          System.out.print(data.get(j).get(i) + " ");
        }

        System.out.println("");
      }
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }

  public static void read(String str, ArrayList<ArrayList<String>> data,
  ArrayList<Integer> indices, ArrayList<String> playerName){
    //System.out.println(Arrays.toString(str.split("	")));
    String[] arr = str.split("	");
    playerName.add(trimSpace(arr[2]));
    for (int i = 0; i < indices.size(); i ++){
      data.get(i).add(arr[indices.get(i)]);
    }
  }

  public static String trimSpace(String str){
    if (str.charAt(str.length()-1) == ' ') {
      return str.substring(0, str.length() - 1);
    }
    return str;
  }
}
