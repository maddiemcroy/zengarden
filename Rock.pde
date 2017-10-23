/*
  A rock of randomly generated size and color, with a shadow.
*/
public class Rock {
  
  float x, y, size, ratio, brightness;
  color col, strokeCol, shadowCol;
  
  public Rock(float _x, float _y, float _s, float _b) {
    x = _x;
    y = _y;
    size = _s;
    brightness = _b;
    col = color(0,0,brightness);
    strokeCol = color(0, 0, brightness - 20);
    shadowCol = color(0, 0, brightness - 20, 30);
    
    ratio = random(0.5,1.5);
  }
  
  void draw() {   
    noStroke();
    fill(shadowCol);
    ellipse(x+(5*size/50), y+(5*size/50), size, size*ratio);
    
    fill(col);
    //stroke(strokeCol);
                                       
    ellipse(x, y, size, size*ratio);
    
    
                                       
  }
    
}
  