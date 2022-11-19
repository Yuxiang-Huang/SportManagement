public class GraphButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  public GraphButton(color c, int size) {
    origColor = c;
    //button
    this.x = width/2;
    this.y = height - 50;
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
    text("Graph", x, y);
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
