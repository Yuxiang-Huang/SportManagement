public class StatIndexChangeButton{    
  int x;
  int y;
  int wid;
  int hei;
  color origColor;
  boolean over = false;

  public StatIndexChangeButton(color c) {
    origColor = c;
  }
  
  void display(int x, int y, int wid, int hei){
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    
    fill(255);
    rect(x, y, wid, hei);
    
    fill(0);
    text(statNames[debug.statIndex], x, y);
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
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
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
