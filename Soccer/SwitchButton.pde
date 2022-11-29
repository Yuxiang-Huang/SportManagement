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
    if (isOver()){
      over = true;
    } 
    else {
      over = false;
    }
  }
    
  boolean isOver()  {
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
      mutliSessionTable(statIndex);
    }
  }
  
  void mutliSessionTable(int statIndex){
    //for edge case
    if (! statCheckboxes.get(statNames[statIndex]).checked){
      statIndex = nextValidStatIndex(statIndex);
    }
    
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        playerIncluded.add(playerNames.get(i));
      }
    }
    
    //set unit
    int xTotal = sessionIndexEnd - sessionIndexBegin + 3;
    int xSize = width/ xTotal;
    int ySize = height / (playerIncluded.size() + 3);
    
    //display stat change button
    statIndexChange.display(xSize, ySize, xSize - 10, ySize - 10);
    
    //grid lines
    for (int i = 0; i < playerIncluded.size() + 3; i ++){ //horizontal
      line(xSize - xSize/2, (i + 0.5) * ySize, width - xSize/2, (i + 0.5) * ySize);
    }
    for (int i = 0; i < xTotal; i ++){ //vertical
      line((i + 0.5)*xSize, height - ySize/2, (i + 0.5)*xSize, ySize/2);
    }
    
    //first col
    for (int i = 0; i < playerIncluded.size(); i ++){
      text(playerIncluded.get(i), xSize, (i + 2) * ySize);
    }
    text("Team Goals", xSize, (playerIncluded.size() + 2) * ySize);
    
    for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
      int xCount = i - sessionIndexBegin + 2;
      //first row
      text(sessionDates.get(i), xCount * xSize, ySize);

      //each player
      int yCount = 2;
      SessionData sd = sessions.get(sessionDates.get(i));
      ArrayList<Float> curr = sd.stats.get(statNames[statIndex]);
      for (int j = 0; j < curr.size(); j ++){
        if (players.get(playerNames.get(j)).checked){ //if included
          text(curr.get(j), xCount * xSize, yCount * ySize);
          yCount ++;
        }
      }
      
      //team goal
      text(sd.teamGoals[statIndex], xCount * xSize, height - ySize);
    }
  }
  
  void oneSessionTable(){
    //prepare
    SessionData sd = sessions.get(sessionDates.get(sessionIndexBegin));
    
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        playerIncluded.add(playerNames.get(i));
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
    for (int i = 0; i < playerIncluded.size() + 3; i ++){ //horizontal
      line(xSize - xSize/2, (i + 0.5) * ySize, width - xSize/2, (i + 0.5) * ySize);
    }
    for (int i = 0; i < statIncluded.size() + 2; i ++){ //vertical
      line((i + 0.5)*xSize, height - ySize/2, (i + 0.5)*xSize, ySize/2);
    }
    
    //first col
    for (int i = 0; i < playerIncluded.size(); i ++){
      text(playerIncluded.get(i), xSize, (i + 2) * ySize);
    }
    text("Team Goals", xSize, height - ySize);
    
    //other part
    int xCount = 2;
    for (int i = 0; i < statNames.length; i ++){
      if (statCheckboxes.get(statNames[i]).checked){
        //first row
        text(statNames[i], xCount * xSize, ySize);

        //each player
        ArrayList<Float> curr = sd.stats.get(statNames[i]);
        int yCount = 2;
        for (int j = 0; j < curr.size(); j ++){
          if (players.get(playerNames.get(j)).checked){
            text(curr.get(j), xCount * xSize,  yCount * ySize);
            yCount ++;
          }
        }

        //team goals
        text(sd.teamGoals[i], xCount * xSize, height - ySize);

        //println(sessions.get(str).indivGoals);

        xCount ++;
      }
    }
  }
  
  int nextValidStatIndex(int curIndex){
    curIndex ++;
    while (curIndex < statNames.length){
      if (statCheckboxes.get(statNames[curIndex]).checked){
        return curIndex;
      }
    }
    
    curIndex = 0;
    
    while (curIndex < statNames.length){
      if (statCheckboxes.get(statNames[curIndex]).checked){
        return curIndex;
      }
    }
    
    return -1;
  }
}
