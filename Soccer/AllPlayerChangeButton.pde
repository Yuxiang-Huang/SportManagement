public class AllPlayerChangeButton{
  float x; 
  float y;    
  int xSize;
  int ySize;
  color origColor;
  boolean over = false;
  
  boolean allOff = true;
  
  String position;
  
  boolean backup;

  public AllPlayerChangeButton(color c, int xSize, int ySize, String pos, int i) {
    origColor = c;
    this.xSize = xSize;
    this.ySize = ySize;
    position = pos;
    x = width - xSize/2-10;
    y = (height - benchLen)/5*i; //4 buttons
  }
  
  public AllPlayerChangeButton(color c, int xSize, int ySize, String pos) {
    origColor = c;
    this.xSize = xSize;
    this.ySize = ySize;
    position = pos;
    x = width - xSize/2-10;
    y = (height - benchLen/4);
    backup = true;
    allOff = false;
  }
  
  void update() {
    //update over
    if (over()){
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

    rect(x, y, xSize, ySize);
    
    fill(0);
    textSize(16);
    if (position.equals("All")){
      if (allOff){
        text("All Off", x, y);
      } else{
        text("All On", x, y);
      }
    } else{
      if (allOff){
        text("All " + position + " Off", x, y);
      } else{
        text("All " + position + " On", x, y);
      }
    }
    textSize(fontSize);
  }
  
  void change(){
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
    
  boolean over()  {
    if (mouseX >= x-xSize/2 && mouseX <= x+xSize/2 && 
        mouseY >= y-ySize/2 && mouseY <= y+ySize/2) {
      return true;
    } else {
      return false;
    }
  }
}
