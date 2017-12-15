/*
v001

eLAR

A Bdunk & Wireless Galicia ´s Project

-- Free Domotic Sistem --

*/


//imos a escribir todo en galego (menos os nomes das variables), despois si o liberamos facemos a traduccion


//data base SQL
//necesitmaos esta libreria para MySQL
import de.bezier.data.sql.*;

int contador_borrar=0;

//a clase serial
import processing.serial.*;
Serial myPort;  // The serial port

//imos a usar fontes
PFont font;

//iniciamos as variables

MySQL msql;

Button b_en, b_es, b_gl;

Check[] check;

Button[] panel;

boolean[] bos_panel;

String[] despription_panel;

//definimos as entradas dixitais 0,0
Bulb[] bulb;

Scrollbar[] scrollbar;
boolean[] draggingSlider;
int[] pos;

Rule rule;

int width_default=800;
int height_default=600;

//colors zone
color white_color = color(255, 255, 255);
color yellow_color = color(242, 204, 47);
color black_color = color(0,0,0);
color red_color_01 = color(255,0,125);
color red_color_02 = color(255,0,0);
color green_color = color(125,255,0);
color blue_color = color (0,0, 255);

//color button
color button_gray_color=color(204);
color button_on_gray_color=color(255);
color button_press_gray_color=color(0);

//size button
int button_width=135;
int button_height=35;
int button_width_min=38;
int button_height_min=button_height;

//init button positions
int button_x=10;
int button_y=60;
int button_separation=10;
int button_x_min=20;
int button_reviser=6;
int button_x_lang=width_default-150;
int button_y_lang=4;
int button_lang_separation=5;
int button_lang_adjustment=0;

//que botón está seleccionado?
boolean bos_en=false;
boolean bos_es=false;
boolean bos_gl=false;
boolean bos_home=false;
boolean bos_about_us=true;
boolean bos_services=false;
boolean bos_proyects=false;
boolean bos_contact=false;

//english
int lang = 0;

//welcome to home :-)
int section=0;

//other vars
int y = year(); //the year
int panel_number;

void setup() {
  
  //mysql configuration  
   String user     = "elar";
   String pass     = "elar";
   String database = "elar";
   String server = "192.168.1.121";
   //String server = "10.10.1.157";

  msql = new MySQL( this, server, database, user, pass );
  msql.connect() ;
  
  if ( msql.connect() )
    {
        //CONFIGURATION
        msql.query( "SELECT * FROM configuration" );
        msql.next();
        
        width_default=msql.getInt( "screen_width" );
        height_default=msql.getInt( "screen_height" );
        println("width_default: "+width_default);
        println("height_default: "+height_default);
    } 
 
   size(width_default,height_default);
   
   //this looks better
   smooth();
   
   font=loadFont("Consolas-48.vlw"); 
   
   
   //cargamos todo o necesario
   //entradas dixitais
   
   
   
   //ler no porto serie
   //por si acaso fallase temos a lista para saber que porto e
   println(Serial.list());
   myPort = new Serial(this, Serial.list()[0], 19200);

   // read bytes into a buffer until you get a linefeed (ASCII 10):
   myPort.bufferUntil('\n');
   
   if ( msql.connect() )
    {
        //CONFIGURATION
        msql.query( " SELECT COUNT( * ) AS panel_number FROM panels " );
        msql.next();
        
        //number of panels
        panel_number=msql.getInt("panel_number");
        panel_number++;
        println("panel_number: "+panel_number);

   } 
   panel = new Button[panel_number];
   
   bos_panel = new boolean[panel_number];
   
   for (int i = 0; i < panel.length; i++) {
     bos_panel[i]=false; 
   }
   
   despription_panel = new String[panel_number];
   
   numberPanels(); 

   check = new Check[1];
   check[0] = new Check(200, 240, 50, color(0));
   
   scrollbar = new Scrollbar[1];
   draggingSlider = new boolean[1];
   scrollbar[0] = new Scrollbar(200, 350, 80, 10, -40.0, 50.0);
   draggingSlider[0]=false;

   
}


