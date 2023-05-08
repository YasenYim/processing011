float wd;  //每个单元格的尺寸
float ht;
float diam=20;

Demo[]demos;

void setup() {
  size(1280, 720);

  int h=4;  //四行四列
  int v=4;

  wd=width/h;
  ht=height/v;

  demos=new Demo[h*v];
  for (int i=0; i<demos.length; i++) {
    demos[i]=new Demo((i%h)*wd, (i/h)*ht);
  }
  
  for (int i=0; i<demos.length; i++) {  //在这里修改弹力系数和摩擦力系数
    float accFactor=0.01+(i%h)*0.02;
    float fricFactor=0.99-(i/h)*0.03;
    demos[i].setFactors(accFactor,fricFactor);
  }
  
  
}

void draw() {
  background(0);

  for (int i=0; i<demos.length; i++) {
    demos[i].update();
    demos[i].display();
  }
}


class Demo {

  float acc; 
  float friction; 

  float xstart, ystart; 
  PVector pos; 
  PVector spd; 
  PVector target; 

  int timer=30; 

  Demo(float xx, float yy) {

    xstart=xx; 
    ystart=yy; 
    pos=new PVector(xx+wd*0.25, yy+ht*0.5); 
    target=new PVector(xx+wd*0.75, yy+ht*0.5); 
    spd=new PVector(0, 0);
  }

  void setFactors( float _acc, float _fric) {

    acc=_acc; 
    friction=_fric;
  }

  boolean reach() {
    if (PVector.dist(pos, target)<0.1 && spd.mag()<0.1) {
      return true;
    }
    return false;
  }

  void update() {
    timer--; 
    if (timer>0) {
      pos.set(xstart+wd*0.25, ystart+ht*0.5);
    } else {
      PVector accel=PVector.sub(target, pos); 
      accel.mult(acc); 
      spd.add(accel); 
      pos.add(spd); 
      spd.mult(friction); 

      if (reach()) {
        timer=30;
      }
    }
  }

  void drawDashCircle(int sep) {
    noFill(); 
    stroke(255, 255, 0, 100); 
    for (int i=0; i<sep; i++) {
      arc(target.x, target.y, diam, diam, i*TWO_PI/sep, i*TWO_PI/sep+TWO_PI/(sep*2));
    }
  }

  void display() {
    stroke(255, 255, 0); 
    noFill(); 
    rect(xstart, ystart, wd, ht); 

    drawDashCircle(6);

    noStroke(); 
    fill(255, 255, 0); 

    ellipse(pos.x, pos.y, diam, diam); 

    textSize(diam); 
    textAlign(LEFT, TOP);
    text("Acc Factor:"+acc, xstart+10, ystart+10); 
    text("Fric Factor:"+friction, xstart+10, ystart+10+diam);
  }
}
