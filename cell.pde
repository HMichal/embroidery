public class cell {

  int tavIx;  // for future use for SVG model
  // Position
  PVector pos;

  // Caracteristics
  float scaleTo;
  float accumScale;
  float stwt;

  // ID
  int id;

  PVector noise;

  // black or white?
  Boolean isBlack;
  Boolean isAlone;

  // Constructor
  public cell(int ident, float x, float y, 
    int ix) {
    pos = new PVector(x, y);
    tavIx = ix;
    id = ident;
    scaleTo = 1;
    accumScale = 1;
    isBlack = false;
    isAlone = true;
    stwt = random(stringWidth, stringWidth + wild);
  }

  public void setBlack() {
    isBlack = true;
  }
  //////////////////////////// DRAW //////////////////////
  public void drawCell(boolean dSqr) {
    color clr;
    float darker = 0.75;
    float wFac = 1.3;

    clr = orig.get(int(pos.x), int(pos.y));
    if (myAlpha > 0) stroke(clr, myAlpha);
    else stroke(clr);
    strokeWeight(stwt);

    if (wDot) {
      pushStyle();
      strokeWeight(stwt*wFac/2);
      colorMode(HSB);
      if (myAlpha > 0)
        stroke(hue(clr), saturation(clr)*darker, brightness(clr)*darker, myAlpha);
      else
        stroke(hue(clr), saturation(clr)*darker, brightness(clr)*darker);
      ellipse(pos.x, pos.y, stwt*wFac/2, stwt*wFac/2);
      popStyle();   
      ellipse(pos.x, pos.y, stwt/2, stwt/2);
    }

    if (!isBlack) return;
    if (wBright) {
      pushStyle();
      if (dSqr && (red(clr)/256 + green(clr)/256 + blue(clr)/256)/3 < 0.6) {
        noStroke();
        colorMode(HSB);
        fill(hue(clr), saturation(clr)*darker, brightness(clr)*darker*0.9);
        rect(pos.x - stitchW, pos.y - stitchH, 
          2*stitchW, 2*stitchH);
      }
      setStyle(darker, wFac, clr, 
        pos.x - stitchW/2, pos.y - stitchH/2, 
        pos.x + stitchW/2, pos.y + stitchH/2);

      popStyle();
    }
    line(pos.x - stitchW/2, pos.y - stitchH/2, 
      pos.x + stitchW/2, pos.y + stitchH/2);

    pushStyle();
    setBright(0.3, clr, 
      pos.x - stitchW/2, pos.y - stitchH/2, 
      pos.x + stitchW/2, pos.y + stitchH/2);
    popStyle();

    if (wBright) {
      pushStyle();
      setStyle(darker, wFac, clr, 
        pos.x + stitchW/2, pos.y - stitchH/2, 
        pos.x - stitchW/2, pos.y + stitchH/2);
      popStyle();
    }
    line(pos.x + stitchW/2, pos.y - stitchH/2, 
      pos.x - stitchW/2, pos.y + stitchH/2);

    pushStyle();
    setBright(0.3, clr, 
      pos.x + stitchW/2, pos.y - stitchH/2, 
      pos.x - stitchW/2, pos.y + stitchH/2);
    popStyle();
  }

  void setStyle(float darker, float wFac, color clr, 
    float x1, float y1, float x2, float y2) {
    strokeWeight(stwt*wFac);
    noFill();
    colorMode(HSB);
    if (myAlpha > 0)
      stroke(hue(clr), saturation(clr)*darker, brightness(clr)*darker, myAlpha);
    else
      stroke(hue(clr), saturation(clr)*darker, brightness(clr)*darker);
    line(x1, y1, x2, y2);
  }

  void setBright(float btr, color clr, 
    float x1, float y1, float x2, float y2) {
    strokeWeight(stwt/3);
    noFill();
    colorMode(HSB);
    if (myAlpha > 0)
      stroke(hue(clr), saturation(clr), brightness(clr)*(1+btr), myAlpha);
    else
      stroke(hue(clr), saturation(clr), brightness(clr)*(1+btr));
    line(x1, y1, x2, y2);
  }
} // end of class