void draw() {
 
  rule = new Rule();
  
  background(yellow_color);
  fill(white_color);
  textFont(font);
  
  //header
  fill(0);
  stroke(0);
  rect(0,0,width_default,50);
  textSize(30);
  fill(white_color);
  text(l_page_title[lang],10,33); 
  
  //slogan
  textSize(18);
  text("["+l_slogan[lang]+"]", 250, 30); 
  
  //the footer
  fill(black_color);
  textSize(11);
  text(l_footer[lang]+" "+y, 10,height_default-20);
  
  //lang buttons
  textSize(18);
  
  
  
  b_en = new Button(button_x_lang, button_y_lang+1*(button_lang_separation), button_width_min, button_height_min, button_gray_color, button_on_gray_color, button_press_gray_color, "EN", bos_en, button_lang_adjustment);
  b_gl = new Button(button_x_lang+1*(button_lang_separation+button_width_min), button_y_lang+1*(button_lang_separation), button_width_min, button_height_min, button_gray_color, button_on_gray_color, button_press_gray_color, "GL", bos_gl, button_lang_adjustment);
  b_es = new Button(button_x_lang+2*(button_lang_separation+button_width_min), button_y_lang+1*(button_lang_separation), button_width_min, button_height_min, button_gray_color, button_on_gray_color, button_press_gray_color, "ES", bos_es, button_lang_adjustment);
  
  buttonsOn();
   
   switch (section) { 
     case 0: //about us
      show_about_us();
      int last_number=panel.length-1;
     break;
    }
  
  
    
  
  
  
  text(despription_panel[section], 200, 80);
  
  initButtons();
  
  bulb = new Bulb[1];
  bulb[0] = new Bulb(false,"Bombilla tipo",200, 100, 80, 80);
  
  if (section==1) {
    bulb[0].display();
    check[0].display();
    boolean pos0=check[0].checked;
    text(check[0].escribe(pos0),350, 270);
    pos = new int[1];
    pos[0] = int(scrollbar[0].getPos()); 
    scrollbar[0].update(mouseX, mouseY); 
    scrollbar[0].display(); 
    text(nf(pos[0], 3)+" ºC", 350, 360);
  }
  
  if (section==2) {
     if ( msql.connect() )
    {
        //CONFIGURATION
        msql.query( "SELECT * FROM devices WHERE device_type=0 AND io_type=0" );
        
        int h = 120;
        int i=0;
        while (msql.next()) {
        
          int id_device=msql.getInt( "id_device") ;
          double default_value=msql.getDouble("default_value");
          String name_device=msql.getString( "name") ;  
          String description_device=msql.getString( "description") ;  
          text(name_device+" "+id_device+" "+description_device+" valor: "+default_value,200,120+h*i);
          
          i++;
        }
        
    }
  }
  
  
 
  
   
  
}

void mousePressed() { 
  if (b_en.press() == true) { lang = 0; } 
  if (b_gl.press() == true) { lang = 1; }
  if (b_es.press() == true) { lang = 2; }
  
  for (int i = 0; i < panel.length; i++) {
    if (panel[i].press() == true) { section = i; }
  }
  
  check[0].press(mouseX, mouseY);
  scrollbar[0].press(mouseX, mouseY);  
  
} 

void mouseReleased() { 
  b_en.release();
  b_es.release();
  b_gl.release();
  for (int i = 0; i < panel.length; i++) {
    panel[i].release(); 
  }
  scrollbar[0].release(); 
  draggingSlider[0]=false;


}

void initButtons() {
  b_en.update();
  b_es.update();
  b_gl.update();
  b_en.display();
  b_es.display();
  b_gl.display();
  
  for (int i = 0; i < panel.length; i++) {
    panel[i].update(); 
    panel[i].display();
  }
  
}

void buttonsOn() {
   switch (lang) { 
     case 0:
      bos_en=true;
      bos_es=false;
      bos_gl=false;
     break;
     case 1:
      bos_en=false;
      bos_es=false;
      bos_gl=true;
     break;
     case 2:
      bos_en=false;
      bos_es=true;
      bos_gl=false;
     break;
   }
   
   bos_panel[section]=true;
   
 }


int numberPanels () {
   if ( msql.connect() )
    {
        //CONFIGURATION
        msql.query( "SELECT * FROM panels" );
               
        int i=0;

        panel[i] = new Button(button_x, button_y+i*(button_separation+button_height), button_width, button_height, button_gray_color, button_on_gray_color, button_press_gray_color, l_about_us[lang], bos_panel[i], button_reviser);
         
         despription_panel[i]="";
        
        while (msql.next()) {
          
          i++;
          
          int id_panel=msql.getInt( "id_panel" );
          String name=msql.getString( "name") ;
          println("id_panel:"+id_panel);
        
          panel[i] = new Button(button_x, button_y+i*(button_separation+button_height), button_width, button_height, button_gray_color, button_on_gray_color, button_press_gray_color, name, bos_panel[i], button_reviser);
          
          despription_panel[i]=msql.getString( "description");
       
      }
        
              
       return 1;

   } else {
     
       return 0; 
       
   }
}


void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
    myString = trim(myString);
 
   println(myString);
 
 /*
    // split the string at the commas
    // and convert the sections into integers:
    int sensors[] = int(split(myString, ','));

    // print out the values you got:
    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t"); 
    }
    // add a linefeed after all the sensor values are printed:
    println();
    if (sensors.length > 1) {
      xpos = map(sensors[0], 0,1023,0,width);
      ypos = map(sensors[1], 0,1023,0,height);
      fgcolor = sensors[2];
    }
    // send a byte to ask for more data:
    myPort.write("A");
   */
  }



