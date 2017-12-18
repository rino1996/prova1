// variables declaration

   //muy importante
   int secret_number=111;

   //sensors
   int sens0 = 0;    // Light sensor
   int sens1 = 1;    // Humidity sensor
   int sens2 = 2;    // Temperature sensor

   //aux var
   int val0 = 0;
   int val1 = 0;
   int val2 = 0;

   int count = 0;
   
   //very important!!!!!!!!!!!!!
   int id_mota=1;
   const int ledPin = 13; // the pin that the LED is attached to
   int incomingByte;      // a variable to read incoming serial data into

   void setup(){  
   Serial.begin(19200);    // starts the serial port
   pinMode(ledPin, OUTPUT);
   //digitalWrite(ledPin, HIGH);
   }

   // function to send data

   void sendData(int pass, int id,int num, int data0,int data1,int data2){
   
   Serial.print(pass);  
   Serial.print(",");  
   Serial.print(id);
   //Serial.print(",");
   
   //Serial.print(num);
   
   Serial.print(",");
   Serial.print(data0);
   
   Serial.print(",");
   Serial.print(data1);
   
   Serial.print(",");
   Serial.print(data2);
      
   Serial.println("\n");      // end of message
   }

   void loop(){ 
   while (count <= 10000){
      val0 = analogRead(sens0);
      val1 = analogRead(sens1);
      val2 = analogRead(sens2);
      
      sendData(secret_number,id_mota,count, val0,val1,val2);

      delay(20000);
      count++;
      
      /*
      if (Serial.available() > 0) {
      delay(100);
     // read the oldest byte in the serial buffer:
     incomingByte = Serial.read();
     // if it's a capital H (ASCII 72), turn on the LED:
    if (incomingByte == char(72)) {
     digitalWrite(ledPin, HIGH);
     } 
     // if it's an L (ASCII 76) turn off the LED:
     if (incomingByte == char(76)) {
       digitalWrite(ledPin, LOW);
     }
     //Serial.print(incomingByte);
     //Serial.println("\n");
    }
    */

      
      }
   
    count = 0;
   
   
    
    
   
    
  }


