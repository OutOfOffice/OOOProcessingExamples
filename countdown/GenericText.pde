import geomerative.*;

class GenericText {
  
  RGroup myGroup;
  RPoint[] myPoints;

  String text;
  RFont font;
  boolean doneAnimating;
  int frameNum;

  GenericText(String t, RFont f) {
    text = t;
    font = f;

    doneAnimating = false;
    frameNum = 0;

    RCommand.setSegmentLength(10);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
    myGroup = font.toGroup(text);
    myPoints = myGroup.getPoints();
  }

  void update() {
    frameNum++;
  }

  void display() {
  }

  boolean doneAnimating() {
    return doneAnimating;
  }
}
