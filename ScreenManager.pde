String screen = "Intro";
boolean refresh = true;

String[] statsIncluded;

void draw(){
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
}

void mousePressed() {
  if (back.over){
    if (screen.equals("Session Selecting")){
      screen = "Intro";
    }
    else if (screen.equals("Team Display")){
      screen = "Session Selecting";
      refresh = true;
    }
    back.over = false;
  }
  
  else if (screen.equals("Intro")){
    if (indiv.over) {
      //println("pressed");
    }
    else if (team.over) {
      screen = "Session Selecting";
    }
  }
  else if (screen.equals("Session Selecting")){
    for (String i : sessions.keySet()){
      if (sessions.get(i).over){
        sessions.get(i).displayGraph();
        screen = "Team Display";
        refresh = false;
      }
    }
  }
}
