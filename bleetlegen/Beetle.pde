import java.util.*;

class Beetle{
  
  PGraphics canvas;
  int size = 500;
  
  ArrayList<String> attributes = new ArrayList<String>();
  ArrayList<String> colors = new ArrayList<String>();
  String name;
  
  PGraphics wingMaskL;
  PGraphics wingMaskR;
  PGraphics wingPattern;
  
  int mainC;
  int headC;
  int feetC;
  int wingsC1;
  int wingsC2;
  
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
  
  boolean colored = true;
  
  Beetle(boolean colored){
    this.colored = colored;
    canvas = createGraphics(500,500);
    init();
    draw();
    generateName();
  }
  
  Beetle(){
    canvas = createGraphics(500,500);
    init();
    draw();
    generateName();
  }
  
  public void generateName(){
    Collections.shuffle(attributes);
    Collections.shuffle(colors);
    
    if(colored){
      name = colors.get(0)+" ";
    }else{
      name = "";
    }
    if(attributes.size()>0){
      name += attributes.get(0);
    }
    System.out.println(name);
  }
  
  public PGraphics getImage(){
    return canvas;
  }
  
  public void saveImage(String name){
    canvas.save(name+".png");
  }
  
  public void draw(){
    canvas.beginDraw();
    canvas.strokeWeight(4);
    canvas.fill(feetC);
    drawLegs();
    canvas.noFill();
    drawAntenna();
    canvas.fill(headC);
    drawHead();
    canvas.fill(mainC);
    drawBody();
    
    drawWing();
    canvas.endDraw();
  }
  
  public void printAttributes(){
    for(String s:attributes){
      System.out.println(s);
    }
  }
  
  public void init(){
      colorMode(HSB, 360, 100, 100);
    if(colored){
      int mainr = int(random(0,360));
      colors.add(getColorName(mainr));
      mainC = color(mainr, int(random(0,100)), 80);
      headC = color(mainr, int(random(0,100)), 70);
      feetC = color(mainr, int(random(0,100)), 50);
      
      int wingr = mainr+int(random(0,80))-40;
      wingsC1 = color(wingr, int(random(0,100)), 100);
      colors.add(getColorName(wingr)+"-winged");
      wingsC2 = color(wingr+int(random(0,150))-75, int(random(0,100)), 90);
    }else{
      mainC = color(0,0,100);
      headC = color(0,0,100);
      feetC = color(0,0,100);
      wingsC1 = color(0,0,100);
      wingsC2 = color(0,0,100);
    }
    
    
    neck = new PVector(500/2,100);
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
    
    if(wingL.y-bottom.y>70){
      attributes.add("long-winged");
    }
    if(bottom.y-wingL.y>30){
      attributes.add("short-winged");
    }
    if(bottom.y>400){
      attributes.add("large");
    }
    if(bottom.y<300 && neckoffX>30 && wingL.y<300){
      attributes.add("plump");
      attributes.add("small");
    }
    if(neckoffX<15 && bottomHandle<60){
      attributes.add("narrow");
    }
    
    
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
    
    legC1 = new PVector(neck.x, shoulderL.y);
    legC2 = new PVector(neck.x, wingM.y);
    legC3 = new PVector(neck.x, bottom.y - (bottom.y-shoulderL.y)/2);
    
    nbrFeet = int(random(2,6));
    if(nbrFeet>4){
      attributes.add("long-legged");
    }
    
  }
  
