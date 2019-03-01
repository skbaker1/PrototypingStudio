/*
* This is code is adapted from the following tutorial on how to implement the DHT 11 sensor: 
* http://www.circuitbasics.com/how-to-set-up-the-dht11-humidity-sensor-on-an-arduino/
*
* Edited by Samantha Baker for team Alli8rs
* This program captures the temperature and humidity from 3 different DHT 11 sensors
*/

#include "dht.h"
#define dht_apin1 A0 // Analog Pin sensor is connected to
#define dht_apin2 A1
#define dht_apin3 A2

dht DHT1;
dht DHT2;
dht DHT3;

void setup(){
 
  Serial.begin(9600);
  delay(500);//Delay to let system boot
  Serial.println("DHT11 Humidity & temperature Sensor\n\n");
  delay(1000);//Wait before accessing Sensor
 
}//end "setup()"
 
void loop(){
  //Start of Program 

    // open air (yellow wire)
    DHT1.read11(dht_apin1);
    // greenhouse (orange wire)
    DHT2.read11(dht_apin2);
    // greenhouse effect (green wire)
    DHT3.read11(dht_apin3);
    
    Serial.print(DHT1.humidity);
    Serial.print("%");
    Serial.print(DHT1.temperature); 
    Serial.print("C ");

    Serial.print(DHT2.humidity);
    Serial.print("%");
    Serial.print(DHT2.temperature); 
    Serial.print("C ");
 
    Serial.print(DHT3.humidity);
    Serial.print("%");
    Serial.print(DHT3.temperature); 
    Serial.print("C ");
    Serial.println("");
    delay(2000);//Wait 2 seconds before accessing sensors again.
 
  //Fastest should be once every two seconds.
 
}// end loop() 
