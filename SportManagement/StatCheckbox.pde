public class StatCheckbox{
  int index; //index in the statNames
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  boolean checked = true;

  public StatCheckbox(float x, float y, color c, int size, int i) {
    origColor = c;
    this.x = x;
    this.y = y;
    this.size = size;
    index = i;
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
    
    //display
    rect(x, y, size, size);
    
    //check mark
    if (checked){
      line(x-20, y-15, x, y+10);
      line(x+30, y-40, x, y+10);
    }
    
    fill(0);
    
    //text
    textAlign(LEFT);
    textSize(buttonFontSize);
    text(statNames[index], x + size/2+5, y+5);
    textSize(fontSize);
    textAlign(CENTER);
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
