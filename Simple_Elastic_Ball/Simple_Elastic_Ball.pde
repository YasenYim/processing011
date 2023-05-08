PVector pos; 
PVector spd; 
PVector target; 
float diam=80;
boolean moving=false;

void setup() {
  size(960, 720);

  pos=new PVector(width*0.2, height*0.5); 
  target=new PVector(width*0.5, height*0.5); 
  spd=new PVector(0, 0);
}

void draw() {
  background(0);

  if (moving) {
    PVector acc=PVector.sub(target, pos); 
    acc.mult(0.01); 

    spd.add(acc); 
    pos.add(spd); 
    spd.mult(0.96);
  }

  drawDashCircle(12);

  noStroke(); 
  fill(100, 200, 255); 
  ellipse(pos.x, pos.y, diam, diam);
}

void mousePressed() {
  moving=!moving;
}

void drawDashCircle(int sep) {
  noFill(); 
  stroke(255, 255, 0); 
  for (int i=0; i<sep; i++) {
    arc(target.x, target.y, diam, diam, i*TWO_PI/sep, i*TWO_PI/sep+TWO_PI/(sep*2));
  }
}
