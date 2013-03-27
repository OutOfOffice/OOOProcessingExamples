import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import geomerative.*; 
import geomerative.*; 
import geomerative.*; 
import geomerative.*; 
import geomerative.*; 
import geomerative.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class countdown extends PApplet {

/*
///////////////////////////////////////////////
 --------- GEOMERATIVE EXAMPLES ---------------
 //////////////////////////////////////////////
 Title   :   TypoGEo_Motion_01
 Date    :   01/03/2011 
 Version :   v0.5
 Finally making some movement. Press key 'f' to
 freeze the motion.
 
 Licensed under GNU General Public License (GPL) version 3.
 http://www.gnu.org/licenses/gpl.html
 
 A series of tutorials for using the Geomerative Library
 developed by Ricard Marxer. 
 http://www.ricardmarxer.com/geomerative/
 
 More info on these tutorial and workshops at :
 www.freeartbureau.org/blog
 
 */
//////////////////////////////////////////////



RFont font;
boolean stopAnime = false;
int DIGIT_MAX = 4;
int currentDigit;
ArrayList digits = new ArrayList(DIGIT_MAX);

//----------------SETUP---------------------------------
public void setup() {
  size(1200, 800);
  background(0);
  smooth();
  RG.init(this); 
  font = new RFont("FreeSans.ttf", 200, CENTER);
  currentDigit = DIGIT_MAX-1;
  String digit;

  for (int i=0; i<DIGIT_MAX; i++) {
    digit = String.valueOf(i);
    if (i == 0) {
      digits.add(new AgentText(digit, font));
    } else if (i == 1) {
      digits.add(new MotionText(digit, font));
    } else if (i == 2) {
      digits.add(new JitterText(digit, font));
    } else if (i == 3) {
      digits.add(new SmoothJitterText(digit, font));
    }
  }
}

//----------------DRAW---------------------------------
public void draw() {
  if (currentDigit < 0) return;

  GenericText gText = (GenericText)digits.get(currentDigit);
  if (gText.doneAnimating()) {
    currentDigit -= 1;
    if (currentDigit < 0) {
      return;
    } else {
      gText = (GenericText)digits.get(currentDigit);
    }
  }

  gText.update();
  gText.display();
}



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

  public void update() {
    super.update();
    if (frameNum == 60*5) doneAnimating = true;
  }

  public void display() {
    fill(0, 23);
    rect(0, 0, width, height);
    translate(350, 205);
    for (int i = 0; i < myPoints.length; i++) {
      myAgents[i].display();
      myAgents[i].motion();
    }
  }
}
class FontAgent {

  PVector loc;
  //PVector acc;
  float dia = 1.5f;
  float xMove;
  float theta;
  float lifespan = 255;

  FontAgent(PVector l) {
    loc = l.get();
    // acc = new PVector (0, 0.1);
  }

  public void motion() {
    xMove += random (-6, 6);
    theta = radians(xMove);
    loc.x += cos(theta);
    lifespan -= 0.29f;
  }  

  public void display() {
    noStroke();
    fill(lifespan);

    ellipse(loc.x, loc.y, dia, dia);
  }
}



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

  public void update() {
    frameNum++;
  }

  public void display() {
  }

  public boolean doneAnimating() {
    return doneAnimating;
  }
}


class JitterText extends GenericText {
  
  JitterText(String t, RFont f) {
    super(t, f);

    RCommand.setSegmentLength(20);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
    myGroup = font.toGroup(text);
    myGroup = myGroup.toPolygonGroup();
    myPoints = myGroup.getPoints();
  }

  public void update() {
    super.update();
    if (frameNum == 60*5) {
      doneAnimating = true;
    } else if (frameNum % 20 == 0) {
      randomSeed((int)random(1000));
    }
  }

  public void display() {
    background(0);
    stroke(255);
    strokeWeight(0.3f);
    translate(width/2, 300);
    
    beginShape();

    for (int i=0; i<myPoints.length; i++) {
      float jitter = random(0, 50);
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

  public void update() {
    super.update();
    if (n > 200) {
      n*=-1;
    } else if (n == -1) {
      doneAnimating = true;
    } else {
      n++;
    }
  }

  public void display() {
    background(0);
    stroke(255, 150);
    strokeWeight(0.3f);
    translate(550, 270);

    for (int i=0; i<myPoints.length; i++) {
      ellipse(myPoints[i].x, myPoints[i].y, n, 0);// TRY ADDING N TO BOTH DIA VALUES.
    }
  }
}


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

  public void update() {
    super.update();
    if (frameNum == 60*5) {
      doneAnimating = true;
    } else {
      noiseTimer += 0.03f;
    }
  }

  public void display() {
    background(0);
    stroke(255);
    strokeWeight(0.3f);
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "countdown" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
