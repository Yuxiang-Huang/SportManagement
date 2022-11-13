public class SessionButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  //stat to length name
  HashMap<String, float[]> stats = new HashMap<String, float[]>();
  float[] teamGoals;
  //stat to goals for each player
  HashMap<String, ArrayList<Float>> goals = new HashMap<String, ArrayList<Float>>();

  public SessionButton(float x, float y, color c, int size) {
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
    //get data depending on selected stats
    ArrayList<Float> data = new ArrayList<Float>();
    ArrayList<Float> indivGoals = new ArrayList<Float>();
    int barNum = 0;
    String stat = "";
    for (int i = 0; i < names.length; i ++){  
      for (int j = 0; j < statNames.length; j++){
        if (statCheckboxes.get(statNames[j]).checked){
          data.add(stats.get(statNames[j])[i]);
          indivGoals.add(goals.get(statNames[j]).get(i));
          barNum ++;
          stat = statNames[j];
        }
      }
    }
    barNum /= names.length;
    rectMode(CORNER);
    if (barNum > 1){
      drawGraph(title, "Bar", "%", names, data);
      drawMultiBarGraph(barNum, teamGoals, statNames, data);
    } 
    else{
      drawGraph(title, "Bar", stat, names, data);
      drawBarGraph(indivGoals, teamGoals[(statCheckboxes.get(stat).index)], data);
    }
    rectMode(CENTER);
  }
}
