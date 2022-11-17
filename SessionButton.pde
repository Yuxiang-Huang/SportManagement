public class SessionButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  //stat for all players in order of names for each stat
  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>(); 
  //team goals for this session
  float[] teamGoals;
  //indiv goal for all players in order of session for each stat
  HashMap<String, ArrayList<Float>> indivGoals = new HashMap<String, ArrayList<Float>>(); 

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
    textSize(buttonFontSize);
    text(sessionNum, x, y);
    textSize(fontSize);
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
    int barNum = 0;
    String stat = "";
    
    //get data depending on selected stats
    ArrayList<Float> data = new ArrayList<Float>();
    ArrayList<Float> indivGoalsInput = new ArrayList<Float>();
    for (int i = 0; i < playerNames.size(); i ++){  
      for (int j = 0; j < statNames.length; j++){
        if (statCheckboxes.get(statNames[j]).checked){
          data.add(stats.get(statNames[j]).get(i));
          indivGoalsInput.add(indivGoals.get(statNames[j]).get(i));
          barNum ++;
        }
      }
    }
    
    ArrayList<Float> teamGoalsInput = new ArrayList<Float>();
    ArrayList<String> legends = new ArrayList<String>();
    for (int i = 0; i < statNames.length; i ++){
      if (statCheckboxes.get(statNames[i]).checked){
        legends.add(statNames[i]);
        teamGoalsInput.add(teamGoals[i]);
        stat = statNames[i];
      }
    }
    
    barNum /= playerNames.size();
        
    //draw graph
    rectMode(CORNER);
    if (barNum > 1){      
      drawGraph(title, "Bar", "%", playerNames, data);
      drawMultiBarGraph(barNum, teamGoalsInput, legends, data, indivGoalsInput);
    } 
    else{
      drawGraph(title, "Bar", stat, playerNames, data);
      drawBarGraph(data, indivGoalsInput, teamGoals[(statCheckboxes.get(stat).index)]);
    }
    rectMode(CENTER);
  }
}
