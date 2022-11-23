String screen = "Intro";

PImage SoccerField;

void draw(){  
  if (screen.equals("Display")){
    debug.update();
  } else{ //refresh when not display
    background(255);
  }
  
  if (screen.equals("Session Selecting")){
    sessionHandleTop.update();
    sessionHandleBot.update();
  }
  
  else if (screen.equals("Player Selecting")){
    //soccer field image
    image(SoccerField, 0, 0, width, height);
    
    boolean over = false;
    for (String i : players.keySet()){
      players.get(i).update(i);
      over = over || players.get(i).over;
    } 
    //cursor
    if (over) {
      cursor(HAND);
    } else {
      cursor(ARROW);
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
    statChange.update();
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
}

void mousePressed() {  
  //back button
  if (back.over){
    screen = "Intro";
    back.over = false;
    debug.tableMode = false;
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
      debug.display();
      screen = "Display";
    }
  }
  else if (screen.equals("Display")){
    if (debug.over){
      //display table vs display graph
      debug.tableMode = !debug.tableMode;
      if (debug.tableMode){
        debug.displayTable();
        debug.display();
      } else{
        graph.graph();
        debug.display();
      }
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
    if (statChange.over){
      statChange.allOff = ! statChange.allOff;
      for (String i : statCheckboxes.keySet()){
        statCheckboxes.get(i).checked = statChange.allOff;
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
