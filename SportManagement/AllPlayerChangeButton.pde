public class AllPlayerChangeButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  
  boolean allOff = true;
  
  String position;

  public AllPlayerChangeButton(color c, int size, String pos, int i) {
    origColor = c;
    this.size = size;
    position = pos;
    x = width - size;
    y = height/5*i;
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
    if (position.equals("All")){
      if (allOff){
        text("All Off", x, y);
      } else{
        text("All On", x, y);
      }
    } else{
      if (allOff){
        text("All " + position + " Off", x, y);
      } else{
        text("All " + position + " On", x, y);
      }
    }
  }
  
  void change(){
  
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
