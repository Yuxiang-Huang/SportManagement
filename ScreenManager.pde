String screen = "Intro";
boolean refresh = true;

void draw(){  
  //for graphs
  if (refresh){
    background(255);
  }
  
  if (screen.equals("Intro")){
    indiv.update();
    team.update();
  } else{
    back.update();
  }
  
  if (screen.equals("Session Selecting")){
    for (String i : sessions.keySet()){
      sessions.get(i).update(i);
    }
  }
  
  else if (screen.equals("Player Selecting")){
    for (String i : players.keySet()){
      players.get(i).update(i);
    }
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
    }
    back.over = false;
  }
  
  //other buttons
  else if (screen.equals("Intro")){
    if (indiv.over) {
      screen = "Player Selecting";
    }
    else if (team.over) {
      screen = "Session Selecting";
    }
  }
  else if (screen.equals("Session Selecting")){
    for (String i : sessions.keySet()){
      if (sessions.get(i).over){
        sessions.get(i).displayGraph("Session" + i);
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
  }
}
