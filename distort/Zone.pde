class Zone{
  ArrayList<PVector> points;
  color c;
  
  Zone(){
    points = new ArrayList<PVector>();
    c = color(random(255), random(255), random(255));
  }
  
  void add(PVector v){
    points.add(v);
  }
  
  void remove(PVector v){
    points.remove(v);
  }
}
