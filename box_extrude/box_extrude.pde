/*
This is a Processing version of the p5.js code box-extrude.js.
It uses some functions from utils.js.

box-extrude.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

ArrayList<PVector> vertexs;
ArrayList<Integer> path;
int selectedEdge;

//------------------------------------------------------
void setup() {
  size(1000, 1000);

  // get a box in the middle of the canvas.
  // width: w, height: h
  vertexs = new ArrayList<PVector>();
  float x = width/2;
  float w = width/20;
  float y = height/2;
  float h = height/20;
  vertexs.add(new PVector(x-w, y-h));
  vertexs.add(new PVector(x+w, y-h));
  vertexs.add(new PVector(x+w, y+h));
  vertexs.add(new PVector(x-w, y+h));

  // make a path that denotes the order of the initial vertices.
  // the path starts and stops at the first vertex.
  // in this case [0, 1, 2, 3, 0]
  path = new ArrayList<Integer>();
  for (int i=0; i<vertexs.size(); i++) {
    path.add(i);
  }
  path.add(0);
}

//------------------------------------------------------
void draw() {
  background(255);

  // draw the path
  PVector q = vertexs.get(path.get(0));
  for (int i=1; i<path.size(); i++) {
    PVector p = q;
    q = vertexs.get(path.get(i));
    line(p.x, p.y, q.x, q.y);
  }

  // find the edge closest to the mouse.
  selectedEdge = lineDistanceMouse();

  for (PVector v : vertexs) {
    ellipse(v.x, v.y, 10, 10);
  }
}

//------------------------------------------------------
void mouseClicked() {
  extrudeEdge(selectedEdge);
}

//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
int lineDistanceMouse() {
  float dst = 1000000;
  int e = 0;
  PVector p = new PVector();
  PVector m = new PVector(mouseX, mouseY);

  // for every edge, calulate the distance to mouse
  for (int i=0; i<path.size()-1; i++) {
    Distance distance = linePointDistance(
      vertexs.get(path.get(i)), vertexs.get(path.get(i+1)), m);
    // if the new distance is closer than current closest distance, update.
    if (distance.d<dst) {
      dst = distance.d;
      e = i;
      p = distance.p;
    }
  }

  // show a path to the closest edge
  ellipse(p.x, p.y, 10, 10);
  line(m.x, m.y, p.x, p.y);

  //retrun index of the (first vertex of the) edge
  return e;
}


//------------------------------------------------------
void extrudeEdge(int e) {
  int numVerts = vertexs.size();

  // e is the index of the first vertex of the edge. so that the edge consists
  // of vertices state.path[e], and state.path[e+1]
  int a = path.get(e);
  int b = path.get(e+1);

  // get the actual vertices
  PVector va = vertexs.get(a);
  PVector vb = vertexs.get(b);

  // the vector between va and vb.
  // normalize to get a vector of length 1
  PVector angleVec = vb.copy().sub(va).normalize();

  // convert to the angle, and rotate it by pi*0.5 (equivalent to 90 degrees)
  float angle = atan2(angleVec.y, angleVec.x)-HALF_PI;

  // get a number between 20 and 100
  float mag = random(20, 100);

  //convert the angle back to vector, of length mag
  PVector v = PVector.fromAngle(angle).setMag(mag);

  // with a 40 percent probability, displace v inside a circle of radius
  // mag*0.7
  if (random(1)<0.4) {
    PVector aa = PVector.fromAngle(random(TWO_PI));
    v.add(aa.mult(mag*0.7));
  }

  // add the vertices of the extruded edge
  vertexs.add(va.copy().add(v));
  vertexs.add(vb.copy().add(v));

  // now we split the existing path in two halves, and insert the new vertices
  ArrayList<Integer> newPath = new ArrayList<Integer>();
  // this is the first part of the path
  for (int i=0; i<=e; i++) {
    newPath.add(path.get(i));
  }
  // add the new vertices
  newPath.add(numVerts);
  newPath.add(numVerts+1);

  // this is last part of the path.
  for (int i=e+1; i<path.size(); i++) {
    newPath.add(path.get(i));
  }

  // update the path
  path = newPath;
}

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
