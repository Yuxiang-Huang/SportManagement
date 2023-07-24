//default
int defaultFontSize = 12;

//button setting
int distBtwButton = 50; //take out later
int highlight = color(200);

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

public void setup(){

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
  size(900, 650)
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
  playerChange.add(new AllPlayerChangeButton(120, 50, "Backups"));

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
      PlayerButton now = new PlayerButton(xIndex, 70, 55, name, pos, 17); //17 hard number
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

public void readSession(int index){
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
      pb.stats.get(statNames[s]).add(parseFloat(curr[s]));
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
public class AllPlayerChangeButton extends Button{
  boolean allOff = true;
  String position;
  boolean backup;

  public AllPlayerChangeButton(int xSize, int ySize, String pos, int i) {
    super(width - xSize/2-10, (height - benchLen)/5*i, xSize, ySize, 16, "");
    position = pos;
  }

  public AllPlayerChangeButton(int xSize, int ySize, String pos) { //back up button
    super(width - xSize/2-10, height - benchLen/4, xSize, ySize, 16, "");
    position = pos;
    position = pos;
    backup = true;
    allOff = false;
  }

  public void update() {
    //update word
    if (position.equals("All")){
      if (allOff){
        word = "All Off";
      } else{
        word = "All On";
      }
    } else{
      if (allOff){
        word = "All " + position + " Off";
      } else{
        word = "All " + position + " On";
      }
    }
    super.update();
  }

  public void change(){
    allOff = !allOff;
    for (PlayerButton pb : players.values()){
      if (position.equals("All") || pb.position.equals(position)){
        pb.checked = allOff;
      }
    }

    if (backup){
      for (String name : backups){
        players.get(name).checked = allOff;
      }
    }
  }
}
public class Button{
  float x;
  float y;
  float wid;
  float hei;
  int fontSize;
  String word;
  boolean over = false;

  public Button(float x, float y, float wid, float hei, int fontSize, String word) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.word = word;
    this.fontSize = fontSize;
  }

  public void update() {
    //update over
    if (isOver()){
      over = true;
    }
    else {
      over = false;
    }

    //display depend on over
    if (over){
      fill(highlight);
      handCursor = true;
    } else{
      fill(255);
    }
    rect(x, y, wid, hei);
    fill(0);

    //text
    textSize(fontSize);
    text(word, x, y);
    textSize(defaultFontSize);
  }

  public boolean isOver()  {
    if (mouseX >= x-wid/2 && mouseX <= x+wid/2 &&
        mouseY >= y-hei/2 && mouseY <= y+hei/2) {
      return true;
    } else {
      return false;
    }
  }
}
boolean takeAverage = true;
boolean singlePercent = false;

public class GraphButton extends Button{
  public GraphButton(float x, float y, float wid, float hei) {
    super(x, y, wid, hei, defaultFontSize, "Graph");
  }

  public void graph(){
    if (sessionIndexBegin == sessionIndexEnd){
      sessions.get(sessionDates.get(sessionIndexBegin)).displayGraph();
    } else{
      if (takeAverage){
        //set up
        ArrayList<Float> data = new ArrayList<Float>();
        for (int i = 0; i < statNames.length; i++){ //for each stat
          if (statCheckboxes.get(statNames[i]).checked){ //check if stat is selected
            for (int j = sessionIndexBegin; j <= sessionIndexEnd; j ++){ //add session dif number of 0s
              data.add(0f);
            }
          }
        }
        ArrayList<Float> teamGoalsInput = new ArrayList<Float>();
        ArrayList<String> legends = new ArrayList<String>();

        //get data
        int statNum = 0;
        for (int i = 0; i < statNames.length; i++){ //for each stat
          if (statCheckboxes.get(statNames[i]).checked){ //check if stat if selected
            legends.add(statNames[i]);
            int[] totalPlayer = new int[sessionIndexEnd - sessionIndexBegin + 1];
            for (int j = 0; j < playerNames.size(); j ++){ //for every player IN ORDER
              PlayerButton pb = players.get(playerNames.get(j));
              if (pb.checked){ //check if player is selected
                //data
                for (int k = 0; k <= sessionIndexEnd - sessionIndexBegin; k ++){
                  if (pb.stats.get(statNames[i]).get(sessionIndexBegin + k) > -1){ //check absent
                    totalPlayer[k]++; //for taking average
                    int index = k + statNum * (sessionIndexEnd - sessionIndexBegin + 1); //find index
                    data.set(index, data.get(index) + pb.stats.get(statNames[i]).get(sessionIndexBegin + k)); //update
                  }
                }
              }
            }
            //goals
            for (int k = sessionIndexBegin; k <= sessionIndexEnd; k ++){
              teamGoalsInput.add(teamGoals.get(statNames[i]).get(k));
            }
            //take average
            for (int k = 0; k <= sessionIndexEnd - sessionIndexBegin; k ++){
              int index = k + statNum * (sessionIndexEnd - sessionIndexBegin + 1); //det index
              if (totalPlayer[k] != 0){ //take average or set as -1 if absent
                data.set(index, data.get(index)/totalPlayer[k]);
              } else{
                data.set(index, -1f);
              }
            }
            statNum ++;
          }
        }

        //xlabel
        ArrayList<String> xLabel = new ArrayList<String>();
        for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
          xLabel.add(sessionDates.get(i));
        }

        //figure out title
        String player = "";
        int numOfPlayer = 0;
        for (int j = 0; j < playerNames.size(); j ++){ //for every player IN ORDER
          if (players.get(playerNames.get(j)).checked){
            numOfPlayer ++;
            player = playerNumbers.get(playerNames.get(j));

          }
        }
        String title;
        if (numOfPlayer > 1){
          title = "Team Average";
        } else{
          title = player;
        }

        rectMode(CORNER);
        if (legends.size() == 1){
          if (singlePercent){
            drawGraph(title, "Scatter", xLabel, "%", data);
            drawScatterPlotPercent(data, teamGoalsInput);
          }else{
            drawGraph(title, "Scatter", xLabel, legends.get(0), data);
            drawScatterPlot(data);
          }
        } else{
          drawGraph(title, "Scatter", xLabel, "%", data);
          drawMultiScatterPlotPercent(data, teamGoalsInput, legends);
        }
        rectMode(CENTER);
      } else{
        notAverageGraph();
      }
    }
  }

  public void notAverageGraph(){
    //set up
    ArrayList<Float> data = new ArrayList<Float>();
    ArrayList<Float> teamGoalsInput = new ArrayList<Float>();
    ArrayList<String> legends = new ArrayList<String>();
    String title = "";

    //get data
    for (int i = 0; i < statNames.length; i++){ //for each stat
      if (statCheckboxes.get(statNames[i]).checked){ //check if stat if selected
        title = statNames[i];
        for (int j = 0; j < playerNames.size(); j ++){ //for every player IN ORDER
          PlayerButton pb = players.get(playerNames.get(j));
          if (pb.checked){ //check if player is selected
            //data
            legends.add(playerNumbers.get(playerNames.get(j)));
            for (int k = 0; k <= sessionIndexEnd - sessionIndexBegin; k ++){
              data.add(pb.stats.get(statNames[i]).get(sessionIndexBegin + k));
            }
            //goals
            for (int k = sessionIndexBegin; k <= sessionIndexEnd; k ++){
              teamGoalsInput.add(teamGoals.get(statNames[i]).get(k));
            }
          }
        }
      }
    }

    //xlabel
    ArrayList<String> xLabel = new ArrayList<String>();
    for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
      xLabel.add(sessionDates.get(i));
    }

    rectMode(CORNER);
    if (singlePercent){
      drawGraph(title, "Scatter", xLabel, "%", data);
      drawMultiScatterPlotPercent(data, teamGoalsInput, legends);
    } else{
      drawGraph(title, "Scatter", xLabel, title, data);
      drawMultiScatterPlot(data, legends);
    }
    rectMode(CENTER);
  }
}
float startX;
int xSpaces;
int ySpaces = 10;
float sll = 5; //spacing line length
float offset = 20; //between spacing line and scale
float arrowLen = 8;

