public class Button{
  float x; 
  float y;    
  float wid;
  float hei;
  int fontSize;
  String word;
  boolean over = false;

  public Button(float x, float y, float wid, float hei, int fontSize, String word) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.word = word;
    this.fontSize = fontSize;
  }
  
  void update() {
    //update over
    if (isOver()){
      over = true;
    } 
    else {
      over = false;
    }
    
    if (over){
      fill(highlight);
      handCursor = true;
    } else{
      fill(255);
    }

    rect(x, y, wid, hei);
    
    fill(0);
    textSize(fontSize);
    text(word, x, y);
    textSize(defaultFontSize);
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
