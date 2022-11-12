public class SessionButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  boolean active = true;
  
  HashMap<String, float[]> stats = new HashMap<String, float[]>();
  float[] teamGoal;

  public SessionButton(float x, float y, color c, int size) {
    origColor = c;
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void update() {
    if (active){
      //update over
      if (over()){
        over = true;
      } 
      else {
        over = false;
      }
      
      if (over) {
        fill(highlight);
      } else {
        fill(origColor);
      }
  
      rect(x, y, size, size);
      
      fill(0);
      textSize(30);
      text("Team", x, y);
      textSize(font);
    }
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
