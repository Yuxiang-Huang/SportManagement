public class Handle {
  int x, y;
  int stretch;
  int size;
  boolean over;
  boolean press;
  boolean locked = false;
  
  int minX;
  int maxX;

  Handle(int x, int y, int minX, int l, int s) {
    this.x = x;
    this.y = y;
    this.minX = minX;
    this.maxX = width - minX;
    this.stretch = l;
    this.size = s;
  }

  void update() {    
    if (! press){
      locked = false;
    }
    
    if (over && press || locked) {
      press = true;
      locked = true;
    } else {
      press = false;
    }
    
    if (press) {
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
    if (over || press) {
      line(x-size/2, y-size/2, x+size/2, y+size/2);
      line(x+size/2, y-size/2, x-size/2, y+size/2);
    }
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
    return min(max(val, minX), maxX);
  }
}
