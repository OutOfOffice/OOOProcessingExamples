import geomerative.*;

class SmoothJitterText extends GenericText {
  
  float noiseTimer;

  SmoothJitterText(String t, RFont f) {
    super(t, f);

    RCommand.setSegmentLength(20);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
    myGroup = font.toGroup(text);
    myGroup = myGroup.toPolygonGroup();
    myPoints = myGroup.getPoints();

    noiseTimer = random(0, 1000);
  }

  void update() {
    super.update();
    if (frameNum == 60*5) {
      doneAnimating = true;
    } else {
      noiseTimer += 0.03;
    }
  }

  void display() {
    background(0);
    stroke(255);
    strokeWeight(0.3);
    translate(width/2, 300);
    
    beginShape();

    for (int i=0; i<myPoints.length; i++) {
      float jitter = noise(noiseTimer) * 50;
      //line(myPoints[i].x, myPoints[i].y,10,10);
      vertex(myPoints[i].x, myPoints[i].y);//PLAY WITH ADDING OR SUBSTRACTING JITTER
      vertex(myPoints[i].x+jitter, myPoints[i].y+jitter);
      vertex(myPoints[i].x-jitter, myPoints[i].y-jitter);
      //line(myPoints[i].x, myPoints[i].y,30,-280);
      //line(myPoints[i].x, myPoints[i].y,20,myPoints[i].y);
      //ellipse(myPoints[i].x+10,myPoints[i].y,3,3);
    }
    endShape();
  }
}
