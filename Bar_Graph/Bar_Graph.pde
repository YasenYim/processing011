color clr=#6DC3F0;

Bar[]bs;


void setup() {
  size(1000, 800);

  bs=new Bar[12];
  float unit=width/float(bs.length+1);
  for (int i=0; i<bs.length; i++) {
    bs[i]=new Bar(unit*(i+1), height*0.8, random(height*0.1, height*0.6), nf(2002+i));
  }
}

void draw() {

  background(255);

  int index=frameCount/20;
  index=min(index, bs.length-1);
  bs[index].trigger();    //每个柱子依次动起来

  for (int i=0; i<bs.length; i++) {
    bs[i].update();
    bs[i].display();
  }

  stroke(clr);
  strokeWeight(3);
  line(0, height*0.8, width, height*0.8);
}



class Bar {

  float xpos;
  float ypos;
  float wd;
  float ht;
  float ht_target;
  float ht_spd;
  boolean moving=false;  //为true时才开始动，参考下面的 trigger 命令
  String name;

  Bar(float xx, float yy, float ht_t, String ss) {
    xpos=xx;
    ypos=yy;
    wd=20;
    ht=0;
    ht_target=ht_t;
    ht_spd=0;

    name=ss;
  }

  void trigger() {
    moving=true;
  }

  void update() {
    if (moving) {
      float acc=(ht_target-ht)*0.01;
      ht_spd+=acc;
      ht+=ht_spd;
      ht_spd*=0.9;
    }
  }

  void display() {
    noStroke();
    fill(clr);
    rect(xpos-wd/2, ypos-ht, wd, ht);

    fill(clr);
    textSize(wd);
    textAlign(CENTER, TOP);
    text(name, xpos, ypos+wd);
  }
}
