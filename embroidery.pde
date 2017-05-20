/*

 This program was written by Michal Huller
 started on on 10 Apr 2014
 Grid to draw dark areas only as preparation for Embroidery
 Algorithm.
 Amended on 27/11/2016
 */

import processing.opengl.*;

boolean wStroke = true;
boolean haltIt = false;
boolean wNeg = false;
boolean wBright = true;
boolean wDot = false;
int myAlpha = 0; 

float wild = 1.2; // 1.7

float thresh = 1; //0.958;
int rows, cols;
float stitchW = 8, stitchH = 8; //15
float stringWidth = (stitchW + stitchH)/3; //1.5;

color backCol = #f3f0d0;
//color backCol = #05f5f5;
//color backCol = 220;
//
boolean firstTime = true;

cell[][] stitch;

PImage orig;

void setup() {

  colorMode(RGB);
  orig = loadImage("RainbowBirds.jpg");
  //size(orig.width, orig.height);
  size(1200, 1141);
  cols = int(width/stitchW) + 4;
  rows = int(height/stitchH) + 4;

  smooth();
  noLoop();
  initialize();
}

//********************* draw *******************
void draw() {
  background(backCol);
  if (!haltIt) {

    for (int i=0; i < rows; i++) {
      for (int j=0; j < cols; j++) {
        if (!(i == 0 || j == 0 || i == rows-1 || j== cols-1)) {
          stitch[i][j].drawCell(stitch[max(0,i-1)][j].isBlack 
          && stitch[max(0,i-1)][max(0,j-1)].isBlack
          && stitch[i][max(0,j-1)].isBlack
          && stitch[min(rows-1,i+1)][j].isBlack
          && stitch[i][min(cols-1,j)].isBlack);
        }
      }
    }
  }
}

////////////////////// init /////////////////////////
void initialize() {


  if (firstTime) {
    firstTime = false;

    stitch = new cell[rows][cols];
    PVector pos2 = new PVector(0, 0);

    for (int i=0; i < rows; i++) {
      for (int j=0; j < cols; j++) {

        pos2.x = (j - 1) * stitchW*1.6 + random(0, wild*1.6);
        pos2.y = (i - 1) * stitchH*1.6 + random(0, wild*1.6);
        stitch[i][j] = new cell(i, pos2.x, pos2.y, 
          floor(random(4)) );
        
        color clr = orig.get(int(pos2.x), int(pos2.y));
        if (thresh == 1.0) 
          stitch[i][j].setBlack();
        //else if (red(clr)/256 < thresh && green(clr)/256 < thresh && blue(clr)/256 < thresh) 
        else if ((red(clr)/256 + green(clr)/256 + blue(clr)/256)/3 < thresh) 
          stitch[i][j].setBlack();
      }
    }
  }
}

void keyPressed() {
  if (key == 'n' || key == 'N') {
    initialize();
    redraw();
  }
  if (key == 'h' || key == 'H') {
    haltIt = !haltIt;
  }

  if (key == 'd' || key == 'D') {
    wDot = !wDot;
    initialize();
    redraw();
  }

  if (key == 'l' || key == 'L') {
    wBright = !wBright;
    initialize();
    redraw();
  }

  if (key == 'p' || key == 'P' || key == 's' || key == 'S') {
    saveFrame("snapshots/pic_"+ year() + month() + day() + int(random(4000, 10000)) + ".png");
  }
}