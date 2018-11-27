class Branch {
  ArrayList<PVector> pos;
  ArrayList<Float> angle;
  ArrayList<Float> w;
  int steps;

  Branch(PVector p, float a) {
    pos = new ArrayList<PVector>();
    angle = new ArrayList<Float>();
    w = new ArrayList<Float>();
    pos.add(p);
    angle.add(a);
    steps = 0;
    w.add(1.0);
  }

  Branch(PVector p, float a, int s, float ww) {
    pos = new ArrayList<PVector>();
    angle = new ArrayList<Float>();
    w = new ArrayList<Float>();
    pos.add(p);
    angle.add(a);
    steps = s;
    w.add(ww);
  }


  //------------------------------------------------------
  float lastAngle() {
    return angle.get(angle.size()-1);
  }

  //------------------------------------------------------
  float lastWidth() {
    return w.get(w.size()-1);
  }

  //------------------------------------------------------
  PVector lastPos() {
    return pos.get(pos.size()-1);
  }

  //------------------------------------------------------
  void display() {
    if (pos.size()>=2) {
      ArrayList<PVector> tail = new ArrayList<PVector>();
      for (PVector p : pos) {
        PVector cp = p.copy();
        tail.add(cp);
      }

      ArrayList<Float> angleTail = new ArrayList<Float>();
      for (Float a : angle) {
        float b = a;
        angleTail.add(b);
      }

      ArrayList<Float> widthTail = new ArrayList<Float>();
      for (Float ww : w) {
        widthTail.add(40*ww);
      }

      ArrayList<PVector> leftPath = offsetAngle(tail, angleTail, widthTail, HALF_PI);
      ArrayList<PVector> rightPath = offsetAngle(tail, angleTail, widthTail, -HALF_PI);


      fill(255);
      noStroke();
      beginShape();
      for (int i=0; i<leftPath.size(); i++) {
        vertex(leftPath.get(i).x, leftPath.get(i).y);
      }
      for (int i=rightPath.size()-1; i>=0; i--) {
        vertex(rightPath.get(i).x, rightPath.get(i).y);
      }     
      endShape(CLOSE);

      noFill();
      stroke(0);
      strokeWeight(2);
      for (int i=1; i<rightPath.size()-1; i++) {
        line(rightPath.get(i-1).x, 
          rightPath.get(i-1).y, 
          rightPath.get(i).x, 
          rightPath.get(i).y);
      }
      for (int i=1; i<leftPath.size()-1; i++) {
        line(leftPath.get(i-1).x, 
          leftPath.get(i-1).y, 
          leftPath.get(i).x, 
          leftPath.get(i).y);
      }
    }
  }

  //------------------------------------------------------
  ArrayList<PVector> offsetAngle(ArrayList<PVector> t, ArrayList<Float> at, ArrayList<Float> wt, float a) {
    ArrayList<PVector> path = new ArrayList<PVector>();
    for (int i=0; i<t.size(); i++) {
      PVector v = t.get(i);
      float an = at.get(i);
      float wi = wt.get(i);

      PVector vp = v.copy().add(PVector.fromAngle(an+a).mult(wi));
      path.add(vp);
    } 
    return path;
  }
}