  public void drawPattern(){
    wingPattern = createGraphics(500,500);
    wingPattern.beginDraw();
    wingPattern.background(wingsC1);
    wingPattern.noStroke();
    
    int choose = int(random(0,11));
    
    if(choose<1){
      int tmp;
      int diff = int(random(30,200));
      
      for(int r = 700; r>30; r-=diff){
        wingPattern.fill(wingsC1);
        wingPattern.ellipse(wingM.x,wingM.y,r,r);
        tmp = wingsC1;
        wingsC1 = wingsC2;
        wingsC2 = tmp;
      }
      attributes.add("ringed");
    }else if(choose<2){
      wingPattern.fill(wingsC2);
      int r = int(random(5,40));
      int nbr = int(random(100,500));
      for(int i = 0; i<nbr; i++){
        wingPattern.ellipse(int(random(0,500)),int(random(0,500)),r,r);
      }
      attributes.add("dotted");
    }else{
      wingPattern.pushMatrix();
      wingPattern.translate(0,-500);
      wingPattern.rotate(radians(int(random(0,60))));
      wingPattern.stroke(wingsC2);
      int weight = int(random(10,60));
      wingPattern.strokeWeight(weight);
      wingPattern.noFill();
      int lineHandle = int(random(0,100));
      int distx = int(random(50,125));
      int disty = int(random(weight,125));
      int h1 = int(random(0,125));
      int h2 = int(random(0,125));
  
      for(int i = 0; i<1000; i+=disty){
        for(int j = 0; j<1000; j+=distx*2){
          wingPattern.bezier(j,h1+i,j+lineHandle,h1+i,j+distx-lineHandle,h2+i,j+distx,h2+i);
          wingPattern.bezier(j+distx,h2+i,j+distx+lineHandle,h2+i,j+(distx*2)-lineHandle,h1+i,j+(distx*2),h1+i);
        }
      }
     
      wingPattern.popMatrix();
      attributes.add("striped");
    }
    wingPattern.endDraw();
  }
  
  
  public void drawAntenna(){
    int end = int(random(0,3));
    int secondPart = int(random(0,2));
    int param = int(random(3,6));
    int len = int(random(8,17));
  
    canvas.bezier(head.x-(headV/4), head.y, head.x-(headV/4), head.y-30, antennaL1.x+antennaHandle, antennaL1.y, antennaL1.x, antennaL1.y);
    canvas.bezier(head.x+(headV/4), head.y, head.x+(headV/4), head.y-30, antennaR1.x-antennaHandle, antennaR1.y, antennaR1.x, antennaR1.y);
    if(secondPart>=1){
      canvas.bezier(antennaL1.x, antennaL1.y, antennaL1.x-antennaHandle, antennaL1.y, antennaL2.x, antennaL2.y, antennaL2.x, antennaL2.y);
      canvas.bezier(antennaR1.x, antennaR1.y, antennaR1.x+antennaHandle, antennaR1.y, antennaR2.x, antennaR2.y, antennaR2.x, antennaR2.y);
      
      switch(end){
        case 1:
          canvas.ellipse(antennaR2.x,antennaR2.y,param*2,param*2);
          canvas.ellipse(antennaL2.x,antennaL2.y,param*2,param*2);
          break;
        case 2:
          for(int i = 1; i<=param; i++){
            float x = bezierPoint(antennaR1.x, antennaR1.x+antennaHandle, antennaR2.x, antennaR2.x, 1-(i*0.05f));
            float y = bezierPoint(antennaR1.y, antennaR1.y, antennaR2.y, antennaR2.y, 1-(i*0.05f));
            float tx = bezierTangent(antennaR1.x, antennaR1.x+antennaHandle, antennaR2.x, antennaR2.x, 1-(i*0.05f));
            float ty = bezierTangent(antennaR1.y, antennaR1.y, antennaR2.y, antennaR2.y, 1-(i*0.05f));
            float a = atan2(ty, tx);
            a -= HALF_PI;
            canvas.line(x, y, cos(a)*len + x, sin(a)*len + y);
            
            
            
            x = bezierPoint(antennaL1.x, antennaL1.x-antennaHandle, antennaL2.x, antennaL2.x, 1-(i*0.05f));
            y = bezierPoint(antennaL1.y, antennaL1.y, antennaL2.y, antennaL2.y, 1-(i*0.05f));
            tx = bezierTangent(antennaL1.x, antennaL1.x-antennaHandle, antennaL2.x, antennaL2.x, 1-(i*0.05f));
            ty = bezierTangent(antennaL1.y, antennaL1.y, antennaL2.y, antennaL2.y, 1-(i*0.05f));
            a = atan2(ty, tx);
            a -= HALF_PI;
            canvas.line(x, y, -cos(a)*len + x, -sin(a)*len + y);
          }
          break;
      }
    }else{
      switch(end){
        case 1:
          canvas.ellipse(antennaR1.x,antennaR1.y,param,param);
          canvas.ellipse(antennaL1.x,antennaL1.y,param,param);
          break;
        case 2:
          for(int i = 1; i<=param; i++){
            float x = bezierPoint(head.x+(headV/4), head.x+(headV/4), antennaR1.x-antennaHandle, antennaR1.x, 1-(i*0.05f));
            float y = bezierPoint(head.y, head.y-30, antennaR1.y, antennaR1.y, 1-(i*0.05f));
            float tx = bezierTangent(head.x+(headV/4), head.x+(headV/4), antennaR1.x-antennaHandle, antennaR1.x, 1-(i*0.05f));
            float ty = bezierTangent(head.y, head.y-30, antennaR1.y, antennaR1.y, 1-(i*0.05f));
            float a = atan2(ty, tx);
            a -= HALF_PI;
            canvas.line(x, y, cos(a)*len + x, sin(a)*len + y);
            
            x = bezierPoint(head.x-(headV/4), head.x-(headV/4), antennaL1.x+antennaHandle, antennaL1.x, 1-(i*0.05f));
            y = bezierPoint(head.y, head.y-30, antennaL1.y, antennaL1.y, 1-(i*0.05f));
            tx = bezierTangent(head.x-(headV/4), head.x-(headV/4), antennaL1.x+antennaHandle, antennaL1.x, 1-(i*0.05f));
            ty = bezierTangent(head.y, head.y-30, antennaL1.y, antennaL1.y, 1-(i*0.05f));
            a = atan2(ty, tx);
            a -= HALF_PI;
            canvas.line(x, y, -cos(a)*len + x, -sin(a)*len + y);
            attributes.add("bristle feeler");
          }
          break;
      }
    }
  }
  
