class Check { 
  int id_device; // 
  int x;
  int y;
  int size; // Dimension (width and height) 
  color baseGray; // Default gray value 
  boolean checked = false; // True when the check box is selected 
  Check(int s, color b) { 
    size = s; 
    baseGray = b; 
  } 
// Updates the boolean variable checked 
  void press(float mx, float my) { 
    if ((mx >= x) && (mx <= x+size) && (my >= y) && (my <= y+size)) { 
      checked = !checked; // Toggle the check box on and off 
    } 
  } 
// Draws the box and an X inside if the checked variable is true 
  void display(int xp, int yp) {
   x=xp;
   y=yp; 
    stroke(255); 
    fill(baseGray); 
    rect(x, y, size, size); 
    if (checked == true) { 
      line(x, y, x+size, y+size); 
      line(x+size, y, x, y+size); 
    } 
  } 
  
  String escribe(boolean posicion) {
   String resultado="";
   if (posicion==true) {
    resultado="ON";
   } else {
    resultado="OFF";
   }
  return resultado; 
  }
} 
