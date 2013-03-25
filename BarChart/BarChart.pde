float t;
int numBars;

void setup() {
  size(1000, 400);
  
  noiseSeed(second() + minute() + hour());
  t = 0;
  numBars = 50;

  noStroke();
}

void draw() {
  background(0);

  for (int i=0; i<numBars; i++) {
    float barWidth = width / numBars;
    float barHeight = noise(i, t) * height;

    fill((mouseX > i*barWidth && mouseX < (i+1)*barWidth) ? 255 : 80);
    rect(i*barWidth, height-barHeight, barWidth-1, barHeight);
  }
 
  t += 0.001;
}
