public class IntroButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  String text;

  public IntroButton(color c, int num, String text) {
    origColor = c;
    x = num * width / 4;
    y = height / 2;
    size = introButtonSize;
    this.text = text;
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
    textSize(buttonFontSize);
    text(text, x, y);
    textSize(fontSize);
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