float yScaleUnit;
float percent = 15;
int sizeOfPoint = 7;
float lenbtwBars = 10;
float barShadingDist = 10;

float lineThickness = 1.2f;
int titleFontSize = 36;
int labelFontSize = 20;

float startY;
float ylen;
float xlen;
float yunit;
float xunit;

int[] colors = new int[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255),
color(0, 255, 255), color(255, 0, 255), color(255, 102, 0)};

public void drawGraph(String title, String mode, ArrayList<String> xLabel, String yLabel, ArrayList<Float> data){
  xSpaces = xLabel.size();

  //calculate y scaling unit
  float max = 0;
  for (int i = 0; i < data.size(); i++){
    max = Math.max(max, data.get(i));
  }

  yScaleUnit = (int) (max / ySpaces) + 1;

  //set unit
  yunit = ylen / (ySpaces + 1);
  xunit = xlen / (xSpaces + 1);

  //clear
  background(255);

  //graph lines
  line(startX, startY, startX + xlen - xunit / 2, startY);
  line(startX, startY, startX, startY - ylen + yunit / 2);

  //x arrows
  float x = startX + xlen - xunit / 2;
  float y = startY;
  line(x, y, x - arrowLen, y - arrowLen);
  line(x, y, x - arrowLen, y + arrowLen);

  //y arrows
  x = startX;
  y = startY - ylen + yunit / 2;
  line(x, y, x + arrowLen, y + arrowLen);
  line(x, y, x - arrowLen, y + arrowLen);

  //scales
  text(0, startX - 5, startY + 10);
  //x scale
  for (int i = 1; i <= xSpaces; i ++){
    line(startX + i*xunit, startY + sll, startX + i*xunit, startY - sll);
    if (mode.equals("Bar")){
      text(playerNumbers.get(xLabel.get(i-1)), startX + i*xunit - xunit/2, startY + offset);
    } else{
      text(xLabel.get(i-1), startX + i*xunit, startY + offset);
    }
  }
  //y scale
  for (int i = 1; i <= ySpaces; i ++){
    line(startX - sll, startY - i*yunit, startX + sll, startY - i*yunit);
    if (yLabel.equals("%")){
      text((int) (i * percent), startX - offset, startY - i*yunit + sll);
    } else{
      text((int) (i * yScaleUnit), startX - offset, startY - i*yunit + sll);
    }
  }

  //lables
  textSize(labelFontSize);

  //y label
  pushMatrix();
  translate(50, 250);
  rotate(radians(270));
  text(yLabel, 0, 0);
  popMatrix();

  //x lables
  if (mode.equals("Bar")){
    text("Players", startX + xlen / 2, startY + 50);
  } else{
    text("Sessions", startX + xlen / 2, startY + 50);
  }

  //title
  textSize(titleFontSize);
  text(title, startX + xlen/2, 50);
  textSize(defaultFontSize);
}

