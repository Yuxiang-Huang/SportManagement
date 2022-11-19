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
      drawGraph(date, "Bar", "%", playerNames, data);
      drawMultiBarGraph(barNum, teamGoalsInput, legends, data, indivGoalsInput);
    } 
    else{
      drawGraph(date, "Bar", stat, playerNames, data);
      drawBarGraph(data, indivGoalsInput, teamGoals[(statCheckboxes.get(stat).index)]);
    }
    rectMode(CENTER);
  }
}
