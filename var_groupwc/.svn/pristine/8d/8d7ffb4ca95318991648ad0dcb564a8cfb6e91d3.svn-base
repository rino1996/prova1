/*
 mcp9700a.cpp - Arduino Library for the Microchip MCP9700A 
 temperature sensor.
 
 Version 1.0, 19-November-2009, Tim McDonough

 Copyright (C) 2009  Tim McDonough   tmcdonough@gmail.com

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
 */

#include "Wprogram.h"
#include "mcp9700a.h"

// constructor
mcp9700a::mcp9700a(int pin)
{
    _pin = pin;
    analogReference(DEFAULT);
}

/*
 celsius() -- converts ADC counts into degrees Celsius
 This function is designed for the Microchip MCP9700A temperature
 sensor. The ADC uses a Vref of 5.0 Volts and the output of the
 MCP9700A is fed directly to an ADC input.
 
 Algorithm:
 Multiply ADC counts by voltsPerBit (5.0 / 1024)
 Subtract volts equivelent to Zero Celsius if temp > 0C
 Divide by MCP9700A "millivolts per degree"   
 */

float mcp9700a::celsius()
{
  #define VOLTS_PER_BIT    0.00488
  #define ZERO_C_VOLTS     0.50000
  #define MV_PER_DEGREE_C  0.01000

  float tmpResult;
  
  tmpResult = (float)analogRead(_pin) * VOLTS_PER_BIT;
  
  if (tmpResult > ZERO_C_VOLTS) {
    return ((tmpResult - ZERO_C_VOLTS) / MV_PER_DEGREE_C);
  }
  else {
    return (tmpResult / MV_PER_DEGREE_C);
  }
}


/*
 farenheit() -- converts temperature from Celsius to Farenheit
 Note: 1.8 = 9/5
 */

float mcp9700a::farenheit()
{
    return (celsius() * 1.8) + 32.0;
}
