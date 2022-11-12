String screen = "Intro";

void draw(){
  background(255);
  
  if (screen.equals("Intro")){
    indiv.update();
    team.update();
  } else{
    back.update();
  }
  
  if (screen.equals("Team")){
    for (String i : sessions.keySet()){
      sessions.get(i).update(i);
    }
  }
}

void mousePressed() {
  if (back.over){
    if (screen.equals("Team")){
      screen = "Intro";
    }
    back.over = false;
  }
  
  else if (screen.equals("Intro")){
    if (indiv.over) {
      //println("pressed");
    }
    else if (team.over) {
      screen = "Team";
    }
  }
  else if (screen.equals("Team")){
    for (String i : sessions.keySet()){
      if (sessions.get(i).over){
        
      }
    }
  }
}
