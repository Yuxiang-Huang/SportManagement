public class Handle {
  int x;
  int y;
  
  int size;
  boolean over;
  boolean hold = false;
  
  int minX;
  int maxX;

  Handle(int x, int y, int minX, int s) {
    this.x = x;
    this.y = y;
    this.minX = minX;
    this.maxX = width - minX;
    this.size = s;
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
    line(minX, y, maxX, y);
    fill(255);
    stroke(0);
    rect(x, y, size, size);
    if (over || hold) {
      line(x-size/2, y-size/2, x+size/2, y+size/2);
      line(x+size/2, y-size/2, x-size/2, y+size/2);
    }
    
    fill(0);
    int output = 5 * (x - minX) / (maxX - minX) + 1;
    text(x, width/2, height/3);
    text(output, width/2, height/4);
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