public void drawScatterPlot(ArrayList<Float> data){
  float max = -1;
  float lastX = -1;
  float lastY = -1;
  ArrayList<Float> xVal = new ArrayList<Float>();
  ArrayList<Float> yVal = new ArrayList<Float>();

  for (int i = 1; i <= xSpaces; i ++){
    if (data.get(i - 1) > -1){ //absent player
      //point
      float yNow = startY - data.get(i-1) / yScaleUnit * yunit;

      if (data.get(i - 1) >= max){
        max = data.get(i - 1);
        fill(0);
      } else{
        fill(255);
      }

      ellipse(startX + i*xunit, yNow, sizeOfPoint, sizeOfPoint);

      //line
      if (lastY > 0){
        line(lastX, lastY, startX + i*xunit, yNow);
      }

      //add for later calculation
      xVal.add(startX + i*xunit);
      yVal.add(yNow);

      //adjust for next loop
      lastX = startX + i*xunit;
      lastY = yNow;
    }
  }
  fill(0);
  lineOfBestFit(xVal, yVal);
}

public void drawScatterPlotPercent(ArrayList<Float> data, ArrayList<Float> goals){
  float max = -1;
  float lastX = -1;
  float lastY = -1;
  ArrayList<Float> xVal = new ArrayList<Float>();
  ArrayList<Float> yVal = new ArrayList<Float>();

  for (int i = 1; i <= xSpaces; i ++){
    if (data.get(i - 1) > -1){ //absent player
      //point
      float yNow = startY - data.get(i-1) / goals.get(i-1) * 100 / percent * yunit;

      if (data.get(i - 1) >= max){
        max = data.get(i - 1);
        fill(0);
      } else{
        fill(255);
      }

      ellipse(startX + i*xunit, yNow, sizeOfPoint, sizeOfPoint);

      //line
      if (lastY > 0){
        line(lastX, lastY, startX + i*xunit, yNow);
      }

      //add for later calculation
      xVal.add(startX + i*xunit);
      yVal.add(yNow);

      //adjust for next loop
      lastX = startX + i*xunit;
      lastY = yNow;
    }
  }
  fill(0);
  lineOfBestFit(xVal, yVal);
}

public void drawMultiScatterPlot(ArrayList<Float> data, ArrayList<String> legends){
  int numOfStat = legends.size();

  ArrayList<Integer> allColors = new ArrayList<Integer>();
  int[] palett = new int[numOfStat];
  if (numOfStat <= colors.length){
    //set colors
    for (int i = 0; i < colors.length; i ++){
      allColors.add(colors[i]);
    }
    for (int i = 0; i < palett.length; i ++){
      int ran = (int) random(allColors.size());
      palett[i] = allColors.get(ran);
      allColors.remove(ran);
    }
  } else{
    for (int x = 0; x < numOfStat; x ++){
      palett[x] = color(random(255), random(255), random(255));
    }
  }

  //loop
  int index = 0;
  for (int x = 0; x < numOfStat; x ++){
    fill(palett[x]);
    stroke(palett[x]);

    float max = -1;
    float lastX = -1;
    float lastY = -1;
    ArrayList<Float> xVal = new ArrayList<Float>();
    ArrayList<Float> yVal = new ArrayList<Float>();
    for (int i = 1; i <= xSpaces; i ++){
      if (data.get(index) > -1){ //absent player
        //point
        float yNow = startY - data.get(index) / yScaleUnit * yunit;

        if (data.get(index) >= max){
          max = data.get(index);
          fill(palett[x]);
        } else{
          fill(255);
        }

        ellipse(startX + i*xunit, yNow, sizeOfPoint, sizeOfPoint);

        //line
        if (lastY > 0){
          line(lastX, lastY, startX + i*xunit, yNow);
        }

        //add for later calculation
        xVal.add(startX + i*xunit);
        yVal.add(yNow);

        //adjust for next loop
        lastX = startX + i*xunit;
        lastY = yNow;
      }
      index ++;
    }
    fill(0);
    lineOfBestFit(xVal, yVal);
  }

  stroke(0);

  legend(palett, legends);
}

