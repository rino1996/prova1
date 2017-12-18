/*
 mcp9700a_temperature
 Demonstrates the mcp9700a Arduino library
 Created by Tim McDonough, 19-November-2009
 
 The Microchip MCP9700A is an inexpensive temperature sensor
 that will measure from -40C to +125C.
 
 This program reads a sensor connected to Analog Input 0 and 
 sends the Celsius and Farenheit values to the serial monitor
 every 2 seconds.
 
 For each MCP9700A in your system you must instantiate an
 instance of the sensor using the analog input port to
 which it is connected, i.e.--
 
     mcp9700a <name_of_the_instance>(<pin_number>);
     mcp9700a indoor(0);
     mcp9700a outdoor(1);
     
 ---------------------------------------------------------------------
 Copyright (C) 2009    Tim McDonough     tmcdonough@gmail.com

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ---------------------------------------------------------------------
 */

#include <mcp9700a.h>

#define INTERVAL 2000    // 2 seconds

long prevMillis;           // for main timing loop
mcp9700a temperature(0);   // temperature sensor instance

void setup()
{
  // Serial port is used to transmit converted data
  Serial.begin(9600);

  // Put a reasonable value into our timing variable so the
  // delay before the main loop isn't something wacky.
  prevMillis = millis();
}

void loop()
{
  /*
   The portion of the main loop below executes once every
   'INTERVAL' milliseconds.
   */
  if ((millis() - prevMillis) > INTERVAL) 
  {
    prevMillis = millis();
    
    // Measure and show the temperature with a little 
    // formatting.
    Serial.print(temperature.celsius());
    Serial.print("C, ");
    Serial.print(temperature.farenheit());
    Serial.println("F.");
    
  } // if ((millis() - prevMillis) > INTERVAL) ...  
}
