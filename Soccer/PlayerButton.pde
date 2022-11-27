public class PlayerButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  
  boolean checked = true;
  
  String name;
  String position;

  //each stat in order of session
  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>();

  public PlayerButton(float yIndex, color c, int size, String name, String pos) {
    int num;
    //find number of button in a column
    if (pos.equals("Defense")){
      num = 4;
    } else{
      num = 3;
    }
    
    //set x value base on pos
    if (pos.equals("Defense")){
      num = 4;
      x = width / 4;
    } else{
      num = 3;
      if (pos.equals("Center")){ 
        x = width / 2;
      }
      else if (pos.equals("Offense")){ 
        x = width * 3 / 4;
      }
    }
    
    this.y = yIndex * height / num + height / num / 2;
    this.size = size;
    this.position = pos;
    this.name = name;
    origColor = c;
  }
  
  public PlayerButton(float yIndex, color c, int size, String name, String pos, int total) {
    this.y = yIndex * height / total + height / total / 2;
    this.size = size;
    this.position = pos;
    this.name = name;
    origColor = c;
  }
  
  void update(String name) {
    //update over
    if (over()){
      over = true;
    } 
    else {
      over = false;
    }
    
    //color on or off
    if (checked){
      fill(0, 0, 255);
    } else{
      fill(origColor);
    }
    
    rect(x, y, size, size);
    
    fill(0);
    textSize(buttonFontSize);
    text(name, x, y);
    textSize(fontSize);
  }
    
  boolean over()  {
    if (mouseX >= x-size/2 && mouseX <= x+size/2 && 
        mouseY >= y-size/2 && mouseY <= y+size/2) {
      return true;
    } else {
      return false;
    }
  }
}