public void drawMultiScatterPlotPercent(ArrayList<Float> data, ArrayList<Float> goals, ArrayList<String> legends){
  int numOfStat = legends.size();

  ArrayList<Integer> allColors = new ArrayList<Integer>();
  int[] palett = new int[numOfStat];
  if (numOfStat <= colors.length){
    //set colors
    for (int i = 0; i < colors.length; i ++){
      allColors.add(colors[i]);
    }
    for (int i = 0; i < palett.length; i ++){
      int ran = (int) random(allColors.size());
      palett[i] = allColors.get(ran);
      allColors.remove(ran);
    }
  } else{
    for (int x = 0; x < numOfStat; x ++){
      palett[x] = color(random(255), random(255), random(255));
    }
  }

  //loop
  int index = 0;
  for (int x = 0; x < numOfStat; x ++){
    fill(palett[x]);
    stroke(palett[x]);

    float max = -1;
    float lastX = -1;
    float lastY = -1;
    ArrayList<Float> xVal = new ArrayList<Float>();
    ArrayList<Float> yVal = new ArrayList<Float>();
    for (int i = 1; i <= xSpaces; i ++){
      if (data.get(index) > -1){ //absent player
        //point
        float yNow = startY - data.get(index) / goals.get(index) * 100 / percent * yunit;

        if (data.get(index) >= max){
          max = data.get(index);
          fill(palett[x]);
        } else{
          fill(255);
        }

        ellipse(startX + i*xunit, yNow, sizeOfPoint, sizeOfPoint);

        //line
        if (lastY > 0){
          line(lastX, lastY, startX + i*xunit, yNow);
        }

        //add for later calculation
        xVal.add(startX + i*xunit);
        yVal.add(yNow);

        //adjust for next loop
        lastX = startX + i*xunit;
        lastY = yNow;
      }
      index ++;
    }
    fill(0);
    lineOfBestFit(xVal, yVal);
  }

  stroke(0);

  legend(palett, legends);
}

public void lineOfBestFit(ArrayList<Float> xVal, ArrayList<Float> yVal){
  //Count = the number of points
  int count = xVal.size();
  //SumX = sum of all the X values
  //SumY = sum of all the Y values
  //SumX2 = sum of the squares of the X values
  //SumXY = sum of the products X*Y for all the points
  float sumX = 0;
  float sumY = 0;
  float sumX2 = 0;
  float sumXY = 0;
  for (int i = 0; i < xVal.size(); i ++){
    sumX += xVal.get(i);
    sumY += yVal.get(i);
    sumX2 += Math.pow(xVal.get(i), 2);
    sumXY += xVal.get(i) * yVal.get(i);
  }
  //XMean = SumX / Count
  //YMean = SumY / Count
  float xMean = sumX / count;
  float yMean = sumY / count;

  //Slope = (SumXY - SumX * YMean) / (SumX2 - SumX * XMean)
  float m = (sumXY - sumX * yMean) / (sumX2 - sumX * xMean);
  //YInt = YMean - Slope * XMean
  float b = yMean - m * xMean;

  //start and end point determine a line
  float x0 = startX + xunit / 2;
  float y0 = m * x0 + b;

  float x1 = startX + xlen;
  float y1 = m * x1 + b;

  line(x0, y0, x1, y1);
}

public void drawBarGraph(ArrayList<Float> data, ArrayList<Float> indivGoals, float teamGoal){
  //draw bars
  for (int i = 0; i < xSpaces; i ++){
    if (data.get(i) > -1){ //absent player
      float h = data.get(i) / yScaleUnit * yunit;
      float goal = data.get(i) / indivGoals.get(i) * h;
      drawBar(1, 0, startX + i*xunit, startY, h, goal, color(0));
    }
  }

  //team goal line
  float teamGoalY = startY - teamGoal / yScaleUnit * yunit;
  line(startX, teamGoalY, startX + xlen - xunit / 2, teamGoalY);
}

