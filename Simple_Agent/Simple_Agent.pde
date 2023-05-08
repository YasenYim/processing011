PVector first;
PVector second;

void setup() {
  size(800, 600);
  background(255);

  first = new PVector(0, 0);
  second=new PVector(0, 0);
}

void draw() {
  //background(255);
  PVector target=new PVector(mouseX, mouseY);

  PVector speed1=PVector.sub(target, first);
  speed1.mult(0.1);
  first.add(speed1);

  PVector speed2=PVector.sub(target, second);
  speed2.mult(0.02);
  second.add(speed2);
  
  //fill(#69C1E3,150);
  //noStroke();
  //ellipse(first.x, first.y,20,20);
  //ellipse(second.x, second.y,20,20);
  
  stroke(50, 50);
  line(first.x, first.y, second.x, second.y);  
  line(width-first.x, first.y, width-second.x, second.y);
}
