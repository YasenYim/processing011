//点击鼠标 pop out

Button mother;
Button[]sons;

boolean expanding=false;
PVector start;

void setup() {
  size(1000, 1000);
  start=new PVector(200, 200);

  mother=new Button(start, 150);

  sons=new Button[4];
  for (int i=0; i<sons.length; i++) {
    sons[i]=new Button(start, 120);
  }

  shrink();
}



void draw() {
  background(255);


  for (int i=0; i<sons.length; i++) {
    sons[i].update();
  }


  for (int i=0; i<sons.length; i++) {
    connect(mother, sons[i]);
  }

  for (int i=0; i<sons.length; i++) {
    sons[i].display();
  }

  mother.display();
}


void mousePressed() {
  expanding=!expanding;

  if (expanding) {
    spread();
  } else {
    shrink();
  }
}


void spread() {
  for (int i=0; i<sons.length; i++) {
    float angle=map(i, 0, sons.length-1, 0, PI/2);
    PVector t=PVector.fromAngle(angle);
    t.mult(400f);
    t.add(start);
    sons[i].setTarget(t);
  }
}

void shrink() {
  for (int i=0; i<sons.length; i++) {
    sons[i].setTarget(start);
  }
}


void connect(Button b1, Button b2) {
  stroke(#6DC3F0);
  strokeWeight(3);
  line(b1.pos.x, b1.pos.y, b2.pos.x, b2.pos.y);
}



class Button {

  PVector pos;
  PVector target;
  PVector vel;
  float size;

  Button(PVector loc, float d) {
    pos=loc.copy();
    size=d;
    vel=new PVector(0, 0);
  }

  void setTarget(PVector _t) {
    target=_t.copy();
  }

  void update() {
    PVector acc=PVector.sub(target, pos);
    acc.mult(0.04);
    vel.add(acc);
    pos.add(vel);
    vel.mult(0.88);
  }

  void display() {
    noStroke();
    fill(#6DC3F0);
    ellipse(pos.x, pos.y, size, size);
  }
}