public void drawBarGraphPercent(ArrayList<Float> data, ArrayList<Float> indivGoals, float teamGoal){
  //draw bars
  for (int i = 0; i < xSpaces; i ++){
    if (data.get(i) > -1){ //absent player
      float h = data.get(i) / teamGoal * 100 / percent * yunit;
      float goal = data.get(i) / indivGoals.get(i) * h;
      drawBar(1, 0, startX + i*xunit, startY, h, goal, color(0));
    }
  }
  //team goal line
  float teamGoalY = startY - 100 / percent * yunit;
  line(startX, teamGoalY, startX + xlen - xunit / 2, teamGoalY);
}

public void drawMultiBarGraph(ArrayList<Float> data, ArrayList<Float> indivGoals, ArrayList<String> legends,
int barNum, ArrayList<Float> teamGoals){
  //set colors
  ArrayList<Integer> allColors = new ArrayList<Integer>();
  for (int i = 0; i < colors.length; i ++){
    allColors.add(colors[i]);
  }
  int[] palett = new int[barNum];
  for (int i = 0; i < palett.length; i ++){
    int ran = (int) random(allColors.size());
    palett[i] = allColors.get(ran);
    allColors.remove(ran);
  }

  //draw bars
  int counter = 0;
  for (int i = 0; i < xSpaces; i ++){
    for (int j = 0; j < barNum; j ++){
      if (data.get(counter) > -1){ //absent player
        float h = data.get(counter) / teamGoals.get(j) * 100 / percent * yunit;
        float goal = data.get(counter) / indivGoals.get(counter) * h;
        drawBar(barNum, j, startX + i*xunit, startY, h, goal, palett[j]);
      }
      counter ++;
    }
  }

  legend(palett, legends);
}

public void drawBar(int barNum, int index, float x, float y, float h, float goal, int c){
  fill(c);
  float adjxUnit = xunit - lenbtwBars * 2;
  if (goal < h){
    fill(255);
    rect(x + lenbtwBars + adjxUnit / barNum * index, y, adjxUnit / barNum, -h);
    fill(c);
    rect(x + lenbtwBars + adjxUnit / barNum * index, y, adjxUnit / barNum, -goal);
    //stroke(c);
    //shading(x, adjxUnit, barNum, goal, index);
  } else{
    rect(x + lenbtwBars + adjxUnit / barNum * index, y, adjxUnit / barNum, -h);
  }
  fill(0);
  stroke(0);
}

public void shading(float x, float adjxUnit, int barNum, float h, int index){
  float i = startY - barShadingDist / 2;
  float xVal = x + lenbtwBars + adjxUnit / barNum * index;
  while (i - barShadingDist > startY - h){
    line(xVal, i, xVal + adjxUnit / barNum, i - barShadingDist);
    i -= barShadingDist;
  }
  //top line
  line(xVal, i, xVal + (i - startY + h) / barShadingDist * (adjxUnit / barNum), startY - h);
  //bot line
  line(xVal + 1/2 * (adjxUnit / barNum), startY, xVal + adjxUnit / barNum, startY - barShadingDist / 2);
}

public void legend(int[] palett, ArrayList<String> legends){
  textAlign(LEFT);
  float posX = width - 125;
  float posY = 25;
  float dy = 25;
  float size = 20;
  for (int i = 0; i < palett.length; i ++){
    fill(palett[i]);
    rect(posX - 5, posY + i*dy - 15, -size, size);
    fill(0);
    text(legends.get(i), posX, posY + i*dy);
  }
  textAlign(CENTER);
}
int sessionIndexBegin;
int sessionIndexEnd;
int outputTop;
int outputBot;

public class Handle {
  int x;
  int y;

  int size;
  boolean over;
  boolean hold = false;

  int minX;
  int maxX;

  boolean top;

  Handle(boolean top, int y, int minX, int s) {
    this.y = y;
    this.minX = minX;
    this.maxX = width - minX;
    this.size = s;
    this.top = top;
    if (top){
      x = minX;
    }else{
      x = maxX-1;
    }
  }

  public void update() {
    if (hold) {
      x = lock(mouseX);
    }

    //display
    overEvent();
    display();
  }

  public void overEvent() {
    if (overRect(x, y, size, size)) {
      over = true;
    } else {
      over = false;
    }
  }

