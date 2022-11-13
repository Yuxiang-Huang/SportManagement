public class PlayerButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  //each stat in order of session
  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>();
  //team goals in order of session
  HashMap<String, ArrayList<Float>> teamGoals = new HashMap<String, ArrayList<Float>>();

  public PlayerButton(float x, float y, color c, int size) {
    origColor = c;
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void update(String name) {
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
    text(name, x, y);
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
    //get data depending on selected stats
    ArrayList<Float> data = new ArrayList<Float>();
    ArrayList<Float> goalsInput = new ArrayList<Float>();
    ArrayList<String> legends = new ArrayList<String>();
    for (int i = 0; i < statNames.length; i++){
      if (statCheckboxes.get(statNames[i]).checked){
        //legend
        legends.add(statNames[i]);
        //data
        ArrayList<Float> curr = stats.get(statNames[i]);
        for (int j = 0; j < curr.size(); j ++){
          data.add(curr.get(j));
        }
        //goal
        curr = teamGoals.get(statNames[i]);
        for (int j = 0; j < curr.size(); j ++){
          goalsInput.add(curr.get(j));
        }
      }
    }
    
    //xlabel
    String[] xLabel = new String[stats.get(statNames[0]).size()];
    for (int i = 0; i < xLabel.length; i ++){
      xLabel[i] = (i + 1) + "";
    }
    
    //draw graph
    rectMode(CORNER);
    if (legends.size() == 1){
      drawGraph(title, "Scatter", legends.get(0), xLabel, data);
      drawScatterPlot(data);
    } else{
      drawGraph(title, "Scatter", "%", xLabel, data);
      drawMultiScatterPlot(data, goalsInput, legends);
    }  
    rectMode(CENTER);
  }
}
