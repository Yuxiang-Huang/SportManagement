String[] allData;
int index = 0;

String[] names;
String[] stats;
//HashMap<Integer, SessionButton> sessions;

ArrayList<Float> data = new ArrayList<Float>();

IndivButton indiv;
TeamButton team;
BackButton back;
 
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
  String[] curr = allData[index].split(", ");
  names = new String[curr.length];
  for (int i = 0; i < names.length; i ++){
    names[i] = curr[i];
  }
  index++;
  
  curr = allData[index].split(", ");
  stats = new String[curr.length];
  for (int i = 0; i < stats.length; i ++){
    stats[i] = curr[i];
  }
  index++;
}

void draw(){
  indiv.update();
  team.update();
  back.update();
}

void mousePressed() {
  if (indiv.over) {
    println("pressed");
  }
}
