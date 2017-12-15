class Button { 
  int x, y; // The x- and y-coordinates 
  int xsize; // Dimension (width) 
  int ysize; // Dimension (width) 
  color baseGray; // Default gray value 
  color overGray; // Value when mouse is over the button 
  color pressGray; // Value when mouse is over and pressed 
  boolean over = false; // True when the mouse is over 
  boolean pressed = false; // True when the mouse is over and pressed 
  String texto_boton;
  boolean on_section;
  int corrector;
  Button(int xp, int yp, int w, int h, color b, color o, color p, String t, boolean os, int corr) { 
    x = xp; 
    y = yp; 
    xsize = w; 
    ysize = h;
    baseGray = b; 
    overGray = o; 
    pressGray = p; 
    texto_boton =t;
    on_section=os;
    corrector=corr;
    
  } 
// Updates the over field every frame 
  void update() { 
    if ((mouseX >= x) && (mouseX <= x+xsize) && 
        (mouseY >= y) && (mouseY <= y+ysize)) { 
      over = true; 
    } else { 
      over = false; 
    } 
  }
  
  boolean press() { 
    if (over == true) { 
      pressed = true; 
      return true; 
    } else { 
      return false; 
    } 
  } 
  void release() { 
    pressed = false; // Set to false when the mouse is released 
  } 
  void display() { 
    if (pressed == true) { 
      fill(pressGray); 
    } else if (over == true) { 
      fill(overGray); 
    } else { 
      fill(baseGray); 
    } 
    if (on_section == true) {
      fill(overGray);
    }
    stroke(255); 
    rect(x, y, xsize, ysize); 
    fill(0);
    text(texto_boton, x+5, y+(ysize/2)+corrector);
  } 
} 
