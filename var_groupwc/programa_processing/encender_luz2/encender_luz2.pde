/*

arquivo para probar cousas
do proxecto eLar

*/
import processing.serial.*;

int lf = 10;    // Linefeed in ASCII
Serial myPort;


PFont font_titulo;

String myString;

int sensorValue=0;
int contador=0;
int graphPosition=0;


//CHECK 01 -> definimos o boton

Check check0;


//zona cores
color branco = color(255, 255, 255);
color amarelo = color(242, 204, 47);
color negro = color(0,0,0);
color roxo = color(255,0,125);
color roxo2 = color(255,0,0);
color verde= color(125,255,0);
color azul = color (0,0, 255);

void setup() {
 //un tamaño medio
 size(200,200);
 
  println(Serial.list());

//idioma por defecto
 smooth();
 font_titulo=loadFont("Consolas-48.vlw"); 

 //CHECK 02 -> new boton
 check0 = new Check(100, 10, 50, color(0));
  myPort = new Serial(this, Serial.list()[0], 19200);
 // myPort = new Serial(this, Serial.list()[2], 38400);
  myPort.clear();
 
 
}

void draw() {
  
  background(amarelo);
  fill(branco);
  textFont(font_titulo);
  textSize(11);
  
  //CHECK 03 -> debuxamos un boton
  boolean pos0=check0.checked;
  check0.display();
  text(check0.escribe(pos0),20, 80);
  
 while (myPort.available() > 0) {
    myString = myPort.readStringUntil(lf);
    if (myString != null) {
      println(myString);
    }
  }
  
}


void mousePressed() { 
 
  //CHECK 04 -> ao presionar o boton 
  check0.press(mouseX, mouseY);
  
 
}
