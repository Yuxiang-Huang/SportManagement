public class PlayerButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;
  
  String position; //not used yet

  //each stat in order of session
  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>();
  //team goals in order of session
  HashMap<String, ArrayList<Float>> teamGoals = new HashMap<String, ArrayList<Float>>();

  public PlayerButton(float yIndex, color c, int size, String pos) {
    //team button
    if (pos.equals("Average")){
      this.y = height/2;
      this.size = size;
      x = size/2;
      origColor = c;
    }
    
    //player button
    else{
      int num;
      //find number of button in a column
      if (pos.equals("Defense")){
        num = 4;
      } else{
        num = 3;
      }
      
      //set x value base on pos
      if (pos.equals("Defense")){
        num = 4;
        x = width / 4;
      } else{
        num = 3;
        if (pos.equals("Center")){ 
          x = width / 2;
        }
        else if (pos.equals("Offense")){ 
          x = width * 3 / 4;
        }
      }
      
      this.y = yIndex * height / num + height / num / 2;
      this.size = size;
      this.position = pos;
      origColor = c;
    }
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
    text(name.split(" ")[0], x, y);
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
    ArrayList<String> xLabel = new ArrayList<String>();
    for (int i = 0; i < stats.get(statNames[0]).size(); i ++){
      xLabel.add((i + 1) + "");
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
