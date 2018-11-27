/*
This is a Processing version of the p5.js code intro.js.
Simple code, included here for completeness.

intro.js BY Anders Hoff, a.k.a. inconvergent (inconvergent.net)
Processing version BY Lali Barriere (lalibarriere.net)

p5.js code can be found at
https://github.com/inconvergent/inconvergent-sandbox
*/

void setup() {
  size(1000, 1000);
  background(255);
}

//------------------------------------------------------
void draw() {
  ellipse(mouseX, mouseY, 10, 10);
}
