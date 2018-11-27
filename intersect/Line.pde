class Line {
  PVector p0;
  PVector p1;

  //------------------------------------------------------
  Line(PVector aa, PVector bb) {
    p0 = aa;
    p1 = bb;
  }

  //------------------------------------------------------
  Line(float x1, float y1, float x2, float y2) {
    p0 = new PVector(x1, y1);
    p1 = new PVector(x2, y2);
  }

  //------------------------------------------------------
  void display() {
    line(p0.x, p0.y, p1.x, p1.y);
  }

  //------------------------------------------------------
  Intersection intersect(Line b) {
    // tests whether line intersect line b.
    // if they intersect, it returns p and q so that
    // p5.Vector.lerp(aa[0], aa[1], p), and
    // p5.Vector.lerp(bb[0], bb[1], q) is the intersection point.
    Intersection i;

    PVector sa = p1.copy().sub(p0);
    PVector sb = b.p1.copy().sub(b.p0);
    float u = cross(sa, sb);
    //  float u = (-sb.x * sa.y) + (sa.x * sb.y); // ADDED cross() FUNCTION !!!

    // this is just a safe-guard so we do not divide by zero below.
    // it is not a good way to test for parallel lines
    if (abs(u)<=0) {
      i = new Intersection(false, -1, -1);
      return i;
    } else {
      PVector ba = p0.copy().sub(b.p0);
      float q = cross(sa, ba)/u;
      float p = cross(sb, ba)/u;
      // CANVIAT DESPRES D'AFEGIR LA FUNCIO cross()
      //float q = ((-sa.y* (p0.x - b.p0.x)) +
      //  ( sa.x * (p0.y - b.p0.y))) / u;
      // float p = ((sb.x * (p0.y - b.p0.y)) -
      //  (sb.y * (p0.x - b.p0.x))) / u;


      i = new Intersection((p >= 0 && p <= 1 && q >= 0 && q <= 1), p, q);
    }
    return i;
  }

  //------------------------------------------------------
  float cross(PVector A, PVector B) {
    return A.x*B.y-B.x*A.y;
  }
}
