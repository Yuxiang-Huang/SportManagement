String[] allData;
int index = 0;

String[] names;
String[] statNames;
HashMap<String, SessionButton> sessions = new HashMap<String, SessionButton>();
int numOfSession = 0;
int sessionButtonSize = 100;
int distBtwSession = 50;

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
  
  //stats
  curr = allData[index++].split(", ");
  statNames = new String[curr.length];
  for (int i = 0; i < statNames.length; i ++){
    statNames[i] = curr[i];
  }
  
  //for now include all
  statsIncluded = statNames;
  
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
}

void readSession(int index){
  String[] curr = allData[index++].split(" ");
  
  //create new session number
  float xVal = distBtwSession * numOfSession + sessionButtonSize * (numOfSession + 1);
  SessionButton now = new SessionButton(xVal, height/2, 255, sessionButtonSize);
  sessions.put(curr[1], now);
  numOfSession++;
  
  //read team goals
  curr = allData[index++].split(" ");
  now.teamGoals = new float[curr.length];
  for (int i = 0; i < curr.length; i ++){
    now.teamGoals[i] = Float.parseFloat(curr[i]);  
  }
  
  //read stats
  float[][] holder = new float[statNames.length][names.length];
  for (int p = 0; p < holder[0].length; p ++){
    index ++;
    for (int s = 0; s < holder.length; s++){
      curr = allData[index++].split(" ");
      holder[s][p] = Float.parseFloat(curr[0]);  
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
