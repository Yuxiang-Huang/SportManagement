public class PlayerButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>();
  HashMap<String, ArrayList<Float>> goals = new HashMap<String, ArrayList<Float>>();

  public PlayerButton(float x, float y, color c, int size) {
    origColor = c;
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void update(String sessionNum) {
    //update over
    if (over()){
      over = true;
    } 
    else {
      over = false;
    }
    
    if (over) {
      fill(highlight);
    } else {
      fill(origColor);
    }

    rect(x, y, size, size);
    
    fill(0);
    textSize(30);
    text(sessionNum, x, y);
    textSize(font);
  }
    
  boolean over()  {
    if (mouseX >= x-size/2 && mouseX <= x+size/2 && 
        mouseY >= y-size/2 && mouseY <= y+size/2) {
      return true;
    } else {
      return false;
    }
  }
  
  void displayGraph(String title){
    //rectMode(CORNER);
    //ArrayList<Float> data = new ArrayList<Float>();
    //for (int i = 0; i < names.length; i ++){  
    //  for (int j = 0; j < statsIncluded.length; j++){
    //    data.add(stats.get(statsIncluded[j])[i]);
    //  }
    //}
    //drawGraph(title, "Team Bar", "%", names, data);
    //drawTeamBarGraph(statNames.length, teamGoals, statNames, data);
    //rectMode(CENTER);
  }
}
