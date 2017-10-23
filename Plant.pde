/*
  A plant of randomly generated size, color, and type (bush or spiky plant), with a shadow.
*/

public class Plant {
  
  float x, y, size, brightness;
  color col, shadowCol;
  PShape bush, spiky;
  int bc = 12;
  float[] bx = new float[bc];
  float[] by = new float[bc];
  int choice;
  
  public Plant(float _x, float _y, float _s, float _b) {
    x = _x;
    y = _y;
    size = _s;
    brightness = _b;
    col = color(129, 43, brightness);
    shadowCol = color(0, 0, brightness - 20, 30);
    for (int i = 0; i < bc; i++) {
      bx[i] = random(-size/2,size/2);
      by[i] = random(-size/2,size/2);
    }
    choice = int(random(1,3));
  }
    
  
  void draw() {
// draw shadow shape ****************************************************************     
    fill(shadowCol);
    if (choice == 1)
      spikyPlant(x+(5*size/50), y+(5*size/50), size/1.5, size*2, 9);
    else
      bush(x+(5*size/50), y+(5*size/50), size);
      
// draw plant shape ****************************************************************     
    fill(col);
    if (choice == 1)
      spikyPlant(x, y, size/1.5, size*2, 9);
    else
      bush(x, y, size);
    
  }

// make the spiky plant shape **************************************************************** 
  void spikyPlant(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
}

// make a random bush shape **************************************************************** 
  void bush(float x, float y, float size) {
    beginShape();
    size = size/2 + 30;
    ellipse(x, y, size, size);
    for (int i = 0; i < bc; i++) {
      ellipse(x+bx[i], y+by[i], size*2/3, size*2/3);
    }
    endShape(CLOSE);
  }
}