//default
int fontSize = 12;

//button setting
int introButtonSize = 150;
int buttonSize = 100;
int buttonFontSize = 26;
int distBtwButton = 50;
color highlight  = color(200);

//main buttons
IntroButton indiv;
IntroButton session;
IntroButton stat;
BackButton back;

//for reading data
String[] allData;
int index = 0;
String[] names;
String[] statNames;
HashMap<String, StatCheckbox> statCheckboxes = new HashMap<String, StatCheckbox>(); //key: statNames
HashMap<String, PlayerButton> players = new HashMap<String, PlayerButton>(); //key: playerNames
int numOfPlayer = 0;
HashMap<String, SessionButton> sessions = new HashMap<String, SessionButton>(); //key: sessionNum
int numOfSession = 0;
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
  xlen = width - 100;
  ylen = height - 100;
  
  //set main buttons
  indiv = new IntroButton(255, 1, "Player");
  session = new IntroButton(255, 2, "Session");
  stat = new IntroButton(255, 3, "Stats");
  back = new BackButton(255, 30);
  
  //read data
  
  //names
  String[] curr = allData[index++].split(", ");
  names = new String[curr.length];
  for (int i = 0; i < names.length; i ++){
    names[i] = curr[i];
  }
  
  //stat names
  curr = allData[index++].split(", ");
  statNames = new String[curr.length];
  for (int i = 0; i < statNames.length; i ++){
    statNames[i] = curr[i];
  }
  
  //stat check boxes
  for (int i = 0; i < statNames.length; i ++){
    statCheckboxes.put(statNames[i], new StatCheckbox(width/2, height/statNames.length * i + 100 / 2, 255, 50, i));
  }
  
  //indiv best
  for (int i = 0; i < statNames.length; i ++){
    indivBest.put(statNames[i], new ArrayList<Float>());
  }
  index += 2;
  //for each player line
  for (int p = 0; p < names.length; p ++){
    curr = allData[index++].split(" ");
    //for each stat
    for (int i = 1; i < curr.length; i ++){
      indivBest.get(statNames[i-1]).add(Float.parseFloat(curr[i]));  
    }
  }
  
  createAllPlayerButtons();
      
  //for each session
  while (index < allData.length){
    //find next session
    while (index < allData.length && ! allData[index].split(" ")[0].equals("Session")){
      index++;
    }
    if (index < allData.length){
      //read session
      int save = index;
      readSession(save);
      //read indiv
      readIndiv(index);
      index ++;
    }
  }
}

void readSession(int index){
  String[] curr = allData[index++].split(" ");
  
  //create new session number
  float xVal = distBtwButton * numOfSession + buttonSize * (numOfSession + 1);
  SessionButton now = new SessionButton(xVal, height/2, 255, buttonSize);
  sessions.put(curr[1], now);
  numOfSession++;
  
  //read team goals
  curr = allData[index++].split(" ");
  now.teamGoals = new float[curr.length];
  //skip words "Team Goals:"
  for (int i = 2; i < curr.length; i ++){
    now.teamGoals[i-2] = Float.parseFloat(curr[i]);  
  }
  
  //read stats
  float[][] holder = new float[statNames.length][names.length];
  for (int p = 0; p < names.length; p ++){
    curr = allData[index++].split(" ");
    //skip name
    for (int s = 1; s < curr.length; s ++){
      holder[s-1][p] = Float.parseFloat(curr[s]);  
    }
  }
  
  for (int i = 0; i < statNames.length; i ++){
    now.stats.put(statNames[i], holder[i]);
  }
  
  //set personal goal
  for (int i = 0; i < statNames.length; i ++){
    float[] stats = now.stats.get(statNames[i]);
    now.indivGoals.put(statNames[i], new ArrayList<Float>());
    for (int j = 0; j < stats.length; j ++){
      now.indivGoals.get(statNames[i]).add(Math.max(stats[j], indivBest.get(statNames[i]).get(j)));
      indivBest.get(statNames[i]).set(j, Math.max(stats[j], indivBest.get(statNames[i]).get(j)));
    }
  }
}

void createAllPlayerButtons(){
  for (int i = 0; i < names.length; i ++){
    //create new player button
    float xVal = distBtwButton * numOfPlayer + buttonSize * (numOfPlayer + 1);
    PlayerButton now = new PlayerButton(xVal, height/2, 255, buttonSize);
    players.put(names[i], now);
    //set the keys for hashmap
    for (int j = 0; j < statNames.length; j ++){
      now.stats.put(statNames[j], new ArrayList<Float>());
      now.teamGoals.put(statNames[j], new ArrayList<Float>());
    }
    numOfPlayer ++;
  }
}

void readIndiv(int index){
  //read team goals
  index ++;
  String[] curr = allData[index++].split(" ");
  //skip words "Team Goals:"
  for (int i = 2; i < curr.length; i ++){
    for (String now : players.keySet()){
      players.get(now).teamGoals.get(statNames[i-2]).add(Float.parseFloat(curr[i]));
    }
  }
  
  //read stats
  //for each player
  for (int p = 0; p < names.length; p ++){
    curr = allData[index++].split(" ");
    PlayerButton now = players.get(curr[0].substring(0, curr[0].length() - 1));
    //for each stat
    for (int i = 1; i < curr.length; i ++){
      now.stats.get(statNames[i-1]).add(Float.parseFloat(curr[i]));  
    }
  }
}
