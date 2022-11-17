String screen = "Intro";
boolean refresh = true;

PImage SoccerField;

void draw(){  

  if (refresh){ //for graphs
    background(255);
  }
  
  //sessionHandle.update();
  
  if (screen.equals("Session Selecting")){
    for (String i : sessions.keySet()){
      sessions.get(i).update(i);
    }
  }
  
  else if (screen.equals("Player Selecting")){
    //soccer field image
    image(SoccerField, 0, 0, width, height);
    for (String i : players.keySet()){
      players.get(i).update(i);
    }
    
    if (numOfStatOn() == 1){ //only display if one stat is on
      team.update("Average");
    }
  }
  
  else if (screen.equals("Stat Selecting")){
    for (String i : statCheckboxes.keySet()){
      statCheckboxes.get(i).update();
    }
  }
  
  if (screen.equals("Intro")){
    indiv.update();
    session.update();
    stat.update();
  } else{
    back.update();
  }
}

void mousePressed() {  
  //back button
  if (back.over){
    if (screen.equals("Session Selecting")){
      screen = "Intro";
    }
    else if (screen.equals("Session Display")){
      screen = "Session Selecting";
      refresh = true;
    }
    else if (screen.equals("Player Selecting")){
      screen = "Intro";
    }
    else if (screen.equals("Player Display")){
      screen = "Player Selecting";
      refresh = true;
    } else if (screen.equals("Stat Selecting")){
      screen = "Intro";
    }
    back.over = false;
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
  }
  else if (screen.equals("Session Selecting")){
    for (String i : sessions.keySet()){
      if (sessions.get(i).over){
        sessions.get(i).displayGraph("Session " + i);
        screen = "Session Display";
        refresh = false;
      }
    }
  }
  else if (screen.equals("Player Selecting")){
    for (String i : players.keySet()){
      if (players.get(i).over){
        players.get(i).displayGraph(i);
        screen = "Player Display";
        refresh = false;
      }
    }
    //team button
    if (team.over){
        team.displayGraph("Team");
        screen = "Player Display";
        refresh = false;
    }
  }
  else if (screen.equals("Stat Selecting")){
    for (String i : statCheckboxes.keySet()){
      if (statCheckboxes.get(i).over){
        statCheckboxes.get(i).checked = !statCheckboxes.get(i).checked;
      }
    }
  }
  
  //sessionHandle.pressEvent();
}

void mouseReleased() {
  //sessionHandle.releaseEvent();
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
