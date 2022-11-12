String screen = "Intro";

void draw(){
  if (screen.equals("Intro")){
    indiv.update();
    team.update();
  } else{
    back.update();
  }
}

void mousePressed() {
  if (indiv.over) {
    println("pressed");
  }
}
