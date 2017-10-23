/*
  A virtual version of a mini sand zen garden!  All of the zen, none of the mess!
  When the program is run, a unique garden is generated with a random number of
  plants and rocks in various sizes and colors, placed randomly in the garden.
  The user can use a rake tool to "rake" the sand in the garden, or the draw tool
  to simulate drawing with a finger or similar tool.  When using these tools, darker 
  sand particles are generated to simulate the movement of the sand. There is also a 
  "smooth" tool to smooth the sand back over to quickly erase drawings, or the user 
  can simply wait for their drawings to fade away over time.  There is also a reset 
  option that allows the user to start over with a newly generated garden.
  
  Note: buttons may take multiple clicks or a few seconds of waiting before they
        properly update tools or reset the garden.  I don't know why this happens 
        but the buttons do work, I promise.
*/

import g4p_controls.*;

int num = 60;
float mx[] = new float[num];
float my[] = new float[num];

ArrayList<Particle> particles, garbage;
PVector gravity;
int bound = 400;

ArrayList<Rock> rocks;
ArrayList<Plant> plants;

boolean draw = false;
boolean rake = true;
boolean smooth = false;
boolean guiCreated = false;

PVector rakePos, rakeNorm, rakeS1, rakeS2;
float rakeLen = 70;



void setup() 
{
  size(600, 400);
  frameRate(60);
  particles = new ArrayList();
  garbage = new ArrayList();
  rocks = new ArrayList();
  plants = new ArrayList();
  colorMode(HSB, 360, 100, 100, 100);
  if (!guiCreated) {
    createGUI();
    guiCreated = true;
  }
  
  rakePos = new PVector(mouseX-rakeLen, mouseY); 
  
  //randomly generate number of rocks and draw them ***********************************************
  int rockNum = int(random(1,5));
  for (int i = 0; i < rockNum; i++) {
    rocks.add(new Rock(
      random(20, 580),
      random(20, 380),
      random(30,100),
      random(30,60)));
  }
  
  //randomly generate number of plants and draw them ***********************************************
  int plantNum = int(random(1,5));
  for (int i = 0; i < plantNum; i++) {
    plants.add(new Plant(
      random(20, 580),
      random(20, 380),
      random(10,50),
      random(30,60)));
  }
 
}


void draw() 
{
  //set bg color
   background(50, 20, 90);
   
   //setting up some values for rake tool **********************************************************************
   rakeNorm = rakePos.sub(new PVector(mouseX, mouseY)).normalize();
   rakePos = new PVector(mouseX, mouseY).add(rakeNorm.copy().mult(rakeLen));
   rakeS1 = rakePos.copy().add(rakeNorm.copy().rotate(HALF_PI).normalize().mult(rakeLen/4));
   rakeS2 = rakePos.copy().add(rakeNorm.copy().rotate(-HALF_PI).normalize().mult(rakeLen/4));
   

   //draw particles depending on tool selected **************************************************************
   if (mousePressed && mouseButton == LEFT) {
    if (mouseX > 200 || mouseY > 40) {
      if (draw) {
        for (int i = 0; i< 5; i++)
        particles.add(new Particle(
          mouseX,
          mouseY,
          random(-10, 10),
          random(-10, 10),
          6,
          0.1,
          false));
      } else if (rake) {
        for (int i = 0; i< 5; i++)
        particles.add(new Particle(
          rakeS1.x,
          rakeS1.y,
          random(-10, 10),
          random(-10, 10),
          3,
          0.1,
          false));
          for (int i = 0; i< 5; i++)
        particles.add(new Particle(
          rakeS2.x,
          rakeS2.y,
          random(-10, 10),
          random(-10, 10),
          3,
          0.1,
          false));
          for (int i = 0; i< 5; i++)
        particles.add(new Particle(
          rakePos.x,
          rakePos.y,
          random(-10, 10),
          random(-10, 10),
          3,
          0.1,
          false));
       } else if (smooth) {
        particles.add(new Particle(
          mouseX,
          mouseY,
          random(-10, 10),
          random(-10, 10),
          40,
          0.1,
          true));
       }
    }
   }

// clean up old particles ***********************************************************
  for (Particle p : particles) {
    if (p.dead) garbage.add(p);
    else p.draw();
  }
  
  for (Particle p : garbage) {
    if (p.dead) particles.remove(p);
  }
  
// draw rocks and plants ************************************************************  
  for (Rock r : rocks) {
    r.draw();
  }
  
  for (Plant pl : plants) {
    pl.draw();
  }
  
// draw rake cursor ****************************************************************  
  if (rake) {
      stroke(240);
      strokeWeight(2);
      line(mouseX, mouseY, rakePos.x, rakePos.y);
      line(rakePos.x, rakePos.y, rakeS1.x, rakeS1.y);
      line(rakePos.x, rakePos.y, rakeS2.x, rakeS2.y);
   }
}

void mouseDragged()
{
  mx[num-1] = mouseX;
  my[num-1] = mouseY;
}