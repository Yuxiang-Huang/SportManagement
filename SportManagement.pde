String[] allData;
int index = 0;

String[] names;
String[] stats;
HashMap<Integer, SessionButton> sessions = new HashMap<Integer, SessionButton>();
int numOfSession = 0;
int sessionButtonSize = 100;
int distBtwSession = 50;

ArrayList<Float> data = new ArrayList<Float>();

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
  back.active = false;
  
  //read data
  
  //names
  String[] curr = allData[index++].split(", ");
  names = new String[curr.length];
  for (int i = 0; i < names.length; i ++){
    names[i] = curr[i];
  }
  
  //stats
  curr = allData[index++].split(", ");
  stats = new String[curr.length];
  for (int i = 0; i < stats.length; i ++){
    stats[i] = curr[i];
  }
  
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
  
  float xVal = distBtwSession * (numOfSession + 1) + sessionButtonSize * numOfSession;
  sessions.put(Integer.parseInt(curr[1]), 
  new SessionButton(xVal, height/2, 255, sessionButtonSize));
  
  numOfSession++;
  
  curr = allData[index++].split(" ");
}
