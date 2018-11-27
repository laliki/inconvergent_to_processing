class Trail {
  ArrayList<PVector> points;
  PVector v;

  Trail(PVector p) {
    points = new ArrayList<PVector>();
    points.add(p);

    v = PVector.fromAngle(random(TWO_PI));
    float r = 10*sqrt(random(1));
    v.mult(r);
    maxLength = 100;
  }

  //------------------------------------------------------
  PVector last() {
    return points.get(points.size()-1);
  }

  //------------------------------------------------------
  void display() {
    // draw body (only the last position of each trail)
    PVector p = last();
    ellipse(p.x, p.y, 10, 10);

    // draw trail
    for (int i=0; i<points.size()-1; i++) {
      p = points.get(i);
      PVector q = points.get(i+1);
      line(p.x, p.y, q.x, q.y);
    }
  }

  //------------------------------------------------------
  void update(PVector a) {
    // the new velocity is the old velocity + the acceleration +
    // a little bit of randomness
    PVector angle = PVector.fromAngle(random(TWO_PI));
    float r = sqrt(random(1));
    v.add(a).add(angle.mult(r)); 

    // new position is the old position + the velocity (multiplied by stepSize)
    PVector pos = last().copy().add(v.copy().mult(stepSize)); 
    points.add(pos);

    // make sure each trail is at most maxLength long
    while (points.size()>maxLength) {
      points.remove(0);
    }
  }
}
