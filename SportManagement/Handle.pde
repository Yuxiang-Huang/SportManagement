int sessionIndex;

public class Handle {
  int x;
  int y;
  
  int size;
  boolean over;
  boolean hold = false;
  
  int minX;
  int maxX;

  Handle(boolean first, int y, int minX, int s) {
    this.y = y;
    this.minX = minX;
    this.maxX = width - minX;
    this.size = s;
    
    if (first){
      x = minX;
    }else{
      x = maxX;
    }
  }

  void update() {    
    if (hold) {
      x = lock(mouseX);
    }
    
    //display
    overEvent();
    display();
  }

  void overEvent() {
    if (overRect(x, y, size, size)) {
      over = true;
    } else {
      over = false;
    }
  }

  void display() {
    //handle display
    line(minX, y, maxX, y);
    fill(255);
    stroke(0);
    rect(x, y, size, size);
    if (over || hold) {
      line(x-size/2, y-size/2, x+size/2, y+size/2);
      line(x+size/2, y-size/2, x-size/2, y+size/2);
    }
    
    //date display
    fill(0);
    textSize(buttonFontSize);
    int output = sessionDates.size() * (x - minX) / (maxX - minX);
    sessionIndex = output;
    text(sessionDates.get(output), width/2, height/4);
    textSize(fontSize);
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x - width/2 && mouseX <= x+width/2 &&
      mouseY >= y - height/2 && mouseY <= y+height/2) {
      return true;
    } else {
      return false;
    }
  }

  int lock(int val) {
    return min(max(val, minX), maxX-1);
  }
  
  void pressEvent(){
    if (over){
      hold = true;
    }
  }
  
  void releaseEvent(){
    hold = false;
  }
}
