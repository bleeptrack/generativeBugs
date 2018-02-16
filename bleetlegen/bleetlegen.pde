Beetle b;

void setup(){
  size(500,500);
  strokeWeight(4);  
  noLoop();

  b = new Beetle();
}

void draw(){
  b.draw();
}