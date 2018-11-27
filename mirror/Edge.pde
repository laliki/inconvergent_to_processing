class Edge {
  PVector p;
  PVector q;

  Edge(PVector pp, PVector qq) {
    p = pp;
    q = qq;
  }

  void display() {

      line(p.x, p.y, q.x, q.y);
    
  }
}
