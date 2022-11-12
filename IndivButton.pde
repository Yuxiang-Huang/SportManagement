public class IndivButton{
  float x; 
  float y;    
  int size;
  color origColor;
  color highlight;
  boolean over = false;
  boolean active = true;

  public IndivButton(float x, float y, color c, int size) {
    origColor = c;
    highlight = color(51);
    this.x = x;
    this.y = y;
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
