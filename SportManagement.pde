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

String[] allData;
String[] commands;
String[] xLabel;
ArrayList<Float> data = new ArrayList<Float>();
int index = -1;

color[] colors = new color[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255),
color(0, 255, 255), color(255, 0, 255), color(255, 255, 0)}; 

IndivButton indiv;
 
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
  
  indiv = new IndivButton(width/2, height/2, 0, 100);
}

void draw(){
  indiv.update();
}

void mousePressed() {
  if (indiv.over) {
    println("pressed");
  }
}
