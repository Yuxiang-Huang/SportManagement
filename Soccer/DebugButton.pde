public class DebugButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  
  int statIndex = 0;

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
    int xSize = width / (sessions.keySet().size() + 2);
    int ySize = height / (playerNames.size() + 3);
    //first col
    line(xSize - xSize/2, (0.5) * ySize, width - xSize/2, (0.5) * ySize);
    line(xSize - xSize/2, (1.5) * ySize, width - xSize/2, (1.5) * ySize);
    for (int i = 0; i < playerNames.size(); i ++){
      text(playerNames.get(i), xSize, (i + 2) * ySize);
      line(xSize - xSize/2, (i + 2.5) * ySize, width - xSize/2, (i + 2.5) * ySize);
    }
    text("Team Goals", xSize, (playerNames.size() + 2) * ySize);
    line(xSize - xSize/2, (playerNames.size() + 2.5) * ySize, width - xSize/2, (playerNames.size() + 2.5) * ySize);
    
    int i = 2;
    for (String str : sessions.keySet()){
      //first row
      text(str, i * xSize, ySize);
      
      //each player
      ArrayList<Float> curr = sessions.get(str).stats.get(statNames[statIndex]);
      for (int j = 0; j < curr.size(); j ++){
        text(curr.get(j), i * xSize,  (j + 2) * ySize);
      }
      
      //last row - team goals
      text(sessions.get(str).teamGoals[statIndex], i * xSize, (playerNames.size() + 2) * ySize);
      
      //println(sessions.get(str).indivGoals);
      i ++;
    }
  }
}
