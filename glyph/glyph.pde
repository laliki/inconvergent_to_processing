/*
This is a Processing version of the p5.js code glyph.js.
It uses some functions from utils.js.

glyph.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

ArrayList<PVector> vertexs;
ArrayList<Edge> edges;

int margin = 50;

//------------------------------------------------------
void setup() {
  size(800, 800);
  noFill();
  strokeCap(SQUARE);

  inicialitza(60);
}

//------------------------------------------------------
void draw() {
  background(255);

  closestFromMouse();
  diminish();

  stroke(0);
  for (Edge e : edges) {
    e.display();
  }
}

//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
void diminish() {
  for (Edge e : edges) {
    e.sw *= 0.995;
  }
}

//------------------------------------------------------
void closestFromMouse() {
  float dst = 100000;
  PVector m = new PVector(mouseX, mouseY);
  Edge closest = edges.get(0);
  for (Edge e : edges) {
    Distance distance = linePointDistance(e.p, e.q, m);
    if (distance.d<dst) {
      dst = distance.d;
      closest = e;
    }
  }
  closest.sw += 10;
}


//------------------------------------------------------
void inicialitza(int n) {
  float d = (width-2*margin)/n; 
  vertexs = new ArrayList<PVector>(); 
  for (int j = 0; j<=n; j++) {
    for (int i=0; i<=n; i++) {
      PVector v = new PVector(margin + i*d, margin + j*d); 
      vertexs.add(v);
    }
  }

  // add vertical edges
  edges = new ArrayList<Edge>(); 
  for (int i = 1; i<n; i++) {
    for (int j = 0; j<n; j++) {
      int k = i+(n+1)*j; 
      PVector v = vertexs.get(k); 
      PVector vy = vertexs.get(k+n+1); 

      Edge e = new Edge(v, vy); 
      edges.add(e);
    }
  }

  // add horizontal edges
  for (int j = 1; j<n; j++) {
    for (int i = 0; i<n; i++) {
      int k = i+(n+1)*j; 
      PVector v = vertexs.get(k); 
      PVector vx = vertexs.get(k+1); 

      Edge e = new Edge(v, vx); 
      edges.add(e);
    }
  }

  // add oblique edges
  for (int i=0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      int k = i+(n+1)*j; 
      PVector vright = vertexs.get(k); 
      PVector vright2 = vertexs.get(k+n+2); 
      PVector vleft = vertexs.get(k+1); 
      PVector vleft2 = vertexs.get(k+n+1); 

      Edge e = new Edge(vright, vright2); 
      edges.add(e); 
      e = new Edge(vleft, vleft2); 
      edges.add(e);
    }
  }
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
