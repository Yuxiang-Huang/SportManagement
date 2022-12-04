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
    text(word, x, y);
    textSize(fontSize);
  }
}
