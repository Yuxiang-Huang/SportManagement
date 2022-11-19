//default
int fontSize = 12;

//button setting
int introButtonSize = 150;
int buttonSize = 100;
int buttonFontSize = 25;
int distBtwButton = 50; //take out later
color highlight  = color(200);

//special buttons
IntroButton indiv;
IntroButton session;
IntroButton stat;
BackButton back;
GraphButton graph;

PlayerButton team;
AllStatChangeButton ascb;
Handle sessionHandle;

//for reading data
String[] allData;
int index = 0;

ArrayList<String> playerNames = new ArrayList<String>();
HashMap<String, PlayerButton> players = new HashMap<String, PlayerButton>(); //key: playerNames

String[] statNames;
HashMap<String, StatCheckbox> statCheckboxes = new HashMap<String, StatCheckbox>(); //key: statNames

ArrayList<String> sessionDates = new ArrayList<String>(); //will take out later
HashMap<String, SessionData> sessions = new HashMap<String, SessionData>(); //key: sessionNum

HashMap<String, ArrayList<Float>> indivBest = new HashMap<String, ArrayList<Float>>(); //key: statName

void setup(){
  allData = loadStrings("Input.txt");
  
  //settings
  background(255);
  size(900, 500);
  fill(0);
  stroke(lineThickness);
  textSize(fontSize);
  textAlign(CENTER);
  rectMode(CENTER);
  
  //set for graph
  startX = 100;
  startY = height - 100;
  xlen = width - 200;
  ylen = height - 150;
  
  //set main buttons
  indiv = new IntroButton(255, 1, "Player");
  session = new IntroButton(255, 2, "Session");
  stat = new IntroButton(255, 3, "Stats");
  back = new BackButton(255, 30);
  ascb = new AllStatChangeButton(255, 50);
  
  //for session
  sessionHandle = new Handle(width/2, height/2, width/4, 50);
  
  //graph
  graph = new GraphButton(255, 50);
  
  //read data
  
  //stat names
  String[] curr = allData[index++].split(", ");
  statNames = new String[curr.length];
  for (int i = 0; i < statNames.length; i ++){
    statNames[i] = curr[i];
  }
  
  //stat check boxes
  for (int i = 0; i < statNames.length; i ++){
    statCheckboxes.put(statNames[i], new StatCheckbox(width/2, height/statNames.length * i + 100 / 2, 255, 50, i));
  }
  
  index ++;
  
  //names
  //hard number 3 for 4-3-3 position
  for (int times = 0; times < 3; times ++){
    String pos = allData[index++]; //position name
    curr = allData[index++].split(", ");
    for (int i = 0; i < curr.length; i ++){ 
      //create new player button
      String name = curr[i].split(" ")[0]; //take first name
      playerNames.add(name); 
      PlayerButton now = new PlayerButton(i, 255, buttonSize, pos);
      players.put(name, now);
      //set the keys for hashmap
      for (int j = 0; j < statNames.length; j ++){
        now.stats.put(statNames[j], new ArrayList<Float>());
        now.teamGoals.put(statNames[j], new ArrayList<Float>());
      }
    }
    index ++; //skip an empty line
  }
  
  //team player button
  team = new PlayerButton(-1, 255, buttonSize, "Average");
  //set the keys for hashmap
  for (int j = 0; j < statNames.length; j ++){
    team.stats.put(statNames[j], new ArrayList<Float>());
    team.teamGoals.put(statNames[j], new ArrayList<Float>());
  }
  
  //indiv best
  for (int i = 0; i < statNames.length; i ++){
    indivBest.put(statNames[i], new ArrayList<Float>());
  }
  index ++; //skip empty line
  //for each player line
  for (int p = 0; p < playerNames.size(); p ++){
    index ++; //skip name line
    curr = allData[index++].split(" ");
    //for each stat
    for (int i = 0; i < curr.length; i ++){
      indivBest.get(statNames[i]).add(Float.parseFloat(curr[i]));  
    }
  }
      
  //read each session
  while (index < allData.length){
    //find next session
    while (index < allData.length && ! allData[index].split(" ")[0].equals("Session:")){
      index++;
    }
    if (index < allData.length){
      readSession(index);
      index++;
    }
  }
  
  //checkAllData();
  
  //images
  SoccerField = loadImage("SoccerField.png");
}

