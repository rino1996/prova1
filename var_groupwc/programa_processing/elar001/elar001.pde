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

//mysql configuration  
String user     = "elar";
String pass     = "elar";
String database = "elar";
//String server = "192.168.1.121";
//NOTA PARA WIRELESS GALICIA: OLLO CAMBIAR A IP DO SERVIOR DE MYSQL AQUI-------/
String server = "10.10.1.157";
//String server = "10.10.1.164";

//VARIABLE TEMPORAL ACORDARSE DE BORRAR
int contador_borrar=0;

int max_buttons=1000; //OLLO CON ESTO E O NUMERO DE NUMEROS QUE SE DAN DE ALTA TEMOS QUE PENSAR QUE OS ID_DEVICE NON PODEN SER MAIORES QUE ESTE NUMERO

//a clase serial
import processing.serial.*;
Serial myPort;  // The serial port

//imos a usar fontes
PFont font;

//iniciamos as variables

MySQL msql, msql_device, msql_execute, msql_serial, msql_serial_execute;

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

boolean[] pos_check;

int[] pos_scroll;

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

  msql = new MySQL( this, server, database, user, pass );
  msql.connect() ;
  
  msql_device = new MySQL( this, server, database, user, pass );
  msql_device.connect() ;
   
  msql_execute = new MySQL( this, server, database, user, pass );
  msql_execute.connect() ;
  
  msql_serial = new MySQL( this, server, database, user, pass );
  msql_serial.connect() ;
  
  msql_serial_execute = new MySQL( this, server, database, user, pass );
  msql_serial_execute.connect() ;

  if ( msql.connect() )
  {
    //CONFIGURATION
    msql.query( "SELECT * FROM configuration" );
    msql.next();

    width_default=msql.getInt( "screen_width" );
    height_default=msql.getInt( "screen_height" );
    println("width_default: "+width_default);
    println("height_default: "+height_default);
    int secret_number=msql.getInt("secret_number");
    println("secret_number: "+secret_number);
  } 

  size(width_default,height_default);

  //this looks better
  smooth();

  font=loadFont("Consolas-48.vlw"); 

  //ler no porto serie
  //por si acaso fallase temos a lista para saber que porto e
  println(Serial.list());
  //OLLO A VELOCIDADE E MOI IMPORTANTE PARA VER CORRECTAMENTE OS PARAMETROS
  myPort = new Serial(this, Serial.list()[0], 19200);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');

  //Paneles

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

  //a superfuncion NON QUEDA MAIS REMEDIO QUE DEFINIR AQUI
  numberPanels(); 

  check = new Check[max_buttons];

  pos_check= new boolean[max_buttons];

  pos_scroll= new int[max_buttons];

  scrollbar = new Scrollbar[max_buttons];
  draggingSlider = new boolean[max_buttons];

  //bulb
  bulb = new Bulb[max_buttons];

  if ( msql.connect() )
  {

    //vamos a calcular a primeira vez que se entra todas as posicions dos sensores


    int pos_corrector=110;

    //mentras existan paneis
    msql.query( "SELECT * FROM panels");
    while (msql.next()) {

      int pos_x_begin=200;
      int pos_y_begin=100;
      int total=0;

      int id_panel_temp=msql.getInt("id_panel");
      println("description: "+msql.getString("description"));

      //para cada panel imos ordenando por tipos

      //1) Entrada Dixital
      msql_device.query( "SELECT COUNT(*) AS total FROM devices WHERE device_type=0 AND io_type=1 AND id_panel="+id_panel_temp);
      msql_device.next();
      total=msql_device.getInt("total");
      println("borrar rap: "+total);
      if (total>0) {
      msql_device.query( "SELECT * FROM devices WHERE device_type=0 AND io_type=1 AND id_panel="+id_panel_temp);
      while (msql_device.next()) {
        int id_device_temp=msql_device.getInt("id_device");
        println("devices: "+id_device_temp);
        msql_execute.execute( "UPDATE devices SET pos_x="+pos_x_begin+", pos_y="+pos_y_begin+" WHERE id_device="+id_device_temp);  
        pos_y_begin=pos_y_begin+pos_corrector;
      }
      }

      //2) Saida Dixital
      msql_device.query( "SELECT COUNT(*) AS total FROM devices WHERE device_type=1 AND io_type=1 AND id_panel="+id_panel_temp);
      msql_device.next();
      total=msql_device.getInt("total");
      if (total>0) {
      msql_device.query( "SELECT * FROM devices WHERE device_type=1 AND io_type=1 AND id_panel="+id_panel_temp);
      while (msql_device.next()) {
        int id_device_temp=msql_device.getInt("id_device");
        println("devices: "+id_device_temp);
        msql_execute.execute( "UPDATE devices SET pos_x="+pos_x_begin+", pos_y="+pos_y_begin+" WHERE id_device="+id_device_temp);  
        pos_y_begin=pos_y_begin+pos_corrector;
      }
      }  

      //3) Entrada Analoxica
      msql_device.query( "SELECT COUNT(*) AS total FROM devices WHERE device_type=0 AND io_type=0 AND id_panel="+id_panel_temp);
      msql_device.next();
      total=msql_device.getInt("total");
      if (total>0) {
      msql_device.query( "SELECT * FROM devices WHERE device_type=0 AND io_type=0 AND id_panel="+id_panel_temp);
      while (msql_device.next()) {
        int id_device_temp=msql_device.getInt("id_device");
        println("devices entrada analoxica: "+id_device_temp);
        msql_execute.execute( "UPDATE devices SET pos_x="+pos_x_begin+", pos_y="+pos_y_begin+" WHERE id_device="+id_device_temp);  
        pos_y_begin=pos_y_begin+pos_corrector;
      }
      }

      //4) Saida Analoxica
      msql_device.query( "SELECT COUNT(*) AS total FROM devices WHERE device_type=1 AND io_type=0 AND id_panel="+id_panel_temp);
      msql_device.next();
      total=msql_device.getInt("total");
      if (total>0) {
      msql_device.query( "SELECT * FROM devices WHERE device_type=1 AND io_type=0 AND id_panel="+id_panel_temp);
      while (msql_device.next()) {
        int id_device_temp=msql_device.getInt("id_device");
        println("devices: "+id_device_temp);
        msql_execute.execute( "UPDATE devices SET pos_x="+pos_x_begin+", pos_y="+pos_y_begin+" WHERE id_device="+id_device_temp);  
        pos_y_begin=pos_y_begin+pos_corrector;
      }
      }
    }     


    //2) Saida Dixital
    msql.query( "SELECT id_device FROM devices WHERE device_type=1 AND io_type=1");
    while (msql.next()) {
      check[msql.getInt("id_device")] = new Check(50, color(0));
    }     
    //4) Saida Analoxica
    msql.query( "SELECT id_device, pos_x, pos_y FROM devices WHERE device_type=1 AND io_type=0");
    while (msql.next()) {
      //temos que recalcular esto OLLO!!!!
      //primeiro para cada un dos paneis
      //scrollbar[msql.getInt("id_device")] = new Scrollbar(msql.getInt("pos_x"), msql.getInt("pos_y"), 80, 10, msql.getInt("min_value"), msql.getInt("max_value"));
      scrollbar[msql.getInt("id_device")] = new Scrollbar(msql.getInt("pos_x"), msql.getInt("pos_y"), 80, 10, 0.0, 100.0);
      draggingSlider[msql.getInt("id_device")]=false;
    }
  }
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


  if ( msql.connect() )
  {

    //1) Entrada dixital
    //defnimos alto e ancho
    int bulb_height=40;
    int bulb_widht=40;
    msql.query( "SELECT * FROM devices WHERE device_type=0 AND io_type=1 AND id_panel="+section);
    while (msql.next()) {
      bulb[msql.getInt("id_device")]= new Bulb (msql.getInt("default_value"), msql.getString("description"), msql.getInt("pos_x"), msql.getInt("pos_y"), bulb_height, bulb_widht);
      bulb[msql.getInt("id_device")].display();
    }

    //2) Saida dixital
    //defnimos alto e ancho
    int check_height=80;
    msql.query( "SELECT * FROM devices WHERE device_type=1 AND io_type=1 AND id_panel="+section);
    while (msql.next()) {
      check[msql.getInt("id_device")].display(msql.getInt("pos_x"),msql.getInt("pos_y"));
      pos_check[msql.getInt("id_device")]=check[msql.getInt("id_device")].checked;
      text(check[msql.getInt("id_device")].escribe(pos_check[msql.getInt("id_device")])+" "+msql.getString("description"),msql.getInt("pos_x"), msql.getInt("pos_y")+check_height);
    }     

    //3) Entrada Analoxica
    msql.query( "SELECT * FROM devices WHERE device_type=0 AND io_type=0 AND id_panel="+section);
    while (msql.next()) {
      int id_device=msql.getInt( "id_device") ;
      double default_value=msql.getDouble("default_value");
      String name_device=msql.getString( "name") ;  
      String description_device=msql.getString( "description") ;  
      text(name_device+" "+id_device+" "+description_device+" valor: "+default_value,msql.getInt("pos_x"),msql.getInt("pos_y"));
    }     

    //4) Saida Analoxica
    int scroll_height=35;
    msql.query( "SELECT * FROM devices WHERE device_type=1 AND io_type=0 AND id_panel="+section);
    while (msql.next()) {
      pos_scroll[msql.getInt("id_device")] = int(scrollbar[msql.getInt("id_device")].getPos()); 
      scrollbar[msql.getInt( "id_device")].update(mouseX, mouseY); 
      scrollbar[msql.getInt( "id_device")].display();
      text(nf(pos_scroll[msql.getInt( "id_device")], 3)+" "+msql.getString("description"), msql.getInt("pos_x"), msql.getInt("pos_y")+scroll_height);
    }
  }
}

