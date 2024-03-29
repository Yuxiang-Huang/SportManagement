import java.util.*;

//default
int defaultFontSize = 12;

//button setting
int distBtwButton = 50; //take out later
color highlight = color(200);

//special buttons
Button indiv;
Button session;
Button stat;

Button back;
Button statIndexChange;
Button average;
Button percentage;
Button allStatChange;

GraphButton graph;
TableButton table;

Handle sessionHandleTop;
Handle sessionHandleBot;

ArrayList<AllPlayerChangeButton> playerChange = new ArrayList<AllPlayerChangeButton>();

//for reading data
String[] allData;
int index = 0;

ArrayList<String> playerNames = new ArrayList<String>(); //all player names
ArrayList<String> backups = new ArrayList<String>(); //backup player names


HashMap<String, PlayerButton> players = new HashMap<String, PlayerButton>(); //key: playerNames
HashMap<String, String> playerNumbers = new HashMap<String, String>();


String[] statNames;
HashMap<String, StatCheckbox> statCheckboxes = new HashMap<String, StatCheckbox>(); //key: statNames

ArrayList<String> sessionDates = new ArrayList<String>(); //all session dates
HashMap<String, SessionData> sessions = new HashMap<String, SessionData>(); //key: sessionNum

HashMap<String, ArrayList<Float>> indivBest = new HashMap<String, ArrayList<Float>>(); //key: statName

HashMap<String, ArrayList<Float>> teamGoals = new HashMap<String, ArrayList<Float>>(); //team goals in order of session

void setup(){
  
  playerNumbers.put("Benjamin", "#00");
  playerNumbers.put("Siddhartha", "#1");
  playerNumbers.put("Ethan", "#3");
  playerNumbers.put("Kaeden", "#4");
  playerNumbers.put("Mitchell", "#5");
  playerNumbers.put("Ryan", "#6");
  playerNumbers.put("MartinI", "#8");
  playerNumbers.put("Farzad", "#9");
  playerNumbers.put("Romain", "#10");
  playerNumbers.put("Aden", "#11");
  playerNumbers.put("Noah", "#12");
  playerNumbers.put("Giles", "#15");
  playerNumbers.put("Nicholas", "#16");
  playerNumbers.put("Michael", "#18");
  playerNumbers.put("Soham", "#19");
  playerNumbers.put("Anselm", "#20");
  playerNumbers.put("MartinW", "#22");
  playerNumbers.put("Frederik", "#23");
  playerNumbers.put("Duncan", "#25");
  playerNumbers.put("Rafael", "#27");
  playerNumbers.put("Jack", "#30");
  playerNumbers.put("Gabriel", "#33");
  playerNumbers.put("Eben", "#34");
  playerNumbers.put("John", "#35");
  playerNumbers.put("Stefan", "#36");
  playerNumbers.put("Patrick", "#47");
  playerNumbers.put("Sayeb", "#99");

  allData = loadStrings("Input.txt");

  //settings
  background(255);
  size(900, 650);
  fill(0);
  stroke(lineThickness);
  textSize(defaultFontSize);
  textAlign(CENTER);
  rectMode(CENTER);

  //set for graph
  startX = 100;
  startY = height - 100;
  xlen = width - 200;
  ylen = height - 150;

  //set main buttons
  indiv = new Button(width/4, height/2, 150, 150, 25, "Player");
  session = new Button(width/2, height/2, 150, 150, 25, "Session");
  stat = new Button(width*3/4, height/2, 150, 150, 25, "Stats");

  graph = new GraphButton(width/2, height - 50, 50, 50);
  table = new TableButton(width - 30, height - 20, 50, 30);
  back = new Button(40/2 + 5, 30/2 + 5, 40, 30, defaultFontSize, "Back");
  average = new Button(50, height - 20, 75, 30, defaultFontSize, "Average: On");
  percentage = new Button(150, height - 20, 100, 30, defaultFontSize, "Percentage: Off");
  statIndexChange = new Button(0, 0, 0, 0, defaultFontSize, ""); //set later

  //set all change button
  allStatChange = new Button(width - 30, 50/2 + 5, 50, 50, defaultFontSize, "");
  playerChange.add(new AllPlayerChangeButton(125, 75, "Offense", 1));
  playerChange.add(new AllPlayerChangeButton(125, 75, "Center", 2));
  playerChange.add(new AllPlayerChangeButton(125, 75, "Defense", 3));
  playerChange.add(new AllPlayerChangeButton(125, 75, "All", 4));
  playerChange.add(new AllPlayerChangeButton(110, 50, "Backups"));

  //for session
  sessionHandleTop = new Handle(true, height/2, width/4, 50);
  sessionHandleBot = new Handle(false, height*3/4, width/4, 50);

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
      PlayerButton now = new PlayerButton(i, 100, 100, name, pos);
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
      PlayerButton now = new PlayerButton(xIndex, 55, 50, name, pos, 17); //11 hard number
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
  String date = allData[index++].split(" ")[1]; //session date
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
      if (statNow.get(j) > -1){ //skip absent
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
