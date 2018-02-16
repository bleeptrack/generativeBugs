
class Beetle{
PVector neck;
int neckHandle;
PVector shoulderR;
PVector shoulderL;
int shoulderHandle;
PVector bottom;
int bottomHandle;
int bottomSize;

PVector wingM;
PVector wingL;
PVector wingR;
int wingHandleDown;
int wingHandlePoint;
int wingHandleShoulder;
int wingHandleM;

PVector head;
int headV;
int headH;

PVector antennaL1;
PVector antennaL2;
PVector antennaR1;
PVector antennaR2;
int antennaHandle;

PVector legC1;
PVector legC2;
PVector legC3;

int legThickness;
int legLength;

int legAngleC1;
int legAngleC2;
int legAngleC3;

int legAngle2C1;
int legAngle2C2;
int legAngle2C3;

int legAngle3C1;
int legAngle3C2;
int legAngle3C3;

int nbrFeet;

Beetle(){
  init();
}

void draw(){
  drawLegs();
  noFill();
  drawAntenna();
  fill(255);
  drawHead();
  drawBody();
  drawWing();
}

void init(){
  neck = new PVector(width/2,100);
  int neckoffX = round(random(5,70));
  int neckoffY = round(random(20,70));
  
  shoulderR = new PVector(neck.x+neckoffX,neck.y+neckoffY);
  shoulderL = new PVector(neck.x-neckoffX,neck.y+neckoffY);
  int bottomSize = round(random(150,350));
  bottom = new PVector(neck.x,neck.y+bottomSize);
  
  neckHandle = round(random(20,neckoffX));
  bottomHandle = round(random(20,100));
  
  
  head = new PVector(neck.x,neck.y);
  headV = round(random(30,neckoffX));
  headH = round(random(10,50));
  
  int wingoff = round(random(0,neckoffY));
  wingM = new PVector(neck.x,shoulderL.y+wingoff);
  int wingSize = round(random(50,350));
  int wingoffX = round(random(0,neckoffX*2)-neckoffX);
  wingL = new PVector(shoulderL.x+wingoffX,shoulderL.y+wingSize);
  wingR = new PVector(shoulderR.x-wingoffX,shoulderR.y+wingSize);
  
  wingHandleDown = round(random(5,60));
  wingHandlePoint = round(random(5,neckoffX));
  wingHandleShoulder = round(random(5,60));
  wingHandleM = round(random(10,neckoffX));
  
  
  int antoffX = round(random(30,125));
  int antoffY = round(random(10,head.y-20));
  int antoffX2 = round(random(125,240));
  int antoffY2 = round(random(10,250));
  
  antennaL1 = new PVector(head.x-antoffX,antoffY);
  antennaL2 = new PVector(head.x-antoffX2,antoffY2);
  
  antennaR1 = new PVector(head.x+antoffX,antoffY);
  antennaR2 = new PVector(head.x+antoffX2,antoffY2);
  antennaHandle = round(random(20,100));
  
  legThickness = int(random(7,15));
  legLength = int(random(50,100));
  
  legAngleC1 = -int(random(15,45));
  legAngleC2 = int(random(0,25));
  legAngleC3 = int(random(30,50));
  
  legAngle2C1 = int(random(30,80));
  legAngle2C2 = int(random(30,80));
  legAngle2C3 = int(random(20,45));
  
  legAngle3C1 = -int(random(15,70));
  legAngle3C2 = -int(random(15,70));
  legAngle3C3 = -int(random(15,70));
  
  //legC1 = new PVector(neck.x, neck.y + (wingM.y-neck.y)/2 - legThickness/2 );
  legC1 = new PVector(wingM.x, wingM.y);
  legC2 = new PVector(neck.x, shoulderL.y + (bottom.y-shoulderL.y)/3  - legThickness/2);
  legC3 = new PVector(neck.x, bottom.y - (bottom.y-shoulderL.y)/3  - legThickness/2);
  
  nbrFeet = int(random(2,6));
  
}

void drawAntenna(){
  int end = int(random(0,3));
  int secondPart = int(random(0,2));
  int param = int(random(3,6));
  int len = int(random(8,17));
  System.out.println(end);
  bezier(head.x-(headV/4), head.y, head.x-(headV/4), head.y-30, antennaL1.x+antennaHandle, antennaL1.y, antennaL1.x, antennaL1.y);
  bezier(head.x+(headV/4), head.y, head.x+(headV/4), head.y-30, antennaR1.x-antennaHandle, antennaR1.y, antennaR1.x, antennaR1.y);
  if(secondPart>=1){
    bezier(antennaL1.x, antennaL1.y, antennaL1.x-antennaHandle, antennaL1.y, antennaL2.x, antennaL2.y, antennaL2.x, antennaL2.y);
    bezier(antennaR1.x, antennaR1.y, antennaR1.x+antennaHandle, antennaR1.y, antennaR2.x, antennaR2.y, antennaR2.x, antennaR2.y);
    
    switch(end){
      case 1:
        ellipse(antennaR2.x,antennaR2.y,param*2,param*2);
        ellipse(antennaL2.x,antennaL2.y,param*2,param*2);
        break;
      case 2:
        for(int i = 1; i<=param; i++){
          float x = bezierPoint(antennaR1.x, antennaR1.x+antennaHandle, antennaR2.x, antennaR2.x, 1-(i*0.05));
          float y = bezierPoint(antennaR1.y, antennaR1.y, antennaR2.y, antennaR2.y, 1-(i*0.05));
          float tx = bezierTangent(antennaR1.x, antennaR1.x+antennaHandle, antennaR2.x, antennaR2.x, 1-(i*0.05));
          float ty = bezierTangent(antennaR1.y, antennaR1.y, antennaR2.y, antennaR2.y, 1-(i*0.05));
          float a = atan2(ty, tx);
          a -= HALF_PI;
          line(x, y, cos(a)*len + x, sin(a)*len + y);
          
          x = bezierPoint(antennaL1.x, antennaL1.x-antennaHandle, antennaL2.x, antennaL2.x, 1-(i*0.05));
          y = bezierPoint(antennaL1.y, antennaL1.y, antennaL2.y, antennaL2.y, 1-(i*0.05));
          tx = bezierTangent(antennaL1.x, antennaL1.x-antennaHandle, antennaL2.x, antennaL2.x, 1-(i*0.05));
          ty = bezierTangent(antennaL1.y, antennaL1.y, antennaL2.y, antennaL2.y, 1-(i*0.05));
          a = atan2(ty, tx);
          a -= HALF_PI;
          line(x, y, -cos(a)*len + x, -sin(a)*len + y);
        }
        break;
    }
  }else{
    switch(end){
      case 1:
        ellipse(antennaR1.x,antennaR1.y,param,param);
        ellipse(antennaL1.x,antennaL1.y,param,param);
        break;
      case 2:
        for(int i = 1; i<=param; i++){
          float x = bezierPoint(head.x+(headV/4), head.x+(headV/4), antennaR1.x-antennaHandle, antennaR1.x, 1-(i*0.05));
          float y = bezierPoint(head.y, head.y-30, antennaR1.y, antennaR1.y, 1-(i*0.05));
          float tx = bezierTangent(head.x+(headV/4), head.x+(headV/4), antennaR1.x-antennaHandle, antennaR1.x, 1-(i*0.05));
          float ty = bezierTangent(head.y, head.y-30, antennaR1.y, antennaR1.y, 1-(i*0.05));
          float a = atan2(ty, tx);
          a -= HALF_PI;
          line(x, y, cos(a)*len + x, sin(a)*len + y);
          
          x = bezierPoint(head.x-(headV/4), head.x-(headV/4), antennaL1.x+antennaHandle, antennaL1.x, 1-(i*0.05));
          y = bezierPoint(head.y, head.y-30, antennaL1.y, antennaL1.y, 1-(i*0.05));
          tx = bezierTangent(head.x-(headV/4), head.x-(headV/4), antennaL1.x+antennaHandle, antennaL1.x, 1-(i*0.05));
          ty = bezierTangent(head.y, head.y-30, antennaL1.y, antennaL1.y, 1-(i*0.05));
          a = atan2(ty, tx);
          a -= HALF_PI;
          line(x, y, -cos(a)*len + x, -sin(a)*len + y);
        }
        break;
    }
  }
}

void drawHead(){
  ellipse(head.x,head.y,headV,headH);
}

void drawBody(){
  beginShape();
  vertex(neck.x, neck.y);
  bezierVertex(neck.x+neckHandle, neck.y, shoulderR.x,shoulderR.y , shoulderR.x, shoulderR.y);
  bezierVertex(shoulderR.x,shoulderR.y , bottom.x+bottomHandle,bottom.y, bottom.x, bottom.y);
  bezierVertex(bottom.x-bottomHandle,bottom.y , shoulderL.x, shoulderL.y, shoulderL.x, shoulderL.y);
  bezierVertex(shoulderL.x,shoulderL.y,neck.x-neckHandle, neck.y, neck.x, neck.y);
  endShape();
}

void drawWing(){
  beginShape();
  vertex(shoulderL.x, shoulderL.y);
  bezierVertex(shoulderL.x, shoulderL.y, wingM.x-wingHandleM,wingM.y , wingM.x, wingM.y);
  bezierVertex(wingM.x, wingM.y+wingHandleDown, wingL.x+wingHandlePoint, wingL.y, wingL.x, wingL.y);
  bezierVertex(wingL.x-wingHandlePoint, wingL.y, shoulderL.x-wingHandleShoulder, shoulderL.y+wingHandleShoulder,shoulderL.x, shoulderL.y);
  endShape();
  
  beginShape();
  vertex(shoulderR.x, shoulderR.y);
  bezierVertex(shoulderR.x, shoulderR.y, wingM.x+wingHandleM,wingM.y , wingM.x, wingM.y);
  bezierVertex(wingM.x, wingM.y+wingHandleDown, wingR.x-wingHandlePoint, wingR.y, wingR.x, wingR.y);
  bezierVertex(wingR.x+wingHandlePoint, wingR.y, shoulderR.x+wingHandleShoulder, shoulderR.y+wingHandleShoulder,shoulderR.x, shoulderR.y);
  endShape();
}

void drawLegs(){
  pushMatrix();
  translate(legC1.x,legC1.y);
  rotate(radians(legAngleC1));
  rect(0,0,legLength, legThickness);
  
  translate(legLength,0);
  rotate(radians(legAngle2C1));
  rect(0,0,legLength/2, legThickness);
  
  translate(legLength/2,legThickness/2);
  rotate(radians(legAngle3C1));
  for(int i = 0; i<nbrFeet; i++){
    triangle(0,0,10, legThickness/2, 10, -legThickness/2);
    translate(10,0);
  }
  line(0,0, 10, -legThickness/3);
  line(0,0, 10, legThickness/3);
  popMatrix();
  
  pushMatrix();
  translate(legC1.x,legC1.y);
  rotate(radians(-legAngleC1));
  rect(0,0,-legLength, legThickness);
  
  translate(-legLength,0);
  rotate(radians(-legAngle2C1));
  rect(0,0,-legLength/2, legThickness);
  
  translate(-legLength/2,legThickness/2);
  rotate(radians(-legAngle3C1));
  for(int i = 0; i<nbrFeet; i++){
    triangle(0,0,-10, legThickness/2, -10, -legThickness/2);
    translate(-10,0);
  }
  line(0,0, -10, -legThickness/3);
  line(0,0, -10, legThickness/3);
  popMatrix();
  
  //////////
    pushMatrix();
  translate(legC2.x,legC2.y);
  rotate(radians(legAngleC2));
  rect(0,0,legLength, legThickness);
  
  translate(legLength,0);
  rotate(radians(legAngle2C2));
  rect(0,0,legLength/2, legThickness);
  
  translate(legLength/2,legThickness/2);
  rotate(radians(legAngle3C2));
  for(int i = 0; i<nbrFeet; i++){
    triangle(0,0,10, legThickness/2, 10, -legThickness/2);
    translate(10,0);
  }
  line(0,0, 10, -legThickness/3);
  line(0,0, 10, legThickness/3);
  popMatrix();
  
  pushMatrix();
  translate(legC2.x,legC2.y);
  rotate(radians(-legAngleC2));
  rect(0,0,-legLength, legThickness);
  
  translate(-legLength,0);
  rotate(radians(-legAngle2C2));
  rect(0,0,-legLength/2, legThickness);
  
  translate(-legLength/2,legThickness/2);
  rotate(radians(-legAngle3C2));
  for(int i = 0; i<nbrFeet; i++){
    triangle(0,0,-10, legThickness/2, -10, -legThickness/2);
    translate(-10,0);
  }
  line(0,0, -10, -legThickness/3);
  line(0,0, -10, legThickness/3);
  popMatrix();
  
  //////////
  
  pushMatrix();
  translate(legC3.x,legC3.y);
  rotate(radians(legAngleC3));
  rect(0,0,legLength, legThickness);
  
  translate(legLength,0);
  rotate(radians(legAngle2C3));
  rect(0,0,legLength/2, legThickness);
  
  translate(legLength/2,legThickness/2);
  rotate(radians(legAngle3C3));
  for(int i = 0; i<nbrFeet; i++){
    triangle(0,0,10, legThickness/2, 10, -legThickness/2);
    translate(10,0);
  }
  line(0,0, 10, -legThickness/3);
  line(0,0, 10, legThickness/3);
  popMatrix();
  
  pushMatrix();
  translate(legC3.x,legC3.y);
  rotate(radians(-legAngleC3));
  rect(0,0,-legLength, legThickness);
  
  translate(-legLength,0);
  rotate(radians(-legAngle2C3));
  rect(0,0,-legLength/2, legThickness);
  
  translate(-legLength/2,legThickness/2);
  rotate(radians(-legAngle3C3));
  for(int i = 0; i<nbrFeet; i++){
    triangle(0,0,-10, legThickness/2, -10, -legThickness/2);
    translate(-10,0);
  }
  line(0,0, -10, -legThickness/3);
  line(0,0, -10, legThickness/3);
  popMatrix();
}

}