void mousePressed() { 
  if (b_en.press() == true) { 
    lang = 0;
  } 
  if (b_gl.press() == true) { 
    lang = 1;
  }
  if (b_es.press() == true) { 
    lang = 2;
  }

  for (int i = 0; i < panel.length; i++) {
    if (panel[i].press() == true) { 
      section = i;
    }
  }

  if ( msql.connect() )
  {

    //2) Saida dixital
    //defnimos alto e ancho

    msql.query( "SELECT * FROM devices WHERE device_type=1 AND io_type=1 AND id_panel="+section);
    while (msql.next()) {
      check[msql.getInt("id_device")].press(mouseX, mouseY);
    }     

    //4) Saida Analoxica
    msql.query( "SELECT id_device FROM devices WHERE device_type=1 AND io_type=0");
    while (msql.next()) {
      scrollbar[msql.getInt("id_device")].press(mouseX, mouseY);
    }
  }
} 

void mouseReleased() { 
  b_en.release();
  b_es.release();
  b_gl.release();
  for (int i = 0; i < panel.length; i++) {
    panel[i].release();
  }

  if ( msql.connect() )
  {


    //4) Saida Analoxica
    msql.query( "SELECT id_device FROM devices WHERE device_type=1 AND io_type=0");
    while (msql.next()) {
      scrollbar[msql.getInt("id_device")].release(); 
      draggingSlider[msql.getInt("id_device")]=false;
    }
  }
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

    //o primeiro de todo e definir ben o inicio e fin
    int super_x=200;

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

      //imos ter unha estructura semellante para poder ser mais rapidos
      //1) Entrada Dixital
      msql_device.query( "SELECT * FROM devices WHERE device_type=0 AND io_type=1 AND id_panel="+id_panel);
      while (msql_device.next()) {
        println(msql_device.getInt("id_device"));
      }
    }


    return 1;
  } 
  else {

    return 0;
  }
}


