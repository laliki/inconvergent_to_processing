/*
This is a Processing version of the p5.js code walker.js.
It uses some functions from utils.js.

walker.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

float stp = 5;
int margin = 50;
PVector position;
ArrayList<Line> lines;

//------------------------------------------------------
void setup() {
  size(1000, 1000);
  strokeWeight(2);

  position = new PVector(width/2, height/2);
  walk();
  lines = new ArrayList<Line>();
  int n = 50;
  float dx = width-2*margin;
  dx /= (n-1);
  float dy = height-2*margin;
  dy /= (n-1);
  for (int i =0; i<n; i++) {
    float x = margin + i*dx;
    Line l = new Line(x, margin, x, height-margin);
    lines.add(l);
    // Comment the next three lines to have the same animation,
    // with only vertical lines.
    float y = margin + i*dy;
    l = new Line(margin, y, width-margin, y);
    lines.add(l);
  }
}

//------------------------------------------------------
void draw() {
  background(255);
  ArrayList<Line> res = new ArrayList<Line>();
  walk();
  PVector a = PVector.fromAngle(random(TWO_PI));
  float r = 20*sqrt(random(1));
  PVector ww = position.copy().add(a.mult(r));
  Line cut = new Line(position, ww);
  for (Line l : lines) {
    Intersection i = cut.intersects(l);
    if (l.p1.dist(l.p0)>20 && i.inter) {

      PVector p = cut.p0.copy();
      
      //    p.lerp(cut.p1, 0); 
      // Slightly different: (1) uncomment previous line, and
      // (2) comment next 4 lines.
      p.lerp(cut.p1, i.x);
      a = PVector.fromAngle(random(TWO_PI));
      r = 10*sqrt(random(1));
      p.add(a.mult(r));

      //ellipse(p.x, p.y, 5,5);
      res.add(new Line(l.p0, p));
      res.add(new Line(l.p1, p));
    } else {
      res.add(l);
    }
  }
  lines = res;
  for (Line l : lines) {
    l.display();
  }
  noFill();
  ellipse(position.x, position.y, 10, 10);
}

//------------------------------------------------------
void walk() {
  PVector a = PVector.fromAngle(random(TWO_PI));
  float r = stp*sqrt(random(1));
  position.add(a.mult(r));
}

//------------------------------------------------------
void mouseReleased() {
  position.set(mouseX, mouseY);
  walk();
}
