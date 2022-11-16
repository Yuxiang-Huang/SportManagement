import java.util.*;
import java.io.*;

public class TxtTransformer{
  public static void main(String[] args) {
    File file = new File("9_15_2022.txt");
    try {
      Scanner s = new Scanner(file);
      s.nextLine();
      while (s.hasNextLine()){
        transform(s.nextLine());
      }
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }
  public static void transform(String str){
    //System.out.println(Arrays.toString(str.split("	")));
    String[] arr = str.split("	");
    //distance is index 8
    System.out.println(arr[8]);
  }
}
