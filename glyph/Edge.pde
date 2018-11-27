class Edge {
  PVector p;
  PVector q;
  float sw;

  Edge(PVector pp, PVector qq) {
    p = pp;
    q = qq;
    sw = 0;
  }

  void display() {
    if (sw>0.5) {
      strokeWeight(sw);
      stroke(0, 128);
      line(p.x, p.y, q.x, q.y);
    }
  }
}
