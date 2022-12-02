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
  
  void update() {
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
}
