public class TableButton extends Button{  
  int statIndex = 0;
  boolean tableMode = false;

  public TableButton(float x, float y, float wid, float hei) {
    super(x, y, wid, hei, defaultFontSize, "");
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
      mutliSessionTable();
    }
  }
  
  void mutliSessionTable(){
    //edge case of figuring out which stat
    if (! statCheckboxes.get(statNames[statIndex]).checked){
      statIndex = nextValidStatIndex(statIndex);
    }
    
    //find all included players
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        playerIncluded.add(playerNames.get(i));
      }
    }
    
    //set unit
    int tableBot = height - 10; //leave space for buttons 
    int xTotal = sessionIndexEnd - sessionIndexBegin + 3;
    int yTotal = playerIncluded.size() + 3;
    int xSize = width/ xTotal;
    int ySize = tableBot / yTotal;
    
    //display stat change button
    statIndexChange.x = xSize;
    statIndexChange.y = ySize;
    statIndexChange.wid = xSize - 10;
    statIndexChange.hei = ySize - 10;
    statIndexChange.word = "Stat "+ (table.statIndex + 1);
    
    //grid lines
    for (int i = 0; i < yTotal; i ++){ //horizontal
      line(xSize/2, (i + 0.5) * ySize, (xTotal - 0.5)*xSize, (i + 0.5) * ySize);
    }
    for (int i = 0; i < xTotal; i ++){ //vertical
      line((i + 0.5) * xSize, ySize/2, (i + 0.5)*xSize, (yTotal - 0.5) * ySize);
    }
    
    //first col
    for (int i = 0; i < playerIncluded.size(); i ++){
      text(playerIncluded.get(i), xSize, (i + 2) * ySize);
    }
    text("Team", xSize, (yTotal - 1) * ySize);
    
    //for every session
    for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
      int xCount = i - sessionIndexBegin + 2;
      //first row
      text(sessionDates.get(i), xCount * xSize, ySize);

      //each player
      int yCount = 2;
      SessionData sd = sessions.get(sessionDates.get(i));
      ArrayList<Float> curr = sd.stats.get(statNames[statIndex]); //for this stat
      for (int j = 0; j < curr.size(); j ++){ //for each player
        if (players.get(playerNames.get(j)).checked){ //if included
          text(curr.get(j), xCount * xSize, yCount * ySize);
          yCount ++;
        }
      }
      
      //team goal
      text(sd.teamGoals[statIndex], xCount * xSize, (yTotal - 1) * ySize);
    }
  }
  
  void oneSessionTable(){
    //prepare
    SessionData sd = sessions.get(sessionDates.get(sessionIndexBegin));
    
    //find all player included
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        playerIncluded.add(playerNames.get(i));
      }
    }
    //find all stat included
    ArrayList<String> statIncluded = new ArrayList<String>();
    for (int i = 0; i < statNames.length; i ++){
      if (statCheckboxes.get(statNames[i]).checked){
        statIncluded.add(statNames[i]);
      }
    }
    
    //set unit
    int tableBot = height - 10; //leave space for buttons 
    int xTotal = statIncluded.size() + 2;
    int yTotal = playerIncluded.size() + 3;
    int xSize = width / xTotal;
    int ySize = tableBot / yTotal;
    
    //grid lines
    for (int i = 0; i < yTotal; i ++){ //horizontal
      line(xSize/2, (i + 0.5) * ySize, (xTotal - 0.5) * xSize, (i + 0.5) * ySize);
    }
    for (int i = 0; i < xTotal; i ++){ //vertical
      line((i + 0.5) * xSize, ySize/2, (i + 0.5) * xSize, (yTotal - 0.5) * ySize);
    }
    
    //first col
    for (int i = 0; i < playerIncluded.size(); i ++){
      text(playerIncluded.get(i), xSize, (i + 2) * ySize);
    }
    text("Team Goals", xSize, (yTotal - 1) * ySize);
    
    //other part
    int xCount = 2;
    //for each stat
    for (int i = 0; i < statNames.length; i ++){ //for each stat
      if (statCheckboxes.get(statNames[i]).checked){ //if included
        //first row
        text(statNames[i], xCount * xSize, ySize);

        //for this stat
        ArrayList<Float> curr = sd.stats.get(statNames[i]);
        int yCount = 2;
        for (int j = 0; j < curr.size(); j ++){//for each player
          if (players.get(playerNames.get(j)).checked){ //if included
            text(curr.get(j), xCount * xSize,  yCount * ySize);
            yCount ++;
          }
        }

        //team goals
        text(sd.teamGoals[i], xCount * xSize, (yTotal - 1) * ySize);
        
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
      curIndex ++;
    }
    
    curIndex = 0;
    
    while (curIndex < statNames.length){
      if (statCheckboxes.get(statNames[curIndex]).checked){
        return curIndex;
      }
      curIndex ++;
    }
    
    return -1;
  }
}
