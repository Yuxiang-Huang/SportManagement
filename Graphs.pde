float startX = 100;
float startY = 400;
float ylen = 300;
float xlen = 800;
float yunit;
float xunit;

int xSpaces;
int ySpaces = 10;
float sll = 5; //spacing line length
float offset = 20; //between spacing line and scale
float arrowLen = 8;

float yScaleUnit;
float percent = 15;
int sizeOfPoint = 5;
float lenbtwBars = 10;

float lineThickness = 1.2;
int font = 12;

String[] xLabel;

color[] colors = new color[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255),
color(0, 255, 255), color(255, 0, 255), color(255, 255, 0)}; 
 
void drawGraph(String mode, String stat){
  //calculate y scaling unit
  float max = 0;
  for (int i = 0; i < data.size(); i++){
    max = Math.max(max, data.get(i));
  }
  
  yScaleUnit = int(max / ySpaces) + 1;
  
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
  //x
  for (int i = 1; i <= xSpaces; i ++){
    line(startX + i*xunit, startY + sll, startX + i*xunit, startY - sll);
    if (mode.equals("Bar") || mode.equals("Team Bar")){
      text(xLabel[i-1], startX + i*xunit - xunit/2, startY + offset);
    } else{
      text(xLabel[i-1], startX + i*xunit, startY + offset);
    }
  }
  //y
  for (int i = 1; i <= ySpaces; i ++){
    line(startX - sll, startY - i*yunit, startX + sll, startY - i*yunit);
    if (mode.equals("Team Bar")){
      text((int) (i * percent), startX - offset, startY - i*yunit + sll);
    } else{
      text((int) (i * yScaleUnit), startX - offset, startY - i*yunit + sll);
    }
  }
  
  //y label
  pushMatrix();
  translate(50, 250);
  rotate(radians(270));
  text(stat, 0, 0);
  popMatrix();
}

void drawScatterPlot(){
  //lables
  text("Sessions", startX + xlen / 2, startY + 50);
  
  //plot
  float lastY = -1;
  ArrayList<Float> xVal = new ArrayList<Float>();
  ArrayList<Float> yVal = new ArrayList<Float>();
  for (int i = 1; i <= xSpaces; i ++){      
    float yNow = startY - data.get(i-1) / yScaleUnit * yunit;
    
    circle(startX + i*xunit, yNow, sizeOfPoint);
    
    //line
    if (lastY > 0){
      line(startX + i*xunit - xunit, lastY, startX + i*xunit, yNow);
    }
    
    //add for later calculation
    xVal.add(startX + i*xunit);
    yVal.add(yNow);
    
    //adjust for next loop
    lastY = yNow;
  }

  //line of best fit
  
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
  
  float x1 = xlen;
  float y1 = m * x1 + b;
  
  line(x0, y0, x1, y1);
}

void drawBarGraph(ArrayList<Float> goals, float teamGoal){
  //lable
  text("Players", startX + xlen / 2, startY + 50);
  
  //draw bars
  for (int i = 0; i < xSpaces; i ++){
    float yNow = data.get(i) / yScaleUnit * yunit;
    drawBar(startX + i*xunit, startY, yNow, data.get(i) - goals.get(i));
  }
  
  //team goal line
  float teamGoalY = startY - teamGoal / yScaleUnit * yunit;
  line(startX, teamGoalY, startX + xlen - xunit / 2, teamGoalY);
}

void drawBar(float x, float y, float height, float det){  
  if (det < 0){
    fill(255, 0, 0);
  } else{
    fill(0, 255, 0);
  }
  
  //bar
  float adjxUnit = xunit - lenbtwBars * 2;
  rect(x + lenbtwBars, y, adjxUnit, -height);
  
  fill(0);
}

void drawTeamBarGraph(int barNum, float[] goals, String[] barNames){
  //lable
  text("Players", startX + xlen / 2, startY + 50);
  
  //set colors
  ArrayList<Integer> allColors = new ArrayList<Integer>();
  for (int i = 0; i < colors.length; i ++){
    allColors.add(colors[i]);
  }
  color[] palett = new color[barNum];
  for (int i = 0; i < palett.length; i ++){
    int ran = (int) random(allColors.size());
    palett[i] = allColors.get(ran);
    allColors.remove(ran);
  }
  
  //draw bars
  int counter = 0;
  for (int i = 0; i < xSpaces; i ++){
    for (int j = 0; j < barNum; j ++){
      float yNow = data.get(counter) / goals[j] * 100 / percent * yunit;
      drawTeamBar(barNum, j, startX + i*xunit, startY, yNow, palett[j]);
      counter ++;
    }
  }
  
  //legend
  textAlign(LEFT);
  float posX = startX + xlen - xunit;
  float posY = 50;
  float dy = 25;
  float size = 20;
  for (int i = 0; i < barNum; i ++){
    fill(palett[i]);
    rect(posX - 5, posY + i*dy - 15, -size, size);
    fill(0);
    text(barNames[i], posX, posY + i*dy);
  }
  textAlign(CENTER);
}

void drawTeamBar(int barNum, int index, float x, float y, float height, color c){  
  fill(c);
  float adjxUnit = xunit - lenbtwBars * 2;
  rect(x + lenbtwBars + adjxUnit / barNum * index, y, adjxUnit / barNum, -height);
  fill(0);
}
