public class Button{
  float x; 
  float y;    
  float wid;
  float hei;
  color origColor;
  boolean over = false;
  String word;

  public Button(float x, float y, float wid, float hei, String word) {
    origColor = 255;
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.word = word;
  }
  
  void update() {
    //update over
    if (isOver()){
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

    rect(x, y, wid, hei);
    
    fill(0);
    text(word, x, y);
  }
    
  boolean isOver()  {
    if (mouseX >= x-wid/2 && mouseX <= x+wid/2 && 
        mouseY >= y-hei/2 && mouseY <= y+hei/2) {
      return true;
    } else {
      return false;
    }
  }
}
