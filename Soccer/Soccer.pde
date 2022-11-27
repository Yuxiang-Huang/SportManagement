import java.util.*;

//default
int fontSize = 12;

//button setting
int introButtonSize = 150;
int buttonSize = 100;
int buttonFontSize = 25;
int distBtwButton = 50; //take out later
color highlight = color(200);

//special buttons
IntroButton indiv;
IntroButton session;
IntroButton stat;
BackButton back;
GraphButton graph;
SwitchButton debug;
StatIndexChangeButton statIndexChange;

Handle sessionHandleTop;
Handle sessionHandleBot;

AllStatChangeButton statChange;
ArrayList<AllPlayerChangeButton> playerChange = new ArrayList<AllPlayerChangeButton>();

//for reading data
String[] allData;
int index = 0;

ArrayList<String> playerNames = new ArrayList<String>(); //all player names
ArrayList<String> backups = new ArrayList<String>(); //backup player names
HashMap<String, PlayerButton> players = new HashMap<String, PlayerButton>(); //key: playerNames

String[] statNames;
HashMap<String, StatCheckbox> statCheckboxes = new HashMap<String, StatCheckbox>(); //key: statNames

ArrayList<String> sessionDates = new ArrayList<String>(); //all session dates
HashMap<String, SessionData> sessions = new HashMap<String, SessionData>(); //key: sessionNum

HashMap<String, ArrayList<Float>> indivBest = new HashMap<String, ArrayList<Float>>(); //key: statName

HashMap<String, ArrayList<Float>> teamGoals = new HashMap<String, ArrayList<Float>>(); //team goals in order of session

void setup(){
  allData = loadStrings("Input.txt");
  
  //settings
  background(255);
  size(900, 650);
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
  debug = new SwitchButton(255, 50);
  statIndexChange = new StatIndexChangeButton(255);
  
  //set all change button
  statChange = new AllStatChangeButton(255, 50);
  playerChange.add(new AllPlayerChangeButton(255, 125, 75, "Offense", 1));
  playerChange.add(new AllPlayerChangeButton(255, 125, 75, "Center", 2));
  playerChange.add(new AllPlayerChangeButton(255, 125, 75, "Defense", 3));
  playerChange.add(new AllPlayerChangeButton(255, 125, 75, "All", 4));
  playerChange.add(new AllPlayerChangeButton(255, 125, 50, "Backups"));
  
  //for session
  sessionHandleTop = new Handle(true, height/2, width/4, 50);
  sessionHandleBot = new Handle(false, height*3/4, width/4, 50);
  
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
  
  //team goals
  for (int i = 0; i < statNames.length; i ++){
    teamGoals.put(statNames[i], new ArrayList<Float>());
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
      PlayerButton now = new PlayerButton(i, 255, buttonSize, name, pos);
      players.put(name, now);
      //set the keys for hashmap
      for (int j = 0; j < statNames.length; j ++){
        now.stats.put(statNames[j], new ArrayList<Float>());
      }
    }
    index ++; //skip an empty line
  }
  
  index++;
  
  //back ups
  int xIndex = 0;
  for (int times = 0; times < 3; times ++){
    String pos = allData[index++]; //position name
    curr = allData[index++].split(", ");
    for (int i = 0; i < curr.length; i ++){ 
      //create new player button
      String name = curr[i].split(" ")[0]; //take first name
      playerNames.add(name); 
      backups.add(name);
      PlayerButton now = new PlayerButton(xIndex, 255, buttonSize, buttonSize/2, name, pos, 11); //12 hard number
      players.put(name, now);
      now.checked = false;
      //set the keys for hashmap
      for (int j = 0; j < statNames.length; j ++){
        now.stats.put(statNames[j], new ArrayList<Float>());
      }
      xIndex ++;
    }
    index ++; //skip an empty line
  }
  
  //indiv best
  for (int i = 0; i < statNames.length; i ++){
    ArrayList<Float> best = new ArrayList<Float>();
    for (int j = 0; j < playerNames.size(); j ++){
      best.add(0f);
    }  
    indivBest.put(statNames[i], best);
  }
  
  //index ++; //skip empty line
  ////for each player line
  //for (int p = 0; p < playerNames.size(); p ++){
  //  index ++; //skip name line
  //  curr = allData[index++].split(" ");
  //  //for each stat
  //  for (int i = 0; i < curr.length; i ++){
  //    indivBest.get(statNames[i]).add(Float.parseFloat(curr[i]));  
  //  }
  //}
      
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
  
  sessionIndexEnd = sessionDates.size() - 1;
  
  //images
  SoccerField = loadImage("SoccerField.png");
}

void readSession(int index){
  //create new session button; will replace later
  String[] curr;
  String date = allData[index].substring(9, allData[index++].length() - 5); //Session:
  SessionData sd = new SessionData(date);
  sessionDates.add(date);
  sessions.put(date, sd);
  for (int i = 0; i < statNames.length; i ++){
    sd.stats.put(statNames[i], new ArrayList<Float>());
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
      pb.stats.get(statNames[s]).add(-1f);
    }
  }
  
  //data for team
  for (int i = 0; i < playerNames.size(); i ++){
    PlayerButton pb = players.get(playerNames.get(i)); 
    for (int s = 0; s < statNames.length; s ++){
      ArrayList<Float> now = pb.stats.get(statNames[s]);
      sd.stats.get(statNames[s]).add(now.get(now.size()-1));
    }
  }
  
  //calculat team goals
  sd.teamGoals = new float[statNames.length];
  for (int i = 0; i < statNames.length; i++){ //for each stat
    ArrayList<Float> statNow = sd.stats.get(statNames[i]);
    
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
    sd.teamGoals[i] = teamGoal;
    //for indiv
    teamGoals.get(statNames[i]).add(teamGoal);
  }
  
  //set personal goal
  for (int i = 0; i < statNames.length; i ++){ //for each stat
    ArrayList<Float> stats = sd.stats.get(statNames[i]);
    sd.indivGoals.put(statNames[i], new ArrayList<Float>());
    for (int j = 0; j < stats.size(); j ++){ //for each session put the greater
      sd.indivGoals.get(statNames[i]).add(Math.max(stats.get(j), indivBest.get(statNames[i]).get(j)));
      indivBest.get(statNames[i]).set(j, Math.max(stats.get(j), indivBest.get(statNames[i]).get(j)));
    }
  }
}
