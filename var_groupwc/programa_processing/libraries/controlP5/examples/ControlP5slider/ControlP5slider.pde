import controlP5.*;


ControlP5 controlP5;

int myColorBackground = color(0,0,0);

int sliderValue = 100;

void setup() {
  size(400,400);
  controlP5 = new ControlP5(this);
 Slider s = controlP5.addSlider("slider",100,167,128,100,160,10,100);
  s = controlP5.addSlider("sliderValue",0,255,128,200,200,10,100);
}

void draw() {
  background(myColorBackground);
  fill(sliderValue);
  rect(0,0,width,100);
}

void slider(float theColor) {
  myColorBackground = color(theColor);
  println("a slider event. setting background to "+theColor);
}
