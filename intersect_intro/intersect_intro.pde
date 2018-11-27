/*
This is a Processing version of the p5.js code intersect-intro.js.
It uses some functions from utils.js.

intersect-intro.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

color black = color(0, 0, 0, 200);
color red = color(255, 0, 0, 200);
color blue = color(0, 0, 255, 200);
color cyan = color(0, 255, 255, 75);
color gray = color(0, 0, 0, 75);
color green = color(0, 255, 0, 200);
color white = color(255, 255, 255);


//------------------------------------------------------
void setup() {
  size(1000, 1000);
  strokeWeight(4);
  noFill();
}

//------------------------------------------------------
void draw() {
  background(255);
  noFill();

  PVector a0 = new PVector(500, 100);
  PVector a1 = new PVector(700, 800);
  PVector b0 = new PVector(250, 300);
  PVector b1 = new PVector(mouseX, mouseY);

  PVector sa = a1.copy().sub(a0);
  PVector sb = b1.copy().sub(b0);
  float u = cross(sa, sb);

  if (abs(u)<=0) {
    return;
  }

  PVector ba = a0.copy().sub(b0);
  float q = cross(sa, ba)/u;
  float p = cross(sb, ba)/u;

  strokeWeight(15);
  stroke((q>0 && q<1) ? blue: red);
  line(a0.x, a0.y, a1.x, a1.y);

  stroke((p>0 && p<1) ? blue: red);
  line(b0.x, b0.y, b1.x, b1.y);

  noStroke();
  showPgram(a0, sa, ba, red);
  showPgram(b0, sb, ba, green);
  showPgram(a0, sa, sb, gray);

  if (p >= 0 && p <= 1 && q >= 0 && q <= 1) {
    PVector v = a0.copy().lerp(a1, p);
    fill(black);
    ellipse(v.x, v.y, 60, 60);
  }
}

//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
void showPgram(PVector start, PVector a, PVector b, color f) {
  noStroke();
  fill(f);
  quad(
    start.x, start.y, 
    start.copy().add(a).x, start.copy().add(a).y, 
    start.copy().add(a).add(b).x, start.copy().add(a).add(b).y, 
    start.copy().add(b).x, start.copy().add(b).y 
    );

  noFill();
  if (cross(a, b)<0) {
    fill(black);
  }
  PVector v = start.copy().add(a.copy().mult(0.5).add(b.copy().mult(0.5)));
  ellipse(v.x, v.y, 10, 10);
  noFill();
}

//------------------------------------------------------
// from utils.js
//
float cross(PVector A, PVector B) {
  return A.x*B.y-B.x*A.y;
}
