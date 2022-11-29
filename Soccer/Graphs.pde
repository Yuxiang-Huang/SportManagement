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

float lineThickness = 1.2;
int titleFontSize = 36;
int labelFontSize = 20;

float startY;
float ylen;
float xlen;
float yunit;
float xunit;

color[] colors = new color[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255),
color(0, 255, 255), color(255, 0, 255), color(255, 102, 0)}; 
 
void drawGraph(String title, String mode, ArrayList<String> xLabel, String yLabel, ArrayList<Float> data){
  xSpaces = xLabel.size();
  
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
  //x scale
  for (int i = 1; i <= xSpaces; i ++){
    line(startX + i*xunit, startY + sll, startX + i*xunit, startY - sll);
    if (mode.equals("Bar")){
      text(xLabel.get(i-1), startX + i*xunit - xunit/2, startY + offset);
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
  
  textSize(fontSize);
}

void drawScatterPlot(ArrayList<Float> data){
  float max = data.get(0);
  float lastX = -1;
  float lastY = -1;
  ArrayList<Float> xVal = new ArrayList<Float>();
  ArrayList<Float> yVal = new ArrayList<Float>();
  
      println(startY);
      println(yScaleUnit);
      println(yunit);
      
  for (int i = 1; i <= xSpaces; i ++){ 
    if (data.get(i - 1) > 0){ //absent player
      //point      
      float yNow = startY - data.get(i-1) / yScaleUnit * yunit;
      
      if (data.get(i - 1) >= max){
        max = data.get(i - 1);
        fill(0);
      } else{
        fill(255);
      }
   
      circle(startX + i*xunit, yNow, sizeOfPoint);
      
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

void drawMultiScatterPlot(ArrayList<Float> data, ArrayList<Float> goals, ArrayList<String> legends){
  int numOfStat = legends.size();
  
  //set colors
  ArrayList<Integer> allColors = new ArrayList<Integer>();
  for (int i = 0; i < colors.length; i ++){
    allColors.add(colors[i]);
  }
  color[] palett = new color[numOfStat];
  for (int i = 0; i < palett.length; i ++){
    int ran = (int) random(allColors.size());
    palett[i] = allColors.get(ran);
    allColors.remove(ran);
  }
  
  //loop
  int index = 0;
  for (int x = 0; x < numOfStat; x ++){
    fill(palett[x]);
    stroke(palett[x]);
    
    float max = data.get(index);
    float lastX = -1;
    float lastY = -1;
    ArrayList<Float> xVal = new ArrayList<Float>();
    ArrayList<Float> yVal = new ArrayList<Float>();
    for (int i = 1; i <= xSpaces; i ++){  
      if (data.get(index) > 0){ //absent player
        //point
        float yNow = startY - data.get(index) / goals.get(index) * 100 / percent * yunit;
        
        if (data.get(index) >= max){
          max = data.get(index);
          fill(0);
        } else{
          fill(255);
        }
      
        circle(startX + i*xunit, yNow, sizeOfPoint);
        
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
      } else{
        println(i);
      }
      index ++;
    }
    fill(0);
    lineOfBestFit(xVal, yVal);
  }
  
  stroke(0);
  
  legend(palett, legends);
}

void lineOfBestFit(ArrayList<Float> xVal, ArrayList<Float> yVal){
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

void drawBarGraph(ArrayList<Float> data, ArrayList<Float> indivGoals, float teamGoal){  
  //draw bars
  for (int i = 0; i < xSpaces; i ++){
    if (data.get(i) > 0){ //absent player
      float h = data.get(i) / yScaleUnit * yunit;
      drawBar(1, 0, startX + i*xunit, startY, h, color(0), data.get(i) - indivGoals.get(i));
    }
  }
  
  //team goal line
  float teamGoalY = startY - teamGoal / yScaleUnit * yunit;
  line(startX, teamGoalY, startX + xlen - xunit / 2, teamGoalY);
}

void drawMultiBarGraph(ArrayList<Float> data, ArrayList<Float> indivGoals, ArrayList<String> legends,
int barNum, ArrayList<Float> teamGoals){
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
      if (data.get(counter) > 0){ //absent player
        float yNow = data.get(counter) / teamGoals.get(j) * 100 / percent * yunit;
        drawBar(barNum, j, startX + i*xunit, startY, yNow, palett[j], data.get(counter) - indivGoals.get(counter));
      }
      counter ++;
    }
  }
  
  legend(palett, legends);
}

void drawBar(int barNum, int index, float x, float y, float h, color c, float det){ 
  fill(c);
  float adjxUnit = xunit - lenbtwBars * 2;
  if (det < 0){
    fill(255);
    rect(x + lenbtwBars + adjxUnit / barNum * index, y, adjxUnit / barNum, -h);
    fill(c);
    stroke(c);
    shading(x, adjxUnit, barNum, h, index); 
  } else{
    rect(x + lenbtwBars + adjxUnit / barNum * index, y, adjxUnit / barNum, -h);
  }
  fill(0);
  stroke(0);
}

void shading(float x, float adjxUnit, int barNum, float h, int index){
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

void legend(color[] palett, ArrayList<String> legends){
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
