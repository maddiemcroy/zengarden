/*
  Sand particles that are drawn to simulate drawing in sand when the user clicks and drags the mouse.
  Particles move outward for a short time after they are spawned, and slowly fade over time and are 
  eventually deleted when they become invisible.
*/
public class Particle {
  PVector pos, vel, acc;        
  color col;
  float maxVel, brightness;
  int size, age, trans;
  boolean erase, dead;
  
  public Particle(float _x, float _y, float _vX, float _vY, int _size, float _mV, boolean _erase) {
    pos = new PVector(_x, _y);  
    vel = new PVector(_vX, _vY);
    acc = new PVector(0, 0);
    maxVel = _mV;
    size = _size;
    colorMode(HSB, 360, 100, 100, 300);
    trans = 500;
    brightness = random(60, 80);
    col = color(50, 50, brightness, trans);
    erase = _erase;
    if (erase) {
      col = color(50, 20, 90);
      vel = new PVector(0, 0);
      acc = new PVector(0, 0);
    }
    
  }

  void draw() {    
    update();
    noStroke();                        
    fill(col);                         
    ellipse(pos.x, pos.y, size, size); 
  }
  
  void update() {
    
// physics stuff and setting bounds **************************************************************** 
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.set(-vel.x/25,-vel.y/25);
    if (pos.x < -bound || pos.x > width + bound || pos.y < -bound || pos.y > height + bound)
      dead = true;

// make particles fade over time, delete them when they become invisible **************************************************************** 
    if (trans > 1)
      trans--;
    else
      dead = true;

// set particle color to bg color if using the smooth tool, otherwise update transparency for fade effect ***********************************************
    if (!erase) {  
      col = color(50, 50, brightness, trans);
    } else {  
      col = color(50, 20, 90, trans);
    }
    fill(col);
  }
  
  void addForce(PVector force) {
    acc.add(force);
  }
}