public class SwitchButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  
  int statIndex = 0;
  
  boolean tableMode = false;

  public SwitchButton(color c, int size) {
    origColor = c;
    //bot right
    this.x = width - size/2 - 5;
    this.y = height - size/2 - 5;
    this.size = size;
  }
  
  void display(){
    fill(255);
    rect(x, y, size, size);
    fill(0);
    if (tableMode){
      text("Graph", x, y);
    } else{
      text("Table", x, y);
    }
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
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
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
  
  void displayTable(){
    background(255);
    if (sessionIndexBegin == sessionIndexEnd){
      oneSessionTable();
    } else{
    
    }
  }
  
  void oneSessionTable(){
    //prepare
    SessionData sd = sessions.get(sessionDates.get(sessionIndexBegin));
    
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (String name : players.keySet()){
      if (players.get(name).checked){
        playerIncluded.add(name);
      }
    }
    ArrayList<String> statIncluded = new ArrayList<String>();
    for (int i = 0; i < statNames.length; i ++){
      if (statCheckboxes.get(statNames[i]).checked){
        statIncluded.add(statNames[i]);
      }
    }
    
    //set unit
    int xSize = width / (statIncluded.size() + 2);
    int ySize = height / (playerIncluded.size() + 3);
    
    //grid lines
    for (int i = 0; i < playerNames.size() + 3; i ++){
      line(xSize - xSize/2, (i + 0.5) * ySize, width - xSize/2, (i + 0.5) * ySize);
    }
    for (int i = 0; i < sessions.keySet().size() + 2; i ++){
      line((i + 0.5)*xSize, height - ySize/2 - 5, (i + 0.5)*xSize, ySize/2);
    }
    
    //first col
    //for (int i = 0; i < playerIncluded.size(); i ++){
    //  text(playerIncluded.get(i), xSize, (i + 2) * ySize);
    //}
    text("Team Goals", xSize, (playerIncluded.size() + 2) * ySize);
    
    //other part
    int xCount = 0;
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        //first row
        text(playerIncluded.get(i), xSize, (i + 2) * ySize);
        
        //each player
        ArrayList<Float> curr = sd.stats.get(playerNames.get(i));
        int yCount = 0;
        for (int j = 0; j < statNames.length; j ++){
          if (statCheckboxes.get(statNames[j]).checked){
            text(curr.get(j), xCount * xSize,  (yCount + 2) * ySize);
            yCount ++;
          }
        }
        
        //last row - team goals
        text(sd.teamGoals[i], xCount * xSize, (playerNames.size() + 2) * ySize);
        
        //println(sessions.get(str).indivGoals);
        
        xCount ++;
      }
    }
  }
}
