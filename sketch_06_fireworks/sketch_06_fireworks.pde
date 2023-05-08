//fireworks

PVector[] locs;
PVector[] targetLocs;
float[] sizes;
float[] eases;
color[] colors;

int pCount = 800;
boolean explode;

void setup() {
  size(720, 480, P2D);
  
  colorMode(HSB);
  blendMode(ADD);

  locs = new PVector[pCount];
  targetLocs = new PVector[pCount];
  sizes = new float[pCount];
  colors = new color[pCount];
  eases = new float[pCount];

  for (int i=0; i<pCount; i++) {
    locs[i] = new PVector();
    targetLocs[i] = new PVector();
    sizes[i] = random(1) * random(1) * 38 + 2;
    colors[i] = color(random(0, 30), random(100,256), 255);
  }

  explode = false;
}

void draw() {
  background(0, 255, 100);

  noStroke();
  for (int i=0; i<pCount; i++) {
    //update locs
    float dx = targetLocs[i].x - locs[i].x;
    float dy = targetLocs[i].y - locs[i].y;
    float x = locs[i].x + dx * eases[i];
    float y = locs[i].y + dy * eases[i];
    locs[i].set(x, y);

    fill(colors[i]);
    ellipse(locs[i].x, locs[i].y, sizes[i], sizes[i]);
  }
}

void mousePressed() {
  if (explode) {
    for (int i=0; i<pCount; i++) {
      float rt = random(TWO_PI);
      float dist = 250;
      float x = cos(rt) * dist + mouseX;
      float y = sin(rt) * dist + mouseY;

      targetLocs[i].set(x, y);
      eases[i] = random(0.001, 0.06);
    }
  } else {
    for (int i=0; i<pCount; i++) {
      targetLocs[i].set(mouseX, mouseY);
      eases[i] = random(0.05, 0.2);
    }
  }
  
  explode = !explode;
}
