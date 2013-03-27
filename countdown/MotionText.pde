import geomerative.*;

class MotionText extends GenericText {
  
  int n;

  MotionText(String t, RFont f) {
    super(t, f);
    n = 0;

    RCommand.setSegmentLength(10);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
    myGroup = font.toGroup(text);
    myPoints = myGroup.getPoints();
  }

  void update() {
    super.update();
    if (n > 200) {
      n*=-1;
    } else if (n == -1) {
      doneAnimating = true;
    } else {
      n++;
    }
  }

  void display() {
    background(0);
    stroke(255, 150);
    strokeWeight(0.3);
    translate(550, 270);

    for (int i=0; i<myPoints.length; i++) {
      ellipse(myPoints[i].x, myPoints[i].y, n, 0);// TRY ADDING N TO BOTH DIA VALUES.
    }
  }
}
