Bar bar;

void setup() {
  size(800, 600);
  bar=new Bar();
}

void draw() {
  background(0);

  bar.update();
  bar.display();
}

void mousePressed() {
  bar.deduct();
}




class Bar {

  float wd=width*0.6;
  float ht=40;

  float xpos=width*0.1;
  float ypos=height*0.5-ht*0.5;

  float value=100;
  float target=100;


  Bar() {
  }

  void update() {
    value+=(target-value)*0.1;
  }

  void display() {
    noStroke();
    fill(255, 255, 0);
    rect(xpos, ypos, map(value, 0, 100, 0, wd), ht);

    stroke(255, 255, 0);
    noFill();
    strokeWeight(3);
    rect(xpos, ypos, wd, ht);
    
    fill(255,255,0);
    textAlign(CENTER,CENTER);
    textSize(48);
    text(int(value),xpos+wd+60,ypos+ht/2-5);  //注意int(value), value是带小数的，显示在屏幕上的是整数
  }

  void deduct() {
    float amount=random(10, 30);

    if (target-amount<0) {
      target=amount;
    }
    
    target-=amount;
  }
}
