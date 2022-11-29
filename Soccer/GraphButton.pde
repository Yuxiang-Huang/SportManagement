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
      //set up
      ArrayList<Float> data = new ArrayList<Float>();
      for (int i = 0; i < statNames.length; i++){ //for each stat
        if (statCheckboxes.get(statNames[i]).checked){ //check if stat is selected
          for (int j = sessionIndexBegin; j <= sessionIndexEnd; j ++){ //add session dif number of 0s
            data.add(0f);
          }
        }
      }
      ArrayList<Float> teamGoalsInput = new ArrayList<Float>();
      ArrayList<String> legends = new ArrayList<String>();
      
      //get data
      int statNum = 0;
      for (int i = 0; i < statNames.length; i++){ //for each stat
        if (statCheckboxes.get(statNames[i]).checked){ //check if stat if selected
          legends.add(statNames[i]);
          int[] totalPlayer = new int[sessionIndexEnd - sessionIndexBegin + 1];
          for (int j = 0; j < playerNames.size(); j ++){ //for every player IN ORDER
            PlayerButton pb = players.get(playerNames.get(j));
            if (pb.checked){ //check if player is selected
              //data
              for (int k = 0; k <= sessionIndexEnd - sessionIndexBegin; k ++){
                if (pb.stats.get(statNames[i]).get(sessionIndexBegin + k) > 0){ //check absent
                  totalPlayer[k]++;
                  int index = k + statNum * (sessionIndexEnd - sessionIndexBegin + 1);
                  data.set(index, data.get(index) + pb.stats.get(statNames[i]).get(sessionIndexBegin + k));
                }
              }
            }
          }
          //goals
          for (int k = sessionIndexBegin; k <= sessionIndexEnd; k ++){
            teamGoalsInput.add(teamGoals.get(statNames[i]).get(k));
          }
          //take average
          for (int k = 0; k <= sessionIndexEnd - sessionIndexBegin; k ++){
            int index = k + statNum * (sessionIndexEnd - sessionIndexBegin + 1);
            data.set(index, data.get(index)/totalPlayer[k]);
          }
          statNum ++;
        }
      }
      
      //xlabel
      ArrayList<String> xLabel = new ArrayList<String>();
      for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
        xLabel.add(sessionDates.get(i));
      }
      
      //figure out title
      String player = "";
      int numOfPlayer = 0;
      for (int j = 0; j < playerNames.size(); j ++){ //for every player IN ORDER
        if (players.get(playerNames.get(j)).checked){
          numOfPlayer ++;
          player = playerNames.get(j);
        }
      }
      String title;
      if (numOfPlayer > 1){
        title = "Team Average";
      } else{
        title = player;
      }
      
      rectMode(CORNER);
      if (legends.size() == 1){
        drawGraph(title, "Scatter", xLabel, legends.get(0), data);
        drawScatterPlot(data);
      } else{
        drawGraph(title, "Scatter", xLabel, "%", data);
        drawMultiScatterPlot(data, teamGoalsInput, legends);
      }  
      rectMode(CENTER);
    }
  }
}