  public void display() {
    //handle display
    line(minX, y, maxX, y);
    fill(255);
    stroke(0);
    rect(x, y, size, size);
    if (over || hold) {
      line(x-size/2, y-size/2, x+size/2, y+size/2);
      line(x+size/2, y-size/2, x-size/2, y+size/2);
    }
    //set session num
    int output = (int) (sessionDates.size() * (x - minX) / (maxX - minX));
    if (top){
      outputTop = output;
    } else{
      outputBot = output;
    }
    sessionIndexBegin = min(outputTop, outputBot);
    sessionIndexEnd = max(outputTop, outputBot);

    //date display
    fill(0);
    textSize(25);
    if (sessionIndexBegin == sessionIndexEnd){
      text(sessionDates.get(sessionIndexBegin), width/2, height/4);
    } else{
      text("From " + sessionDates.get(sessionIndexBegin) + " to " + sessionDates.get(sessionIndexEnd), width/2, height/4);
    }
    textSize(defaultFontSize);
  }

  public boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x - width/2 && mouseX <= x+width/2 &&
      mouseY >= y - height/2 && mouseY <= y+height/2) {
      return true;
    } else {
      return false;
    }
  }

  public int lock(int val) {
    return min(max(val, minX), maxX-1);
  }

  public void pressEvent(){
    if (over){
      hold = true;
    }
  }

  public void releaseEvent(){
    hold = false;
  }
}
public class PlayerButton extends Button{
  boolean checked = true;
  String position;

  //each stat in order of session
  HashMap<String, ArrayList<Float>> stats = new HashMap<String, ArrayList<Float>>();

  public PlayerButton(float yIndex, int wid, int hei, String name, String pos) {
    super(0, 0, wid, hei, 25, name);

    int num;
    //find number of button in a column
    if (pos.equals("Defense")){
      num = 4;
    } else{
      num = 3;
    }

    //set x value base on pos
    if (pos.equals("Defense")){
      num = 4;
      x = width / 4;
    } else{
      num = 3;
      if (pos.equals("Center")){
        x = width / 2;
      }
      else if (pos.equals("Offense")){
        x = width * 3 / 4;
      }
    }
    this.y = yIndex * (height - benchLen) / num + (height - benchLen) / num / 2;
    this.position = pos;
  }

  public PlayerButton(float xIndex, int wid, int hei, String name, String pos, int total) {
    super(0, 0, wid, hei, 25, name);

    if (xIndex > total/2){ //top row
      this.x = (xIndex - (total+1)/2) * width / (total / 2 + 1) + width / total;
      this.y = height - benchLen / 4;
      this.position = pos;
    } else{ //bot row
      this.x = xIndex * width / (total / 2 + 1) + width / total;
      this.y = height - benchLen * 3 / 4;
      this.position = pos;
    }
  }

  public void update() {
    //update over
    if (isOver()){
      over = true;
      handCursor = true;
    }
    else {
      over = false;
    }

    //display depend on over
    if (checked){
      fill(0, 255, 255);
    } else{
      fill(255);
    }
    rect(x, y, wid, hei);
    fill(0);

    textSize(fontSize);
    text(playerNumbers.get(word), x, y);
    textSize(fontSize);
  }
}
String screen = "Intro";

PImage SoccerField;

int benchLen = 150;

boolean handCursor;

public void draw(){
  handCursor = false;
  if (screen.equals("Display")){
    if (table.tableMode){
      table.word = "graph";
    } else{
      table.word = "Table";
    }
    table.update();
    if (table.tableMode && sessionIndexBegin != sessionIndexEnd){
      statIndexChange.update();
    }
    if (numOfStatOn() == 1){
      average.update();
      percentage.update();
    }
  } else{ //refresh when not display
    background(255);
  }

  if (screen.equals("Session Selecting")){
    sessionHandleTop.update();
    sessionHandleBot.update();
  }

  else if (screen.equals("Player Selecting")){
    //soccer field image
    image(SoccerField, 0, 0, width, height - benchLen);
    for (String i : players.keySet()){
      players.get(i).update();
    }
    //player change buttons
    for (AllPlayerChangeButton apcb : playerChange){
      apcb.update();
    }
  }

  else if (screen.equals("Stat Selecting")){
    for (String i : statCheckboxes.keySet()){
      statCheckboxes.get(i).update();
    }
    if (numOfStatOn() > 0){
      allStatChange.word = "All Off";
    } else{
      allStatChange.word = "All On";
    }
    allStatChange.update();
  }

  if (screen.equals("Intro")){
    indiv.update();
    session.update();
    stat.update();
    graph.update();
  } else{
    //don't display if all stats off
    if (numOfStatOn() > 0){
      back.update();
    }
  }

  if (handCursor){
    cursor(HAND);
  } else{
    cursor(ARROW);
  }
}

