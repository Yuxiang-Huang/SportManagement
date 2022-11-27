public class PlayerButton{
  float x; 
  float y;    
  int wid;
  int hei;
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
    
    this.y = yIndex * (height - benchLen) / num + (height - benchLen) / num / 2;
    this.wid = size;
    this.hei = size;
    this.position = pos;
    this.name = name;
    origColor = c;
  }
  
  public PlayerButton(float xIndex, color c, int wid, int hei, String name, String pos, int total) {
    if (xIndex > total/2){
      this.x = (xIndex - (total+1)/2) * width / (total / 2 + 1) + width / total;
      this.y = height - benchLen / 4;
      this.wid = wid;
      this.hei = hei;
      this.position = pos;
      this.name = name;
      origColor = c;
    } else{
      this.x = xIndex * width / (total / 2 + 1) + width / total;
      this.y = height - benchLen * 3 / 4;
      this.wid = wid;
      this.hei = hei;
      this.position = pos;
      this.name = name;
      origColor = c;
    }
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
      fill(0, 255, 255);
    } else{
      fill(origColor);
    }
    
    rect(x, y, wid, hei);
    
    fill(0);
    textSize(buttonFontSize);
    text(name, x, y);
    textSize(fontSize);
  }
    
  boolean over()  {
    if (mouseX >= x-wid/2 && mouseX <= x+wid/2 && 
        mouseY >= y-hei/2 && mouseY <= y+hei/2) {
      return true;
    } else {
      return false;
    }
  }
}
