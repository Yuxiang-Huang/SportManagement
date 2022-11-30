int sessionIndexBegin;
int sessionIndexEnd;
int outputTop;
int outputBot;

public class Handle {
  int x;
  int y;
  
  int size;
  boolean over;
  boolean hold = false;
  
  int minX;
  int maxX;
  
  boolean top;

  Handle(boolean top, int y, int minX, int s) {
    this.y = y;
    this.minX = minX;
    this.maxX = width - minX;
    this.size = s;
    this.top = top;
    if (top){
      x = minX;
    }else{
      x = maxX-1;
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
    //set session num
    int output = (int) (sessionDates.size() * (x - minX) / (maxX - minX));
    if (top){
      outputTop = output;
    } else{
      outputBot = output;
    }
    sessionIndexBegin = min(outputTop, outputBot);
    sessionIndexEnd = max(outputTop, outputBot);
    
    //date display
    fill(0);
    textSize(buttonFontSize);   
    if (sessionIndexBegin == sessionIndexEnd){
      text(sessionDates.get(sessionIndexBegin), width/2, height/4);
    } else{
      text("From " + sessionDates.get(sessionIndexBegin) + " to " + sessionDates.get(sessionIndexEnd), width/2, height/4);
    }
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