public void mousePressed() {
  //back button
  if (back.over){
    screen = "Intro";
    //reset modes
    back.over = false;
    table.tableMode = false;
    takeAverage = true;
    singlePercent = false;
  }

  //other buttons
  else if (screen.equals("Intro")){
    if (indiv.over) {
      screen = "Player Selecting";
    }
    else if (session.over) {
      screen = "Session Selecting";
    }
    else if (stat.over) {
      screen = "Stat Selecting";
    }
    else if (graph.over){
      graph.graph();
      screen = "Display";
    }
  }
  else if (screen.equals("Display")){
    if (table.over){
      //display table vs display graph
      table.tableMode = !table.tableMode;
      if (table.tableMode){
        table.displayTable();
      } else{
        graph.graph();
      }
    }
    else if (average.over){
      if (takeAverage){
        average.word = "Average: Off";
      } else{
        average.word = "Average: On";
      }
      takeAverage = !takeAverage;
      graph.graph();
    }
    else if (percentage.over){
      if (singlePercent){
        percentage.word = "Percent: Off";
      } else{
        percentage.word = "Percent: On";
      }
      singlePercent = !singlePercent;
      graph.graph();
    }
    else if (statIndexChange.over){
      table.statIndex = table.nextValidStatIndex(table.statIndex);
      background(255);
      table.displayTable();
    }
  }
  else if (screen.equals("Session Selecting")){
    sessionHandleTop.pressEvent();
    sessionHandleBot.pressEvent();
  }
  else if (screen.equals("Player Selecting")){
    for (String i : players.keySet()){
      if (players.get(i).over){
        players.get(i).checked = !players.get(i).checked;
      }
    }

    //player change buttons
    for (AllPlayerChangeButton apcb : playerChange){
      if (apcb.over){
        apcb.change();
      }
    }
  }
  else if (screen.equals("Stat Selecting")){
    for (String i : statCheckboxes.keySet()){
      if (statCheckboxes.get(i).over){
        statCheckboxes.get(i).checked = !statCheckboxes.get(i).checked;
      }
    }
    if (allStatChange.over){
      boolean status;
      if (numOfStatOn() > 0){
        status = false;
      } else{
        status = true;
      }
      for (String i : statCheckboxes.keySet()){
        statCheckboxes.get(i).checked = status;
      }
    }
  }
}

public void mouseReleased() {
  if (screen.equals("Session Selecting")){
    sessionHandleTop.releaseEvent();
    sessionHandleBot.releaseEvent();
  }
}

public int numOfStatOn(){
  int ans = 0;
  for (int i = 0; i < statNames.length; i++){
      if (statCheckboxes.get(statNames[i]).checked){
        ans ++;
      }
  }
  return ans;
}
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

  public void displayGraph(){
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
      if (singlePercent){
        drawGraph(date, "Bar", xLabel, "%", data);
        drawBarGraphPercent(data, indivGoalsInput, teamGoals[statIndex]);
      } else{
        drawGraph(date, "Bar", xLabel, statNames[statIndex], data);
        drawBarGraph(data, indivGoalsInput, teamGoals[statIndex]);
      }
    }
    rectMode(CENTER);
  }
}
public class StatCheckbox{
  int index; //index in the statNames
  float x;
  float y;
  int size;
  int origColor;
  boolean over = false;
  boolean checked = true;

  public StatCheckbox(float x, float y, int c, int size, int i) {
    origColor = c;
    this.x = x;
    this.y = y;
    this.size = size;
    index = i;
  }

  public void update() {
    //update over
    if (isOver()){
      over = true;
    }
    else {
      over = false;
    }

    if (over) {
      fill(highlight);
    } else {
      fill(origColor);
    }

    //display
    rect(x, y, size, size);

    //check mark
    if (checked){
      line(x-20, y-15, x, y+10);
      line(x+30, y-40, x, y+10);
    }

    fill(0);

    //text
    textAlign(LEFT);
    textSize(25);
    text(statNames[index], x + size/2+5, y+5);
    textSize(defaultFontSize);
    textAlign(CENTER);
  }

  public boolean isOver()  {
    if (mouseX >= x-size/2 && mouseX <= x+size/2 &&
        mouseY >= y-size/2 && mouseY <= y+size/2) {
      return true;
    } else {
      return false;
    }
  }
}
public class TableButton extends Button{
  int statIndex = 0;
  boolean tableMode = false;

  public TableButton(float x, float y, float wid, float hei) {
    super(x, y, wid, hei, defaultFontSize, "");
  }

  public void dataPrint(){
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

  public void displayTable(){
    background(255);
    if (sessionIndexBegin == sessionIndexEnd){
      oneSessionTable();
    } else{
      mutliSessionTable();
    }
  }

  public void mutliSessionTable(){
    //edge case of figuring out which stat
    if (! statCheckboxes.get(statNames[statIndex]).checked){
      statIndex = nextValidStatIndex(statIndex);
    }

    //find all included players
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        playerIncluded.add(playerNames.get(i));
      }
    }

