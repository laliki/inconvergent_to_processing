/*
This is a Processing version of the p5.js code mirror.js.
It uses some functions from utils.js.

mirror.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

ArrayList<PVector> vertexs;
ArrayList<Edge> edges;
ArrayList<PVector> mirrors;

int margin = 100;

//------------------------------------------------------
void setup() {
  size(1000, 1000);
  noFill();

  init(100);
}

//------------------------------------------------------
void draw() {
  background(255);

  stroke(0, 125);

  for (PVector v : vertexs) {
    ellipse(v.x, v.y, 3, 3);
  }

  // Uncomment these lines to see the edges. (Messy.)
  //  stroke(0);
  //  for (Edge e : edges) {
  //    e.display();
  //  }

  stroke(0, 200, 200);
  for (int i=0; i<mirrors.size()-1; i++) {
    PVector p = mirrors.get(i);
    PVector q = mirrors.get(i+1);
    line(p.x, p.y, q.x, q.y);
    ellipse(p.x, p.y, 10, 10);
  }
  if (mirrors.size()>0) {
    PVector last = mirrors.get(mirrors.size()-1);
    ellipse(last.x, last.y, 10, 10);
  }
}

//------------------------------------------------------
void mouseClicked() {
  mirrors.add(new PVector(mouseX, mouseY));
  if (mirrors.size()>1) {
    for (PVector v : vertexs) {
      reflect(v);
    }
  }
}

//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
void reflect(PVector v) {
  float dst = 100000;
  PVector p = new PVector();
  float s = 0;
  int ind = -1;

  for ( int i=0; i<mirrors.size()-1; i++) {
    Distance distance = linePointDistance(
      mirrors.get(i), mirrors.get(i+1), v);
    if (distance.d< dst) {
      dst = distance.d;
      ind = i;
      s = distance.s;
      p = distance.p;
    }
  }

  if (ind == (mirrors.size()-2) && s>0 && s<1) {
    v.mult(-1).add(p).add(p);
  }
}

//------------------------------------------------------
void init(int n) {
  float d = (width-2*margin)/n;
  vertexs = new ArrayList<PVector>();
  for (int j = 0; j<=n; j++) {
    for (int i=0; i<=n; i++) {
      PVector v = new PVector(margin + i*d, margin + j*d);
      vertexs.add(v);
    }
  }

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
  for (int j = 1; j<n; j++) {
    for (int i = 0; i<n; i++) {
      int k = i+(n+1)*j;
      PVector v = vertexs.get(k);
      PVector vx = vertexs.get(k+1);

      Edge e = new Edge(v, vx);
      edges.add(e);
    }
  }

  mirrors = new ArrayList<PVector>();
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
