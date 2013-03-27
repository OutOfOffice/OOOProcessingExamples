/*
//////////////////////////////////////////////
 --------- GEOMERATIVE TUTORIALS --------------
 //////////////////////////////////////////////
 Title   :   Geo_Font_03
 Date    :   01/03/2011 
 Version :   v0.5
 We access a number of points on a font's outline.
 In this variation we draw lines from a fixed position.
 
 Licensed under GNU General Public License (GPL) version 3.
 http://www.gnu.org/licenses/gpl.html
 
 A series of tutorials for using the Geomerative Library
 developed by Ricard Marxer. 
 http://www.ricardmarxer.com/geomerative/
 
 More info on these tutorial and workshops at :
 www.freeartbureau.org/blog
 
 */
//////////////////////////////////////////////

import geomerative.*;

RFont largeFont;
RFont smallFont;

int timer = 0;
CurvyText[] welcomeMessage = new CurvyText[3];
CurvyText welcomeText;

//----------------SETUP---------------------------------
void setup() {
  size(714,264);
  background(255);
  smooth();
  RG.init(this); 
  largeFont = new RFont("FreeSans.ttf", 100, CENTER);
  smallFont = new RFont("FreeSans.ttf", 75, CENTER);
  
  int seed = int(year() + month() + day() + hour() + minute() + second());
  randomSeed(seed);
  noiseSeed(seed);
  
  PVector startLocation = new PVector(width/2, height/1.7);
  welcomeText = new CurvyText("OUT", largeFont, startLocation, 
                              PVector.add(startLocation, new PVector(0, -63)));
  welcomeMessage[0] = welcomeText;
  welcomeMessage[1] = new CurvyText("OF", smallFont, startLocation, startLocation);
  welcomeMessage[2] = new CurvyText("OFFICE", largeFont, startLocation, 
                                    PVector.add(startLocation, new PVector(0, 82)));
}

//----------------DRAW---------------------------------
void draw() {
  background(0);
//  stroke(255,0,0);
  stroke(182,40,138);
  noFill();
  frame.setTitle("...");

  for (int i=0; i<welcomeMessage.length; i++) {
    welcomeMessage[i].update();
    welcomeMessage[i].display();
  }
  
}

void startAnimating() {
  for (int i=0; i<welcomeMessage.length; i++) {
    welcomeMessage[i].startAnimating();
  }  
}

//----------------KEYS---------------------------------
//void keyReleased() {
//}

void keyPressed() {
  if(key !=CODED) {
    switch(key) {
    case DELETE:
    case BACKSPACE:
//      myText = myText.substring(0,max(0,myText.length()-1));
      break;
    case ENTER:
      break;
    case ' ':
      startAnimating();
      break;
    default:
//      myText +=key;
    }
  }
}

