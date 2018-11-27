/*
This is a Processing version of the p5.js code distort.js.

distort.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at 
https://github.com/inconvergent/inconvergent-sandbox
*/

ArrayList<PVector> vertexs;
ArrayList<Edge> edges;
Zone[][] zm;
int numZonesXY;
int dz;
float maxDist;

ArrayList<PVector> near;

int margin = 50;

//------------------------------------------------------
void setup() {
  size(1000, 1000);
  noFill();

  init(60, 50, 40);
}

//------------------------------------------------------
void draw() {
  background(255);

  // uncomment this block to visualize the zones
  /*  
   for (int i=0; i<numZonesXY; i++) {
   for (int j=0; j<numZonesXY; j++) {
   
   stroke(zm[i][j].c);
   fill(zm[i][j].c);
   for (PVector v : zm[i][j].points) {
   ellipse(v.x, v.y, 5, 5);
   }
   }
   }
   */

  calculateNear();
  updateNear();
  createZones();

  stroke(0);
  for (Edge e : edges) {
    e.display();
  }
}


//------------------------------------------------------
//------------------------------------------------------
//------------------------------------------------------
void init(int n, int m, float md) {
  maxDist = md;
  dz = m;
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

  near = new ArrayList<PVector>();
  numZonesXY = width/dz;
  zm = new Zone[numZonesXY][numZonesXY];
  for (int i=0; i<numZonesXY; i++) {
    for (int j=0; j<numZonesXY; j++) {
      zm[i][j] = new Zone();
    }
  }
  createZones();
}

//------------------------------------------------------
void calculateNear() {
  near.clear();
  PVector m = new PVector(mouseX, mouseY);
  int mi = mouseX/dz;
  mi = constrain(mi, 1, numZonesXY-2);
  int mj = mouseY/dz;
  mj = constrain(mj, 1, numZonesXY-2);

  for (int i=mi-1; i<= mi+1; i++) {
    for (int j = mj-1; j<= mj+1; j++) {
      for (PVector v : zm[i][j].points) {
        if (m.dist(v)<=maxDist) {
          near.add(v);
        }
      }
    }
  }
}

//------------------------------------------------------
void updateNear() {
  for (PVector v : near) {
    v.add(PVector.fromAngle(random(TWO_PI)).mult(10*sqrt(random(1))));
  }
}

//------------------------------------------------------
void createZones() {
  for (int i=0; i<numZonesXY; i++) {
    for (int j=0; j<numZonesXY; j++) {
      zm[i][j].points.clear();
    }
  }

  for (PVector v : vertexs) {
    int i = (int)(v.x/dz);
    int j = (int)(v.y/dz);
    zm[i][j].add(v);
  }
}
