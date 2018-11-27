/*
This is a Processing version of the p5.js code a working version of gravity.js.

gravity.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

int n;
Trail[] trails;
float stepSize;
int maxLength;
float radius;

// Tweak the parameters. 
// n is the number of bodies (and trails)
// maxLength is the length of the trail
// stepSize affects the motion
// other possible changes indicated in the code!

//---------------------------------------------------
void setup() {
  size(1000, 1000);
  // make n lists of trails inside radius.
  // each list contains the trail of a body as it moves. 
  // the last element is the most recent.

  n = 10;
  stepSize = 0.01; // tweak!!!
  maxLength = 100; // tweak!!!

  PVector mid = new PVector(width/2, height/2);
  radius = 300;
  trails = new Trail[n];
  for (int i=0; i<n; i++) {
    PVector a = PVector.fromAngle(random(TWO_PI));
    float r = radius*sqrt(random(1));
    a.mult(r);
    a.add(mid);
    trails[i] = new Trail(a);
  }

  frameRate(30);
}

//---------------------------------------------------
void draw() {
  background(255);
  step();

  for (int i=0; i<n; i++) {
    trails[i].display();
  }
}

//---------------------------------------------------
//---------------------------------------------------
//---------------------------------------------------
PVector getAcc(PVector a, PVector b) {
  PVector dx = b.copy().sub(a);
  float d = dx.mag();  
  if (d<0.01) { // tweak!!!
    d = 0.01;
  }

  dx.normalize();
  return dx;
}

//---------------------------------------------------
void step() {
  // most recent position of every body
  PVector[] curr = new PVector[n];
  for (int i=0; i<n; i++) {
    curr[i] = trails[i].last();
  }

  // for every pair of body, calculate the forces between them
  for (int i=0; i<n; i++) {
    PVector acc = new PVector();
    for (int j=0; j<n; j++) {
      // don't do anything since there are no forces between a body and itself
      if (i==j) {
        continue;
      }
      acc.add(getAcc(curr[i], curr[j]));
    }

    acc.add(getAcc(curr[i], new PVector(mouseX, mouseY)).mult(5)); // tweak number 5!!!

    trails[i].update(acc);
  }
}
