/*
 mcp9700a.h - Arduino Library for the Microchip MCP9700A
 
 The MCP9700A is an inexpensive ($0.36US each in 2009) 
 temperature sensor that puts out an analog voltage which
 corresponds to the temperature in Celsius. 
 
 The MCP9700A covers a range of -40C to +125C
 
 This library provides a class that provides easy retrieval
 of the measured temperature in either Celsius or Farenheit.

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
 
#ifndef mcp9700a_h
#define mcp9700a_h

#include "Wprogram.h"

class mcp9700a
{
    public:
        mcp9700a(int pin);
        float celsius();
        float farenheit();
    private:
        int _pin;
};

#endif
