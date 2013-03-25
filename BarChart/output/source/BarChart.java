import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BarChart extends PApplet {

float t;
int numBars;

public void setup() {
  size(1000, 400);
  
  noiseSeed(second() + minute() + hour());
  t = 0;
  numBars = 50;

  noStroke();
}

public void draw() {
  background(0);

  for (int i=0; i<numBars; i++) {
    float barWidth = width / numBars;
    float barHeight = noise(i, t) * height;

    fill((mouseX > i*barWidth && mouseX < (i+1)*barWidth) ? 255 : 80);
    rect(i*barWidth, height-barHeight, barWidth-1, barHeight);
  }
 
  t += 0.001f;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BarChart" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