  public void drawHead(){
    canvas.ellipse(head.x,head.y,headV,headH);
  }
  
  public void drawBody(){
    canvas.beginShape();
    canvas.vertex(neck.x, neck.y);
    canvas.bezierVertex(neck.x+neckHandle, neck.y, shoulderR.x,shoulderR.y , shoulderR.x, shoulderR.y);
    canvas.bezierVertex(shoulderR.x,shoulderR.y , bottom.x+bottomHandle,bottom.y, bottom.x, bottom.y);
    canvas.bezierVertex(bottom.x-bottomHandle,bottom.y , shoulderL.x, shoulderL.y, shoulderL.x, shoulderL.y);
    canvas.bezierVertex(shoulderL.x,shoulderL.y,neck.x-neckHandle, neck.y, neck.x, neck.y);
    canvas.endShape();
  }
  
  public PImage getReversePImage( PImage image ) {
   PImage reverse = new PImage( image.width, image.height );
   for( int i=0; i < image.width; i++ ){
    for(int j=0; j < image.height; j++){
     reverse.set( image.width - 1 - i, j, image.get(i, j) );
    }
   }
  return reverse;
  }
  
  public void drawWing(){
    if(colored){
      drawPattern();
      
      wingMaskL = createGraphics(500,500);
      wingMaskL.beginDraw();
      wingMaskL.beginShape();
      wingMaskL.vertex(shoulderL.x, shoulderL.y);
      wingMaskL.bezierVertex(shoulderL.x, shoulderL.y, wingM.x-wingHandleM,wingM.y , wingM.x, wingM.y);
      wingMaskL.bezierVertex(wingM.x, wingM.y+wingHandleDown, wingL.x+wingHandlePoint, wingL.y, wingL.x, wingL.y);
      wingMaskL.bezierVertex(wingL.x-wingHandlePoint, wingL.y, shoulderL.x-wingHandleShoulder, shoulderL.y+wingHandleShoulder,shoulderL.x, shoulderL.y);
      wingMaskL.endShape();
      wingMaskL.endDraw();
      
      PImage pattern = wingPattern.get();
      PImage mask = wingMaskL.get();
      pattern.mask(mask);
      canvas.image(pattern,0,0);
      
      wingMaskR = createGraphics(500,500);
      wingMaskR.beginDraw();
      wingMaskR.beginShape();
      wingMaskR.vertex(shoulderR.x, shoulderR.y);
      wingMaskR.bezierVertex(shoulderR.x, shoulderR.y, wingM.x+wingHandleM,wingM.y , wingM.x, wingM.y);
      wingMaskR.bezierVertex(wingM.x, wingM.y+wingHandleDown, wingR.x-wingHandlePoint, wingR.y, wingR.x, wingR.y);
      wingMaskR.bezierVertex(wingR.x+wingHandlePoint, wingR.y, shoulderR.x+wingHandleShoulder, shoulderR.y+wingHandleShoulder,shoulderR.x, shoulderR.y);
      wingMaskR.endShape();
      wingMaskR.endDraw();
      
      pattern = getReversePImage(pattern);
      mask = wingMaskR.get();
      pattern.mask(mask);
      canvas.image(pattern,0,0);
      
      canvas.noFill();
    }
    
    
    canvas.beginShape();
    canvas.vertex(shoulderL.x, shoulderL.y);
    canvas.bezierVertex(shoulderL.x, shoulderL.y, wingM.x-wingHandleM,wingM.y , wingM.x, wingM.y);
    canvas.bezierVertex(wingM.x, wingM.y+wingHandleDown, wingL.x+wingHandlePoint, wingL.y, wingL.x, wingL.y);
    canvas.bezierVertex(wingL.x-wingHandlePoint, wingL.y, shoulderL.x-wingHandleShoulder, shoulderL.y+wingHandleShoulder,shoulderL.x, shoulderL.y);
    canvas.endShape();
    
    canvas.beginShape();
    canvas.vertex(shoulderR.x, shoulderR.y);
    canvas.bezierVertex(shoulderR.x, shoulderR.y, wingM.x+wingHandleM,wingM.y , wingM.x, wingM.y);
    canvas.bezierVertex(wingM.x, wingM.y+wingHandleDown, wingR.x-wingHandlePoint, wingR.y, wingR.x, wingR.y);
    canvas.bezierVertex(wingR.x+wingHandlePoint, wingR.y, shoulderR.x+wingHandleShoulder, shoulderR.y+wingHandleShoulder,shoulderR.x, shoulderR.y);
    canvas.endShape();
  }
  
