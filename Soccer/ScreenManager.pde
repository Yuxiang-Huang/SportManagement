String screen = "Intro";

PImage SoccerField;

int benchLen = 150;

boolean handCursor;

void draw(){      
  handCursor = false;
  if (screen.equals("Display")){
    if (table.tableMode){
      table.word = "graph";
    } else{
      table.word = "Table";
    }
    table.update();
    if (table.tableMode && sessionIndexBegin != sessionIndexEnd){
      statIndexChange.update();
    }
    if (numOfStatOn() == 1){
      average.update();
      percentage.update();
    } else{
      takeAverage = true;
      singlePercent = false;
    }
  } else{ //refresh when not display
    background(255);
  }
  
  if (screen.equals("Session Selecting")){
    sessionHandleTop.update();
    sessionHandleBot.update();
  }
  
  else if (screen.equals("Player Selecting")){
    //soccer field image
    image(SoccerField, 0, 0, width, height - benchLen);
    for (String i : players.keySet()){
      players.get(i).update();
    } 
    //player change buttons
    for (AllPlayerChangeButton apcb : playerChange){
      apcb.update();
    }
  }
  
  else if (screen.equals("Stat Selecting")){
    for (String i : statCheckboxes.keySet()){
      statCheckboxes.get(i).update();
    }
    if (numOfStatOn() > 0){
      allStatChange.word = "All Off";
    } else{
      allStatChange.word = "All On";
    }
    allStatChange.update();
  }
  
  if (screen.equals("Intro")){
    indiv.update();
    session.update();
    stat.update();
    graph.update();
  } else{
    //don't display if all stats off    
    if (numOfStatOn() > 0){
      back.update();
    }
  }
  
  if (handCursor){
    cursor(HAND);
  } else{
    cursor(ARROW);
  }
}

void mousePressed() {  
  //back button
  if (back.over){
    screen = "Intro";
    back.over = false;
    table.tableMode = false;
  }
  
  //other buttons
  else if (screen.equals("Intro")){
    if (indiv.over) {
      screen = "Player Selecting";
    }
    else if (session.over) {
      screen = "Session Selecting";
    }
    else if (stat.over) {
      screen = "Stat Selecting";
    }
    else if (graph.over){
      graph.graph();
      screen = "Display";
    }
  }
  else if (screen.equals("Display")){
    if (table.over){
      //display table vs display graph
      table.tableMode = !table.tableMode;
      if (table.tableMode){
        table.displayTable();
      } else{
        graph.graph();
      }
    }
    else if (average.over){
      if (takeAverage){
        average.word = "Average: Off";
      } else{
        average.word = "Average: On";
      }
      takeAverage = !takeAverage;
      graph.graph();
    }
    else if (percentage.over){
      if (singlePercent){
        percentage.word = "Percent: Off";
      } else{
        percentage.word = "Percent: On";
      }
      singlePercent = !singlePercent;
      graph.graph();
    }
    else if (statIndexChange.over){
      table.statIndex = table.nextValidStatIndex(table.statIndex);
      background(255);
      table.displayTable();
    }
  }
  else if (screen.equals("Session Selecting")){
    sessionHandleTop.pressEvent();
    sessionHandleBot.pressEvent();
  }
  else if (screen.equals("Player Selecting")){
    for (String i : players.keySet()){
      if (players.get(i).over){
        players.get(i).checked = !players.get(i).checked;
      }
    }
    
    //player change buttons
    for (AllPlayerChangeButton apcb : playerChange){
      if (apcb.over){
        apcb.change();
      }
    }
  }
  else if (screen.equals("Stat Selecting")){
    for (String i : statCheckboxes.keySet()){
      if (statCheckboxes.get(i).over){
        statCheckboxes.get(i).checked = !statCheckboxes.get(i).checked;
      }
    }
    if (allStatChange.over){
      boolean status;
      if (numOfStatOn() > 0){
        status = false;
      } else{
        status = true;
      }
      for (String i : statCheckboxes.keySet()){
        statCheckboxes.get(i).checked = status;
      }
    }
  }
}

void mouseReleased() {
  if (screen.equals("Session Selecting")){
    sessionHandleTop.releaseEvent();
    sessionHandleBot.releaseEvent();
  }
}

int numOfStatOn(){
  int ans = 0;
  for (int i = 0; i < statNames.length; i++){
      if (statCheckboxes.get(statNames[i]).checked){
        ans ++;
      }
  }
  return ans;
}
