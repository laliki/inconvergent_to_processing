/*
This is a Processing version of the p5.js code function-intro.js.

function-intro.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at 
https://github.com/inconvergent/inconvergent-sandbox
*/

int n = 10;
int margin = 100;
PVector[] circles = new PVector[n];

void setup() {
  size(1000, 1000);
  strokeWeight(2);
  noFill();

  for (int i=0; i<n; i++) {
    float x = margin + (width-2*margin)*i/(n-1);
    circles[i] = new PVector(x, height/2);
  }
}

void draw() {
  background(255);

  for (int i=0; i<n; i++) {
    ellipse(circles[i].x, circles[i].y, 10, 10);
    PVector a = PVector.fromAngle(random(TWO_PI));
    float r = 3*sqrt(random(1));
    circles[i].add(a.mult(r));
  }
}
