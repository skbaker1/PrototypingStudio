/*
* This is skeleton code for continuously reading a single float value [0,1] off serial
*
* By Jon Froehlich
* http://makeabilitylab.io
*
* Edited by Samantha Baker for team Alli8rs
* This program graphs the temperature and humidity from 3 different DHT 11 sensors
*/

import processing.serial.*;


// We communicate with the Arduino via the serial port
Serial _serialPort;

// Our serial port index (this will change depending on your computer)
final int ARDUINO_SERIAL_PORT_INDEX = 5;

float _currentVal = 0.5; // between [0,1], received from serial
float openHumidVal = 0;
float openTempVal = 0;
float greenhouseHumidVal = 0;
float greenhouseTempVal = 0;
float effectHumidVal = 0;
float effectTempVal = 0;
PImage bg;
int tempGraphScale = 465;
int humidGraphScale = 186;

void setup(){
  bg = loadImage("background.png");
 size(800, 500); 
 //fullScreen();

 // Open the serial port
 _serialPort = new Serial(this, Serial.list()[ARDUINO_SERIAL_PORT_INDEX], 9600);
}

void draw(){
   background(bg);
   noStroke();

// open air graph
 float openBarHeightTemp = tempGraphScale * -openTempVal;
 float openBarHeightHumid = humidGraphScale * -openHumidVal;
 fill(41,171,266); // blue
 rect(50, 410, 50, openBarHeightTemp);
 rect(320, 411, 50, openBarHeightHumid);
 
// greenhouse graph
 float greenhouseBarHeightTemp = tempGraphScale * -greenhouseTempVal;
 float greenhouseBarHeightHumid = humidGraphScale * -greenhouseHumidVal;
 fill(100,181,74); // pretty green
 rect(115, 410, 50, greenhouseBarHeightTemp);
 rect(385, 411, 50, greenhouseBarHeightHumid);

// greenhouse effect graph
 float effectBarHeightTemp = tempGraphScale * -effectTempVal;
 float effectBarHeightHumid = humidGraphScale * -effectHumidVal;
 fill(247,147,30); // orange
 rect(180, 410, 50, effectBarHeightTemp);
 rect(450, 411, 50, effectBarHeightHumid);

}

/**
* Called automatically when new data is received over the serial port.
*/
void serialEvent (Serial myPort) {
 try {
   // Grab the data off the serial port. See:
   // https://processing.org/reference/libraries/serial/index.html
   String inString = trim(_serialPort.readStringUntil('\n'));

   if(inString != null && inString.length() > 10){
     String humidity1 = inString.substring(0, 4); //<>//
     String temperature1 = inString.substring(6, 10);
     openHumidVal = float(humidity1) / 100.0;
     openTempVal = float(temperature1) / 100.0;
     
     String humidity2 = inString.substring(13, 17);
     String temperature2 = inString.substring(19, 23);
     greenhouseHumidVal = float(humidity2) / 100.0;
     greenhouseTempVal = float(temperature2) / 100.0;
     
     String humidity3 = inString.substring(26, 30);
     String temperature3 = inString.substring(32, 36);
     effectHumidVal = float(humidity3) / 100.0;
     effectTempVal = float(temperature3) / 100.0;
     
     
     //_currentVal = float(inString); // convert to a float
     //println("Read in: " + inString + " converted val: " + _currentVal);
     println(inString);
     delay(1000);
     
   }
 }
 catch(Exception e) {
   println(e);
 }
}
