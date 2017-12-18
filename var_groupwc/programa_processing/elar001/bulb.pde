PImage img;

class Bulb { 
  int o_o;
  String des;
  int x;
  int y;
  int h;
  int w;
  Bulb (int on_off, String description, int xp, int yp, int hp, int wp) { 
    o_o = on_off; 
    des = description;  
    x=xp;
    y=yp;
    h=hp;
    w=wp;
  } 
  
  void display () {
  
      if (o_o==0) {
      
        img=loadImage("bulb_off.jpg");
               
      } else {
      
        img=loadImage("bulb_on.jpg");
        
      }
      
      image(img, x, y, w, h);
 
      text(des,x,y+h+20);
  
  }
  
}
