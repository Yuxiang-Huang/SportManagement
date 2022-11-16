public class Handle {
  int x, y;
  int boxx, boxy;
  int stretch;
  int size;
  boolean over;
  boolean press;
  boolean locked = false;
  boolean mousePress;

  Handle(int x, int y, int l, int s) {
    this.x = x;
    this.y = y;
    this.stretch = l;
    this.size = s;
    boxx = x+stretch - size/2;
    boxy = y - size/2;
  }

  void update() {
    boxx = x+stretch;
    boxy = y - size/2;

    if (press) {
      stretch = lock(mouseX-width/2-size/2, 0, width/2-size-1);
    }
    
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

  void pressEvent() {
    if (over && mousePress || locked) {
      press = true;
      locked = true;
    } else {
      press = false;
    }
  }

  void releaseEvent() {
    locked = false;
  }

  void display() {
    line(x, y, x+stretch, y);
    fill(255);
    stroke(0);
    rect(boxx, boxy, size, size);
    if (over || press) {
      line(boxx, boxy, boxx+size, boxy+size);
      line(boxx, boxy+size, boxx+size, boxy);
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
