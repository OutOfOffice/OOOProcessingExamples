PFont font;
float noiseT;
float previousX;

void setup() {
  size(1000, 400);
  font = loadFont("RosewoodStd-Regular-200.vlw");
  textFont(font);
  
  //// 
  noiseSeed(hour() + minute() + second());
  randomSeed(hour() + minute() + second());
  noiseT = random(1000);
  previousX = -1;
}

void displayDigitalClock() {
  pushMatrix();
  pushStyle();

  int s = second();
  int m = minute();
  int h = hour();

  // The nf() function spaces the numbers nicely
  String t = nf(h,2) + ":" + nf(m,2) + ":" + nf(s,2);
  text(t, 10, 200);

  popStyle();
  popMatrix();
}

void displayAnalogClock() {
  pushMatrix();
  pushStyle();

  float diameter = 150;
  ellipseMode(CENTER);
  translate(850, 150);

  fill(80);
  noStroke();
  ellipse(0, 0, diameter, diameter);
  
  stroke(255);
  float s = map(second(),    0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute(),    0, 60, 0, TWO_PI) - HALF_PI;
  float h = map(hour() % 12, 0, 12, 0, TWO_PI) - HALF_PI;
  
  float handLength = diameter * 0.49;
  line(0, 0, cos(s) * handLength, sin(s) * handLength);
  handLength = diameter * 0.45;
  line(0, 0, cos(m) * handLength, sin(m) * handLength);
  handLength = diameter * 0.30;
  line(0, 0, cos(h) * handLength, sin(h) * handLength);
  
  popStyle();
  popMatrix();
}

void displayBandedClock() {
  pushMatrix();
  pushStyle();
  
  float s = map(second(), 0, 60, 0, width);
  float m = map(minute(), 0, 60, 0, width);
  float h = map(hour(),   0, 24, 0, width);

  stroke(255);
  line(s, 0,          s, height/3);
  line(m, height/3,   m, height*2/3);
  line(h, height*2/3, h, height);

  popStyle();
  popMatrix();
}

void displayNoisyDot() {
  pushMatrix();
  pushStyle();
  
  float s = map(second(), 0, 60, 0, width);
  float nx = noise(noiseT);
  float ny = noise(noiseT + 1000);
  noiseT += 0.01;
  
  float margin = 100;
  float offsetX = margin * nx - margin/2;
  float y = 50 + margin * ny - margin/2;

  if (previousX == -1) {
    previousX = s+offsetX;
  }
  float x = lerp(previousX, s+offsetX, 0.1);
  previousX = x;

  fill(255, 0, 0);
  ellipse(x, y, 10, 10);

  popStyle();
  popMatrix();  
}

void draw() {
  background(0);

  //// DRAW SIMPLE DIGITAL CLOCK ////
  displayDigitalClock();

  //// DRAW SIMPLE ANALOG CLOCK ////
  displayAnalogClock();
  
  //// DRAW BANDED CLOCK ////
  displayBandedClock();

  //// DRAW LERPY DOT ////
  displayNoisyDot();
}