void readSession(int index){
  //create new session button; will replace later
  String[] curr = allData[index++].split(" ");
  SessionData sb = new SessionData(curr[1]);
  sessionDates.add(curr[1]);
  sessions.put(curr[1], sb);
  for (int i = 0; i < statNames.length; i ++){
    sb.stats.put(statNames[i], new ArrayList<Float>());
  }
  
  //read stats for playerButton
  ArrayList<String> tempPlayerName = new ArrayList<String>(playerNames);
  while (!allData[index].equals("End")){
    //process the line with player name
    String name = allData[index++].split(" ")[0];
    tempPlayerName.remove(name);
    PlayerButton pb = players.get(name); 
    curr = allData[index++].split(" ");
    //process data
    for (int s = 0; s < statNames.length; s ++){
      pb.stats.get(statNames[s]).add(Float.parseFloat(curr[s]));
    }
  }
  
  //absent player 
  for (int i = 0; i < tempPlayerName.size(); i++){
    PlayerButton pb = players.get(tempPlayerName.get(i));
    for (int s = 0; s < statNames.length; s ++){
      Float now = Float.parseFloat(curr[s]);
      pb.stats.get(statNames[s]).add(-1f);
    }
  }
  
  //data for team
  for (int i = 0; i < playerNames.size(); i ++){
    PlayerButton pb = players.get(playerNames.get(i)); 
    for (int s = 0; s < statNames.length; s ++){
      ArrayList<Float> now = pb.stats.get(statNames[s]);
      sb.stats.get(statNames[s]).add(now.get(now.size()-1));
    }
  }
  
  //calculat team goals
  sb.teamGoals = new float[statNames.length];
  for (int i = 0; i < statNames.length; i++){ //for each stat
    ArrayList<Float> statNow = sb.stats.get(statNames[i]);
    
    //calculate average
    float sum = 0;
    int num = 0;
    for (int j = 0; j < statNow.size(); j ++){
      if (statNow.get(j) != -1){ //skip absent
        sum += statNow.get(j);
        num++;
      }
    }
    float teamGoal = sum / num;
    
    //for session
    sb.teamGoals[i] = teamGoal;
    //for indiv
    for (String now : players.keySet()){
      players.get(now).teamGoals.get(statNames[i]).add(teamGoal);
    }
    //for average
    team.stats.get(statNames[i]).add(teamGoal);
    team.teamGoals.get(statNames[i]).add(1f); //to not change
  }
  
  //set personal goal
  for (int i = 0; i < statNames.length; i ++){ //for each stat
    ArrayList<Float> stats = sb.stats.get(statNames[i]);
    sb.indivGoals.put(statNames[i], new ArrayList<Float>());
    for (int j = 0; j < stats.size(); j ++){ //for each session put the greater
      sb.indivGoals.get(statNames[i]).add(Math.max(stats.get(j), indivBest.get(statNames[i]).get(j)));
      indivBest.get(statNames[i]).set(j, Math.max(stats.get(j), indivBest.get(statNames[i]).get(j)));
    }
  }
}

void checkAllData(){
  for (String str : players.keySet()){
    println(str);
    print("stats: ");
    println(players.get(str).stats);
    println();
  }
  for (String str : sessions.keySet()){
    println(str);
    print("stats: ");
    println(sessions.get(str).stats);
    print("teamGoals: ");
    println(sessions.get(str).teamGoals);
    print("indivGoals: ");
    println(sessions.get(str).indivGoals);
    println();
  }
}
