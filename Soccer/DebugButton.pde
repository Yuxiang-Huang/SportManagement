public class DebugButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  public DebugButton(color c, int size) {
    origColor = c;
    //top right
    this.x = width - size/2 - 5;
    this.y = size/2 + 5;
    this.size = size;
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
    text("Debug", x, y);
  }
    
  boolean over()  {
    if (mouseX >= x-size/2 && mouseX <= x+size/2 && 
        mouseY >= y-size/2 && mouseY <= y+size/2) {
      return true;
    } else {
      return false;
    }
  }
  
  void dataPrint(){
    for (String str : players.keySet()){
      println(str);
      print("stats: ");
      println(players.get(str).stats);
      println();
    }
    for (String str : sessions.keySet()){
      println(str);
      print("stats: ");
      println(sessions.get(str).stats);
      print("teamGoals: ");
      println(sessions.get(str).teamGoals);
      print("indivGoals: ");
      println(sessions.get(str).indivGoals);
      println();
    }
  }
  
  void checkAllData(){
    background(255);
    int size = sessions.keySet().size();
    for (int i = 0; i < playerNames.size(); i ++){
      text(playerNames.get(i), width/(size+2), (i + 1) * height / (playerNames.size() + 1));
    }
    int i = 2;
    for (String str : sessions.keySet()){
      text(str, i * width/(size+2), 15);
      print("stats: ");
      println(sessions.get(str).stats);
      print("teamGoals: ");
      println(sessions.get(str).teamGoals);
      print("indivGoals: ");
      println(sessions.get(str).indivGoals);
      println();
      i ++;
    }
  }
}
