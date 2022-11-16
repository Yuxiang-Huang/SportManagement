import java.util.*;
import java.io.*;

public class TxtReader{
  public static void main(String[] args) {
    File file = new File("9_15_2022.txt");
    try {
      //set up
      Scanner s = new Scanner(file);
      s.nextLine();

      ArrayList<String> statNames = new ArrayList<String>();
      ArrayList<Integer> indices = new ArrayList<Integer>();
      statNames.add("distance covered");
      indices.add(8);
      // statNames.add("top speed");
      // statNames.add("power plays");
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
      for (int i = 0; i < statNames.size(); i ++){
        System.out.print(statNames.get(i) + ", ");
      }

      System.out.println("");

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
    playerName.add(arr[2]);
    for (int i = 0; i < indices.size(); i ++){
      data.get(i).add(arr[indices.get(i)]);
    }
  }
}
