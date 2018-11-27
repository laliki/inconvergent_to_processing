/*
This is a Processing version of the p5.js code circles.js.

circles.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at 
https://github.com/inconvergent/inconvergent-sandbox
*/

int n=10;
float[] x = new float[n];
float[] y = new float[n];

//------------------------------------------------------
void setup() {
  size(1000, 1000);
  background(255);

  for (int i=0; i<n; i++) {
    x[i] = width*i/(n-1);
    y[i] = height/2;
  }
}

//------------------------------------------------------
void draw() {
  for (int i = 0; i<n; i++) {
    float vx = x[i]-mouseX;
    float vy = y[i]-mouseY;
    
    float l = sqrt(vx*vx+vy*vy);
    float ll = l*0.2;
    float d = random(ll);
    ellipse(x[i], y[i], d, d);
    
    float a = random(TWO_PI);
    float r = 5*sqrt(random(1));
    x[i] = x[i] - vx/l + r*cos(a);
    y[i] = y[i] - vy/l + r*sin(a);
  }
}
