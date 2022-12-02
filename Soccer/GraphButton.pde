boolean takeAverage = true;

public class GraphButton extends Button{
  public GraphButton(float x, float y, float wid, float hei) {
    super(x, y, wid, hei, defaultFontSize, "Graph");
  }
  
  void graph(){
    if (sessionIndexBegin == sessionIndexEnd){
      sessions.get(sessionDates.get(sessionIndexBegin)).displayGraph();
    } else{
      if (takeAverage){
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
                  if (pb.stats.get(statNames[i]).get(sessionIndexBegin + k) > -1){ //check absent
                    totalPlayer[k]++; //for taking average
                    int index = k + statNum * (sessionIndexEnd - sessionIndexBegin + 1); //find index
                    data.set(index, data.get(index) + pb.stats.get(statNames[i]).get(sessionIndexBegin + k)); //update
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
              int index = k + statNum * (sessionIndexEnd - sessionIndexBegin + 1); //det index
              if (totalPlayer[k] > -1){ //take average or set as -1 if absent
                data.set(index, data.get(index)/totalPlayer[k]);
              } else{
                data.set(index, -1f);
              }
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
      } else{
        notAverageGraph();
      }
    }
  }
  
  void notAverageGraph(){
    //set up
    ArrayList<Float> data = new ArrayList<Float>();
    ArrayList<Float> teamGoalsInput = new ArrayList<Float>();
    ArrayList<String> legends = new ArrayList<String>();
    String title = "";
    
    //get data
    for (int i = 0; i < statNames.length; i++){ //for each stat
      if (statCheckboxes.get(statNames[i]).checked){ //check if stat if selected
        title = statNames[i];
        for (int j = 0; j < playerNames.size(); j ++){ //for every player IN ORDER
          PlayerButton pb = players.get(playerNames.get(j));
          if (pb.checked){ //check if player is selected
            //data
            legends.add(playerNames.get(j));
            for (int k = 0; k <= sessionIndexEnd - sessionIndexBegin; k ++){
              data.add(pb.stats.get(statNames[i]).get(sessionIndexBegin + k));
            }
            //goals
            for (int k = sessionIndexBegin; k <= sessionIndexEnd; k ++){
              teamGoalsInput.add(teamGoals.get(statNames[i]).get(k));
            }
          }
        }
      }
    }
    
    //xlabel
    ArrayList<String> xLabel = new ArrayList<String>();
    for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
      xLabel.add(sessionDates.get(i));
    }
    
    rectMode(CORNER);
    drawGraph(title, "Scatter", xLabel, title, data);
    drawMultiScatterPlot(data, teamGoalsInput, legends);
    rectMode(CENTER);
  }
}
