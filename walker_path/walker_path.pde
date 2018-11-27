/*
This is a Processing version of the p5.js code walker-path.js.
It uses some functions from utils.js.

walker-path.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/
ArrayList<PVector> path;
PVector walker;

//
//------------------------------------------------------
void setup() {
  size(1000, 1000);

  walker = new PVector(width/2, height/2);

  path = new ArrayList<PVector>();
  PVector a = PVector.fromAngle(random(TWO_PI));
  float r = 700*sqrt(random(1));
  path.add(a.mult(r).add(walker));

  frameRate(30);

  noFill();
  strokeCap(SQUARE);
  background(255);
}

//------------------------------------------------------
void draw() {
  //  background(255);

  float dst = 1000000;
  int ind = -1;
  PVector position = new PVector();
  PVector p = path.get(0);
  for (int i = 0; i<path.size()-1; i++) {
    PVector q = path.get(i+1);
    Distance distance = linePointDistance(p, q, walker);
    if (distance.d<dst) {
      dst = distance.d;
      ind = i;
      position = distance.p;
    }
    p = q;
  }

  ArrayList<PVector> newPath = new ArrayList<PVector>();
  for (int i=0; i<=ind; i++) {
    newPath.add(path.get(i));
  }

  PVector a = PVector.fromAngle(random(TWO_PI));
  float r = 60*sqrt(random(1));
  newPath.add(position.add(a.mult(r)));
  for (int i=ind+1; i< path.size(); i++) {
    newPath.add(path.get(i));
  }
  path = newPath;

  if (dst<1000000) {
    stroke(255);
    float weight = dst/10.0;
    println(weight);
    strokeWeight(weight+3);
    line(walker.x, walker.y, position.x, position.y);

    stroke(0);
    strokeWeight(weight);
    line(walker.x, walker.y, position.x, position.y);
  }

  a = PVector.fromAngle(random(TWO_PI));
  r = 100*sqrt(random(1));
  walker.add(a.mult(r));

  if (walker.x<0 || walker.x>width || walker.y<0 || walker.y>height) {
    walker.set(width/2, height/2);
  }
}


//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
// from utils.js
//
// distance from line AB to point v
Distance linePointDistance(PVector A, PVector B, PVector v) {
  // find the closest point on line AB to point v.
  // returns the distance (dst), s, and p so that
  // p = PVector.lerp(A, B, s) is the point on AB closest to v.
  Distance dst= new Distance(0, 0, new PVector());

  float l = A.dist(B);
  l=l*l;
  if (l <= 0) { // line is a point
    dst.d = A.dist(v);
    dst.s = 0;
    dst.p = A.copy();
    return dst;
  }


  float t = min(1, max(0, (((v.x - A.x)*(B.x-A.x)+
    (v.y-A.y)*(B.y-A.y)))/l));
  PVector pp = A.copy().lerp(B, t);  
  dst.d = v.dist(pp);
  dst.s = t;
  dst.p = pp;
  return dst;
}
