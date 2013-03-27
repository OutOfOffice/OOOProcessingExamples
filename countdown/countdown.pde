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

import geomerative.*;

RFont font;
boolean stopAnime = false;
int DIGIT_MAX = 4;
int currentDigit;
ArrayList digits = new ArrayList(DIGIT_MAX);

//----------------SETUP---------------------------------
void setup() {
//  size(1200, 800);
  size(714,264);
  background(0);
  smooth();
  RG.init(this); 
  font = new RFont("FreeSans.ttf", 100, CENTER);
  currentDigit = DIGIT_MAX-1;
  String digit;

//  for (int i=0; i<DIGIT_MAX; i++) {
//    digit = String.valueOf(i);
//    if (i == 0) {
//      digits.add(new AgentText(digit, font));
//    } else if (i == 1) {
//      digits.add(new MotionText(digit, font));
//    } else if (i == 2) {
//      digits.add(new JitterText(digit, font));
//    } else if (i == 3) {
//      digits.add(new SmoothJitterText(digit, font));
//    }
//  }
  currentDigit = 0; 
  digit = "Out of Office";
  digits.add(new AgentText(digit, font));
//  digits.add(new MotionText("Out of Office", font));
//  digits.add(new SmoothJitterText("Out of Office", font));
}

//----------------DRAW---------------------------------
void draw() {
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