    //set unit
    int tableBot = height - 10; //leave space for buttons
    int xTotal = sessionIndexEnd - sessionIndexBegin + 3;
    int yTotal = playerIncluded.size() + 3;
    int xSize = width/ xTotal;
    int ySize = tableBot / yTotal;

    //display stat change button
    statIndexChange.x = xSize;
    statIndexChange.y = ySize;
    statIndexChange.wid = xSize - 10;
    statIndexChange.hei = ySize - 10;
    statIndexChange.word = "Stat "+ (table.statIndex + 1);

    //grid lines
    for (int i = 0; i < yTotal; i ++){ //horizontal
      line(xSize/2, (i + 0.5f) * ySize, (xTotal - 0.5f)*xSize, (i + 0.5f) * ySize);
    }
    for (int i = 0; i < xTotal; i ++){ //vertical
      line((i + 0.5f) * xSize, ySize/2, (i + 0.5f)*xSize, (yTotal - 0.5f) * ySize);
    }

    //first col
    for (int i = 0; i < playerIncluded.size(); i ++){
      text(playerNumbers.get(playerIncluded.get(i)), xSize, (i + 2) * ySize);
    }
    text("Team", xSize, (yTotal - 1) * ySize);

    //for every session
    for (int i = sessionIndexBegin; i <= sessionIndexEnd; i ++){
      int xCount = i - sessionIndexBegin + 2;
      //first row
      text(sessionDates.get(i), xCount * xSize, ySize);

      //each player
      int yCount = 2;
      SessionData sd = sessions.get(sessionDates.get(i));
      ArrayList<Float> curr = sd.stats.get(statNames[statIndex]); //for this stat
      for (int j = 0; j < curr.size(); j ++){ //for each player
        if (players.get(playerNames.get(j)).checked){ //if included
          text(curr.get(j), xCount * xSize, yCount * ySize);
          yCount ++;
        }
      }

      //team goal
      text(sd.teamGoals[statIndex], xCount * xSize, (yTotal - 1) * ySize);
    }
  }

  public void oneSessionTable(){
    //prepare
    SessionData sd = sessions.get(sessionDates.get(sessionIndexBegin));

    //find all player included
    ArrayList<String> playerIncluded = new ArrayList<String>();
    for (int i = 0; i < playerNames.size(); i ++){
      if (players.get(playerNames.get(i)).checked){
        playerIncluded.add(playerNames.get(i));
      }
    }
    //find all stat included
    ArrayList<String> statIncluded = new ArrayList<String>();
    for (int i = 0; i < statNames.length; i ++){
      if (statCheckboxes.get(statNames[i]).checked){
        statIncluded.add(statNames[i]);
      }
    }

    //set unit
    int tableBot = height - 10; //leave space for buttons
    int xTotal = statIncluded.size() + 2;
    int yTotal = playerIncluded.size() + 3;
    int xSize = width / xTotal;
    int ySize = tableBot / yTotal;

    //grid lines
    for (int i = 0; i < yTotal; i ++){ //horizontal
      line(xSize/2, (i + 0.5f) * ySize, (xTotal - 0.5f) * xSize, (i + 0.5f) * ySize);
    }
    for (int i = 0; i < xTotal; i ++){ //vertical
      line((i + 0.5f) * xSize, ySize/2, (i + 0.5f) * xSize, (yTotal - 0.5f) * ySize);
    }

    //first col
    for (int i = 0; i < playerIncluded.size(); i ++){
      text(playerNumbers.get(playerIncluded.get(i)), xSize, (i + 2) * ySize);
    }
    text("Team Goals", xSize, (yTotal - 1) * ySize);

    //other part
    int xCount = 2;
    //for each stat
    for (int i = 0; i < statNames.length; i ++){ //for each stat
      if (statCheckboxes.get(statNames[i]).checked){ //if included
        //first row
        text(statNames[i], xCount * xSize, ySize);

        //for this stat
        ArrayList<Float> curr = sd.stats.get(statNames[i]);
        int yCount = 2;
        for (int j = 0; j < curr.size(); j ++){//for each player
          if (players.get(playerNames.get(j)).checked){ //if included
            text(curr.get(j), xCount * xSize,  yCount * ySize);
            yCount ++;
          }
        }

        //team goals
        text(sd.teamGoals[i], xCount * xSize, (yTotal - 1) * ySize);

        xCount ++;
      }
    }
  }

  public int nextValidStatIndex(int curIndex){
    curIndex ++;
    while (curIndex < statNames.length){
      if (statCheckboxes.get(statNames[curIndex]).checked){
        return curIndex;
      }
      curIndex ++;
    }

    curIndex = 0;

    while (curIndex < statNames.length){
      if (statCheckboxes.get(statNames[curIndex]).checked){
        return curIndex;
      }
      curIndex ++;
    }

    return -1;
  }
}
