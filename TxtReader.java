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
      while (s.hasNextLine()){
        read(s.nextLine(), data, indices);
      }

      //output
      for (int i = 0; i < statNames.size(); i ++){
        System.out.println(statNames.get(i));
        System.out.println(data.get(i));
      }
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }
  public static void read(String str, ArrayList<ArrayList<String>> data,
  ArrayList<Integer> indices){
    //System.out.println(Arrays.toString(str.split("	")));
    String[] arr = str.split("	");
    for (int i = 0; i < indices.size(); i ++){
      data.get(i).add(arr[indices.get(i)]);
    }
  }
}
