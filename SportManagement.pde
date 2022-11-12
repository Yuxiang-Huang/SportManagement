String[] allData;
int index = 0;

String[] names;
String[] statNames;
HashMap<String, PlayerButton> players = new HashMap<String, PlayerButton>();
int numOfPlayer = 0;
HashMap<String, SessionButton> sessions = new HashMap<String, SessionButton>();
int numOfSession = 0;
int buttonSize = 100;
int distBtwButton = 50;

IndivButton indiv;
TeamButton team;
BackButton back;

color highlight  = color(200);
 
void setup(){
  allData = loadStrings("Input.txt");
  
  //settings
  background(255);
  size(900, 500);
  fill(0);
  stroke(lineThickness);
  textSize(font);
  textAlign(CENTER);
  rectMode(CENTER);
  
  //set buttons
  indiv = new IndivButton(255, 100);
  team = new TeamButton(255, 100);
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
  
  //for now include all
  statsIncluded = statNames;
  
  int save = index;
  
  //for sessions
  while (index < allData.length){
    while (index < allData.length && ! curr[0].equals("Session")){
      curr = allData[index++].split(" ");
    }
    if (index < allData.length){
      readSession(index-1);
      curr = allData[index++].split(" ");
    }
  }
  
  //for indiv
  createAllPlayerButtons();
  index = save;
  while (index < allData.length){
    while (index < allData.length && ! curr[0].equals("Session")){
      curr = allData[index++].split(" ");
    }
    if (index < allData.length){
      readIndiv(index-1);
      curr = allData[index++].split(" ");
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
  
  //for (String str : now.stats.keySet()){
  //  println(str);
  //  println(now.stats.get(str));
  //}
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
      now.goals.put(statNames[j], new ArrayList<Float>());
    }
    numOfPlayer ++;
  }
}

void readIndiv(int index){
  index+=2;
  
  //read stats
  for (int p = 0; p < statNames.length; p ++){
    String[] curr = allData[index++].split(" ");
    println(curr[0].substring(0, curr[0].length() - 1));
    PlayerButton now = players.get(curr[0].substring(0, curr[0].length() - 1));
    for (int i = 1; i < curr.length; i ++){
      now.stats.get(statNames[i-1]).add(Float.parseFloat(curr[i]));  
    }
    println(now.stats);
    println(now.goals);
  }
}