void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);

  println(myString);

  int[] list = int(split(myString, ','));

  for (int i = 0; i < list.length; i++) {
    println("i: "+i+" valor lista: "+list[i]);
  }

  if (list[0]==111) {
    println("Esta en nuestro sistema");
    //a mota
    if ( msql.connect() )
    {
      
      int total=0;

      //Motas
      //1
      updateFromSerial(list[1], 1, list[2]);
      
      //2
      updateFromSerial(list[1], 2, list[3]);
      
      //3
      updateFromSerial(list[1], 3, list[4]);
      
    }
  }
}

void updateFromSerial(int mote, int order, int value_device) {
      
      //mote list[1]
      //order
      int total=0;

      msql_serial.query( "SELECT COUNT( * ) AS total FROM devices WHERE id_mote="+mote+" AND read_order=3");
      msql_serial.next();
      total=msql_serial.getInt("total");
      if (total>0) {
      msql_serial.query( "SELECT id_device FROM devices WHERE id_mote="+mote+" AND read_order="+order);
      while (msql_serial.next()) {
        int id_device_mote=msql_serial.getInt("id_device");
        msql_serial_execute.execute("UPDATE devices SET default_value="+value_device+" WHERE id_device="+id_device_mote+" LIMIT 1");
        println("INSERT INTO volatile (id_volatile, id_device, date, value) VALUES('',"+id_device_mote+", UNIX_TIMESTAMP(NOW()), "+value_device+")");
        msql_serial_execute.execute("INSERT INTO volatile ( id_device, date, value) VALUES ("+id_device_mote+", UNIX_TIMESTAMP(NOW()), "+value_device+")");
        msql_serial_execute.execute("INSERT INTO records ( id_device, date, value) VALUES ("+id_device_mote+", UNIX_TIMESTAMP(NOW()), "+value_device+")");
      }
      }
}
