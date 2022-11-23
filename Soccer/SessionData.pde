public class SessionData{
  String date;
  
  //stat for all players in order of names for each stat in this session
  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>(); 
  //team goals in this session
  float[] teamGoals;
  //indiv goal in order of player names for each stat in this session
  HashMap<String, ArrayList<Float>> indivGoals = new HashMap<String, ArrayList<Float>>(); 

  public SessionData(String str) {
    date = str;
  }
  
  void displayGraph(){    
    //get data
    ArrayList<Float> data = new ArrayList<Float>();
    ArrayList<Float> indivGoalsInput = new ArrayList<Float>();
    for (int i = 0; i < playerNames.size(); i ++){ //for every player IN ORDER
      if (players.get(playerNames.get(i)).checked){ //check if player is selected
        for (int j = 0; j < statNames.length; j++){ //for every stat
          if (statCheckboxes.get(statNames[j]).checked){ //check if stat is selected
            data.add(stats.get(statNames[j]).get(i));
            indivGoalsInput.add(indivGoals.get(statNames[j]).get(i));
          }
        }
      }
    }
    
    int statIndex = -1;
    //loop over stats
    ArrayList<Float> teamGoalsInput = new ArrayList<Float>();
    ArrayList<String> legends = new ArrayList<String>();
    for (int i = 0; i < statNames.length; i ++){
      if (statCheckboxes.get(statNames[i]).checked){
        legends.add(statNames[i]);
        teamGoalsInput.add(teamGoals[i]);
        statIndex = i;
      }
    }
    
    ArrayList<String> xLabel = new ArrayList<String>();
    //loop over players
    for (int i = 0; i < playerNames.size(); i ++){ 
      if (players.get(playerNames.get(i)).checked){
        xLabel.add(playerNames.get(i));
      }
    }
    
    int barNum = legends.size();
        
    //draw graph
    rectMode(CORNER);
    if (barNum > 1){      
      drawGraph(date, "Bar", xLabel, "%", data);
      drawMultiBarGraph(data, indivGoalsInput, legends, barNum, teamGoalsInput);
    } 
    else{
      drawGraph(date, "Bar", xLabel, statNames[statIndex], data);
      drawBarGraph(data, indivGoalsInput, teamGoals[statIndex]);
    }
    rectMode(CENTER);
  }
}
