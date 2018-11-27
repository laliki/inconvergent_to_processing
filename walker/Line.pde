class Line {
  PVector p0;
  PVector p1;

  Line(PVector aa, PVector bb) {
    p0 = aa;
    p1 = bb;
  }

  Line(float x1, float y1, float x2, float y2) {
    p0 = new PVector(x1, y1);
    p1 = new PVector(x2, y2);
  }

  //------------------------------------------------------
  void display() {
    line(p0.x, p0.y, p1.x, p1.y);
  }

  //------------------------------------------------------
  // from utils.js
  //
  Intersection intersects(Line b) {
    Intersection i;

    PVector sa = p1.copy().sub(p0);
    PVector sb = b.p1.copy().sub(b.p0);

    float u = (-sb.x * sa.y) + (sa.x * sb.y);
    if (abs(u)<=0) {
      i = new Intersection(false, -1, -1);
      return i;
    } else {
      float q = ((-sa.y* (p0.x - b.p0.x)) +
        ( sa.x * (p0.y - b.p0.y))) / u;
      float p = ((sb.x * (p0.y - b.p0.y)) -
        (sb.y * (p0.x - b.p0.x))) / u;
      i = new Intersection((p >= 0 && p <= 1 && q >= 0 && q <= 1), p, q);
    }
    return i;
  }
}
