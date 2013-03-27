import geomerative.*;

class AgentText extends GenericText {
  
  FontAgent[] myAgents;

  AgentText(String t, RFont f) {
    super(t, f);

    RCommand.setSegmentLength(1);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
    myGroup = font.toGroup(text);
    myPoints = myGroup.getPoints();

    myAgents = new FontAgent[myPoints.length];
    for (int i=0; i<myPoints.length; i++) {
      myAgents[i] = new FontAgent(new PVector(myPoints[i].x, myPoints[i].y));
    }
  }

  void update() {
    super.update();
    if (frameNum == 60*5) doneAnimating = true;
  }

  void display() {
    fill(0, 23);
    rect(0, 0, width, height);
//    translate(350, 205);
    translate(270, 165);
    for (int i = 0; i < myPoints.length; i++) {
      myAgents[i].display();
      myAgents[i].motion();
    }
  }
}
