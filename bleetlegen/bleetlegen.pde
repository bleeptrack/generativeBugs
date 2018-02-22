import java.awt.*;

public void setup(){
  size(500,250);
  background(255);
  noLoop();
  
      
  Beetle b1 = new Beetle(true);
  image(b1.getImage(),0,0,250,250);
  
  Beetle b2 = new Beetle(false);
  image(b2.getImage(),250,0,250,250);
  
  
}

void draw(){

}