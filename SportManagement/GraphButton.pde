public class GraphButton{
  float x; 
  float y;    
  int size;
  color origColor;
  boolean over = false;

  public GraphButton(color c, int size) {
    origColor = c;
    //button
    this.x = width/2;
    this.y = height - 50;
    this.size = size;
  }
  
  void update() {
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
    text("Graph", x, y);
  }
    
  boolean over()  {
    if (mouseX >= x-size/2 && mouseX <= x+size/2 && 
        mouseY >= y-size/2 && mouseY <= y+size/2) {
      return true;
    } else {
      return false;
    }
  }
  
  void graph(){
    if (sessionIndexBegin == sessionIndexEnd){
      sessions.get(sessionDates.get(sessionIndexBegin)).displayGraph();
    } else{
      //get data depending on selected stats
      ArrayList<Float> data = new ArrayList<Float>();
      ArrayList<Float> goalsInput = new ArrayList<Float>();
      ArrayList<String> legends = new ArrayList<String>();
      //for (int i = 0; i < statNames.length; i++){
      //  if (statCheckboxes.get(statNames[i]).checked){
      //    //setup
      //    data.add(0f);
      //    legends.add(statNames[i]);
          
      //    //data
      //    ArrayList<Float> curr = stats.get(statNames[i]);
      //    for (int j = 0; j < curr.size(); j ++){
      //      data.add(curr.get(j));
      //    }
      //    //goal
      //    curr = teamGoals.get(statNames[i]);
      //    for (int j = 0; j < curr.size(); j ++){
      //      goalsInput.add(curr.get(j));
      //    }
      //  }
      //}
      
      //xlabel
      ArrayList<String> xLabel = new ArrayList<String>();
      for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
        xLabel.add(sessionDates.get(i));
      }
      
      //draw graph
      String title = "From " + sessionDates.get(sessionIndexBegin) + " to " + sessionDates.get(sessionIndexEnd);
      rectMode(CORNER);
      if (legends.size() == 1){
        drawGraph(title, "Scatter", xLabel, legends.get(0), data);
        drawScatterPlot(data);
      } else{
        drawGraph(title, "Scatter", xLabel, "%", data);
        //drawMultiScatterPlot(data, teamGoalsInput, legends);
      }  
      rectMode(CENTER);
    }
  }
}
