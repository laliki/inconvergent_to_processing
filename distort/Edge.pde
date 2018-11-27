class Edge {
  PVector p;
  PVector q;

  Edge(PVector pp, PVector qq) {
    p = pp;
    q = qq;
  }

  void display() {
    if (p.dist(q)<maxDist) {
      line(p.x, p.y, q.x, q.y);
    }
  }
}