  public void drawLegs(){
    canvas.pushMatrix();
    canvas.translate(legC1.x,legC1.y);
    canvas.rotate(radians(legAngleC1));
    canvas.rect(0,0,legLength, legThickness);
    
    canvas.translate(legLength,0);
    canvas.rotate(radians(legAngle2C1));
    canvas.rect(0,0,legLength/2, legThickness);
    
    canvas.translate(legLength/2,legThickness/2);
    canvas.rotate(radians(legAngle3C1));
    for(int i = 0; i<nbrFeet; i++){
      canvas.triangle(0,0,10, legThickness/2, 10, -legThickness/2);
      canvas.translate(10,0);
    }
    canvas.line(0,0, 10, -legThickness/3);
    canvas.line(0,0, 10, legThickness/3);
    canvas.popMatrix();
    
    canvas.pushMatrix();
    canvas.translate(legC1.x,legC1.y);
    canvas.rotate(radians(-legAngleC1));
    canvas.rect(0,0,-legLength, legThickness);
    
    canvas.translate(-legLength,0);
    canvas.rotate(radians(-legAngle2C1));
    canvas.rect(0,0,-legLength/2, legThickness);
    
    canvas.translate(-legLength/2,legThickness/2);
    canvas.rotate(radians(-legAngle3C1));
    for(int i = 0; i<nbrFeet; i++){
      canvas.triangle(0,0,-10, legThickness/2, -10, -legThickness/2);
      canvas.translate(-10,0);
    }
    canvas.line(0,0, -10, -legThickness/3);
    canvas.line(0,0, -10, legThickness/3);
    canvas.popMatrix();
    
    //////////
    canvas.pushMatrix();
    canvas.translate(legC2.x,legC2.y);
    canvas.rotate(radians(legAngleC2));
    canvas.rect(0,0,legLength, legThickness);
    
    canvas.translate(legLength,0);
    canvas.rotate(radians(legAngle2C2));
    canvas.rect(0,0,legLength/2, legThickness);
    
    canvas.translate(legLength/2,legThickness/2);
    canvas.rotate(radians(legAngle3C2));
    for(int i = 0; i<nbrFeet; i++){
      canvas.triangle(0,0,10, legThickness/2, 10, -legThickness/2);
      canvas.translate(10,0);
    }
    canvas.line(0,0, 10, -legThickness/3);
    canvas.line(0,0, 10, legThickness/3);
    canvas.popMatrix();
    
    canvas.pushMatrix();
    canvas.translate(legC2.x,legC2.y);
    canvas.rotate(radians(-legAngleC2));
    canvas.rect(0,0,-legLength, legThickness);
    
    canvas.translate(-legLength,0);
    canvas.rotate(radians(-legAngle2C2));
    canvas.rect(0,0,-legLength/2, legThickness);
    
    canvas.translate(-legLength/2,legThickness/2);
    canvas.rotate(radians(-legAngle3C2));
    for(int i = 0; i<nbrFeet; i++){
      canvas.triangle(0,0,-10, legThickness/2, -10, -legThickness/2);
      canvas.translate(-10,0);
    }
    canvas.line(0,0, -10, -legThickness/3);
    canvas.line(0,0, -10, legThickness/3);
    canvas.popMatrix();
    
    //////////
    
    canvas.pushMatrix();
    canvas.translate(legC3.x,legC3.y);
    canvas.rotate(radians(legAngleC3));
    canvas.rect(0,0,legLength, legThickness);
    
    canvas.translate(legLength,0);
    canvas.rotate(radians(legAngle2C3));
    canvas.rect(0,0,legLength/2, legThickness);
    
    canvas.translate(legLength/2,legThickness/2);
    canvas.rotate(radians(legAngle3C3));
    for(int i = 0; i<nbrFeet; i++){
      canvas.triangle(0,0,10, legThickness/2, 10, -legThickness/2);
      canvas.translate(10,0);
    }
    canvas.line(0,0, 10, -legThickness/3);
    canvas.line(0,0, 10, legThickness/3);
    canvas.popMatrix();
    
    canvas.pushMatrix();
    canvas.translate(legC3.x,legC3.y);
    canvas.rotate(radians(-legAngleC3));
    canvas.rect(0,0,-legLength, legThickness);
    
    canvas.translate(-legLength,0);
    canvas.rotate(radians(-legAngle2C3));
    canvas.rect(0,0,-legLength/2, legThickness);
    
    canvas.translate(-legLength/2,legThickness/2);
    canvas.rotate(radians(-legAngle3C3));
    for(int i = 0; i<nbrFeet; i++){
      canvas.triangle(0,0,-10, legThickness/2, -10, -legThickness/2);
      canvas.translate(-10,0);
    }
    canvas.line(0,0, -10, -legThickness/3);
    canvas.line(0,0, -10, legThickness/3);
    canvas.popMatrix();
  }
  
  public String getColorName(int c){
    if(c<20)
      return "red";
    else if(c<42)
      return "orange";
    else if(c<74)
      return "yellow";
    else if(c<155)
      return "green";
    else if(c<175)
      return "turquoise";
    else if(c<262)
      return "blue";
    else if(c<286)
      return "violet";
    else if(c<334)
      return "pink";
    return "red";
  }
}