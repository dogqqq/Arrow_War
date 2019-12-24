#include <Wire.h>
#include "ArduinoJson.h"

#define ZLpin 5
#define ZRpin 4
#define Lpin 7
#define Rpin 2
#define VLpin 6
#define VRpin 3

#define nothing 512
#define bias 100

#define LX A0
#define LY A1
#define RX A3
#define RY A2

#define DRV2605L_ADDR_R 0xB5
#define DRV2605L_ADDR_W 0xB4

const int doc_cap = JSON_OBJECT_SIZE(8);
const int ddoc_cap = JSON_OBJECT_SIZE(2);
StaticJsonDocument<doc_cap> doc;
StaticJsonDocument<ddoc_cap> ddoc;
char JSONString[256];

void LRA_once(int pin) {

  digitalWrite(pin,HIGH);
  //delay(1);
  digitalWrite(pin,LOW);
  
}

float caly(int val) {

  if(val > (nothing + bias)) return -(float)(val-nothing)/(4096.0-nothing);
  if(val < (nothing - bias)) return (float)(nothing-val)/(4096.0-nothing);
  return 0.0 ;
}

float calx(int val) {

  if(val > (nothing + bias)) return (float)(val-nothing)/(4096.0-nothing);
  if(val < (nothing - bias)) return -((float)(nothing-val)/(4096.0-nothing));
  return 0.0 ;
}

void setup() {
  Serial.begin(115200);
  Wire.begin();

  pinMode(LX,INPUT);
  pinMode(LY,INPUT);
  pinMode(RX,INPUT);
  pinMode(RY,INPUT);

  pinMode(VLpin,OUTPUT);
  pinMode(VRpin,OUTPUT);
  pinMode(ZLpin,INPUT);
  pinMode(ZRpin,INPUT);
  pinMode(Lpin,INPUT);
  pinMode(Rpin,INPUT);

}

void loop() {
  
 
  Serial.println(analogRead(LX));

  delayMicroseconds(1000);
  //Serial.write(JSONString);

//  String inStr = Serial.readString(); 
//  deserializeJson(ddoc,inStr.c_str());
//  
//  if(ddoc["l"]) LRA_once(VLpin);
//  if(ddoc["r"]) LRA_once(VRpin);
  
}
