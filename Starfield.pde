Particle[] particles;
Oddball rocket;
PImage photo;

int CANVAS_WIDTH=800;
int CANVAS_HEIGHT=800;
int NUM_PARTICLES=500;
int IMAGE_WIDTH=50;
int activeParticles=0;

void setup() {
  background(0);

  size(800, 800);
  photo = loadImage("xtree3.png");
  photo.resize(IMAGE_WIDTH, 0);
  rocket = new Oddball(photo);
  particles = new Particle[NUM_PARTICLES];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  if (rocket.myY >= CANVAS_HEIGHT/2) {
      frameRate(40);

    background(0);
    rocket.move();
    rocket.show();
  } else {
       frameRate(30);
   fill(0, 0, 0, 30);
    rect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
    for (int i = 0; i < Math.min(particles.length, activeParticles + 1); i++) {
      particles[i].move();
      particles[i].show();
    }
    activeParticles++;
  }
}
void mousePressed() {
  activeParticles=0;
  rocket.reset();
  for (int i = 0; i < particles.length; i++) {
    particles[i].reset();
  }
  redraw();
}

class Particle {
  double mySpeed, myAngle;
  int myX, myY, r, g, b;
  Particle() {
    mySpeed = (Math.random()*8)+3;
    myAngle = Math.random()*(2*Math.PI);
    r = (int)(Math.random()*255);
    g = (int)(Math.random()*255);
    b = (int)(Math.random()*255);
    reset();
  }
  void move() {
    myX = myX + (int)(mySpeed *  Math.cos(myAngle));
    myY = myY + (int)(mySpeed * Math.sin(myAngle));
  }
  void show() {
    fill(r, g, b);
    int size = 6;
    ellipse(myX, myY, size, size);
  }
  void reset() {
    myX = CANVAS_WIDTH/2;
    myY = CANVAS_HEIGHT/2;
  }
}
class Oddball extends Particle {
  PImage myPhoto;

  Oddball(PImage photo) {
    myPhoto = photo;
    mySpeed = (Math.random()*8)+3;
    myAngle = -Math.PI/2;
    reset();
  }
  void reset() {
    myX = CANVAS_WIDTH/2-IMAGE_WIDTH/2;
    myY = CANVAS_HEIGHT;
  }
  void show() {
    image(myPhoto, myX, myY);
  }
}
