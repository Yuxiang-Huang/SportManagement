public class Handle {
  int x, y;
  int boxx, boxy;
  int stretch;
  int size;
  boolean over;
  boolean press;
  boolean locked = false;

  Handle(int x, int y, int l, int s) {
    this.x = x;
    this.y = y;
    this.stretch = l;
    this.size = s;
    boxx = x+stretch;
    boxy = y;
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
      stretch = lock(mouseX-width/2, 0, width/2-size);
    }
    
    //display
    boxx = x+stretch;
    boxy = y;
    
    overEvent();
    display();
  }

  void overEvent() {
    if (overRect(boxx, boxy, size, size)) {
      over = true;
    } else {
      over = false;
    }
  }

  void display() {
    line(x, y, x+stretch, y);
    fill(255);
    stroke(0);
    rect(boxx, boxy, size, size);
    if (over || press) {
      line(boxx-size/2, boxy-size/2, boxx+size/2, boxy+size/2);
      line(boxx+size/2, boxy-size/2, boxx-size/2, boxy+size/2);
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

  int lock(int val, int minv, int maxv) {
    return  min(max(val, minv), maxv);
  }
}
