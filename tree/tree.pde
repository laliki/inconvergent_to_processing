/*
This is a Processing version of the p5.js code tree.js.

tree.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

int maxSteps = 850;
ArrayList<Branch> branches;

//------------------------------------------------------
void setup() {
  size(800, 800);

  float angle = -HALF_PI;
  branches = new ArrayList<Branch>();
  branches.add(
    new Branch(new PVector(width/2, height-50), angle));
}

//------------------------------------------------------
void draw() {
  background(255);
  animate();
  for (Branch b : branches) {
    b.display();
  }
}

//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
void animate() {
  ArrayList<Branch> newBranches = new ArrayList<Branch>();

  for (Branch b : branches) {
    if (b.steps < maxSteps) {
      float a = random(-1, 1)*(1-b.lastWidth())*0.1;
      float newAngle = b.lastAngle()+a; 

      b.angle.add(newAngle);
      PVector na = PVector.fromAngle(newAngle);
      b.pos.add(b.lastPos().copy().add(na));
      b.w.add(max(0, b.lastWidth()*0.997));
      b.steps++;

      newBranches.add(b);

      if (random(1)<(1-b.lastWidth())*0.01) {
        newBranches.add(new Branch(b.lastPos().copy(), 
          b.lastAngle(), 
          b.steps, 
          b.lastWidth()*0.72)
          );
      }
    }
  }
  branches = newBranches;
}
