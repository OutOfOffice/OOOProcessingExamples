import geomerative.*;

class CurvyText { 
  RFont font;
  
  String text;
  boolean startAnimating;
  float LARGE_SEGMENT = 100.0;
  float MIN_LARGE_SEGMENT = 90.0;
  float MAX_LARGE_SEGMENT = 200.0;
  float segment;
  float startingLargeSegment;
  float NOISE_STEP = 0.004;  // 0.005-0.03 work well for most sketches
  float noiseTimer;
  int ANIMATION_DURATION = 8000;
  PVector startLocation;
  PVector targetLocation;
  PVector currentLocation;
  
  CurvyText (String t, RFont f, PVector start, PVector target) {  
    text = t;
    font = f; 
    startLocation = start.get();
    currentLocation = start.get();
    targetLocation = target.get();
  
    startAnimating = false;
    noiseTimer = random(100);
    wanderSegment();
  } 
  
  void startAnimating() {
    startAnimating = true;
    startingLargeSegment = segment;
    timer = millis();
  }
  
  void wanderSegment() {
    float n = noise(noiseTimer);
    segment = map(n, 0.0, 1.0, MIN_LARGE_SEGMENT, MAX_LARGE_SEGMENT);
    noiseTimer += NOISE_STEP;
  }
  
  void update() { 
    if (startAnimating) {
      int elapsed = millis()-timer;
      if (elapsed <= ANIMATION_DURATION) {
        segment = map(elapsed, 0, ANIMATION_DURATION, startingLargeSegment, 3);
        currentLocation.x = map(elapsed, 0, ANIMATION_DURATION, startLocation.x, targetLocation.x);
        currentLocation.y = map(elapsed, 0, ANIMATION_DURATION, startLocation.y, targetLocation.y);
      }
    } else {
      wanderSegment();
    }
  
    RCommand.setSegmentLength(segment);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH); 
  }
  
  void display() {
    if (text.length() > 0) {
      pushMatrix();
      translate(currentLocation.x, currentLocation.y);
      
      RGroup myGroup = font.toGroup(text); 
      myGroup = myGroup.toPolygonGroup();
      RPoint[] myPoints = myGroup.getPoints();
  
      beginShape();
      for(int i=0; i<myPoints.length; i++) {
        //vertex(myPoints[i].x, myPoints[i].y); 
        curveVertex(myPoints[i].x, myPoints[i].y);
      }
      endShape();
      popMatrix();
    }
  }
} 
