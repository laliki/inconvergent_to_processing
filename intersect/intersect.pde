/*
This is a Processing version of the p5.js code intersect.js.

intersect.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

ArrayList<Line> lines;
int margin = 50;
boolean started;

// the animation starts after the first mouse click
//------------------------------------------------------
void setup() {
  size(1000, 1000);

  lines = new ArrayList<Line>();
  int n = 100;
  float dx = width-2*margin;
  dx /= (n-1);
  for (int i =0; i<n; i++) {
    float x = margin + i*dx;
    Line l = new Line(x, margin, x, height-margin);
    lines.add(l);
  }
  for (int i =0; i<n; i++) {
    float y = margin + i*dx;
    Line l = new Line(margin, y, width-margin, y);
    lines.add(l);
  }
}

//------------------------------------------------------
void draw() {
  background(255);
  if (started) {
    // cut from the previous position to current positon (mouse)
    Line cut = new Line(new PVector(mouseX, mouseY), new PVector(pmouseX, pmouseY));

    // show position of mouse
    ellipse(mouseX, mouseY, 15, 15);

    // look for an intersection between cut and every line
    ArrayList<Line> newLines = new ArrayList<Line>();
    for (Line l : lines) {
      // checks for intersections
      Intersection i = cut.intersect(l);
      if (i.inter) {
        // alternate vectors. try this.
        //const v1 = PVector.fromAngle(random(TWO_PI)).setMag(20);
        //const v2 = PVector.fromAngle(random(TWO_PI)).setMag(20);

        // this vector points in the same as the cut vector
        // (and it has the same length)
        PVector v1 = cut.p1.copy().sub(cut.p0);
        // this vector points in the oposite direction
        PVector v2 = v1.copy().mult(-1);
        // mid is the point on line where cut intersects.
        PVector mid = cut.p0.copy();
        mid.lerp(cut.p1, i.x);

        // make two new lines, and move each new line in the direction of v1
        // and v2, respectively
        PVector p = l.p0.copy().add(v1);
        PVector q = mid.copy().add(v1);
        newLines.add(new Line(p, q));
        p = mid.copy().add(v2);
        q = l.p1.copy().add(v2);
        newLines.add(new Line(p, q));
      } else {
        // if there is no intersection, keep the original line
        newLines.add(l);
      }
    }

    // update the lines with new (and old) lines.
    lines = newLines;
  }

  // draw all lines
  for (Line l : lines) {
    l.display();
  }
}

//------------------------------------------------------
void mousePressed() {
  started = true;
}
