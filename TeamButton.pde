public class TeamButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  public TeamButton(color c, int size) {
    origColor = c;
    x = width * 3 / 4;
    y = height / 2;
    this.size = size;
  }
  
  void update() {
    
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
    
  boolean over()  {
    if (mouseX >= x-size/2 && mouseX <= x+size/2 && 
        mouseY >= y-size/2 && mouseY <= y+size/2) {
      return true;
    } else {
      return false;
    }
  }
}
