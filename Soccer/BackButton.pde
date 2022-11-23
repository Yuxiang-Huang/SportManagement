public class BackButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  public BackButton(color c, int size) {
    origColor = c;
    //top right
    this.x = size/2 + 5;
    this.y = size/2 + 5;
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
    text("Back", x, y);
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
