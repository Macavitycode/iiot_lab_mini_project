#define LED D0

#define BLYNK_TEMPLATE_ID "TMPLLv_XU5PA"
#define BLYNK_DEVICE_NAME "Esp32"
#define BLYNK_AUTH_TOKEN "uubBmBxi_M4kF7bvyLgHCz1_PUEqsPJ_"

#define BLYNK_PRINT Serial

#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

char auth[] = BLYNK_AUTH_TOKEN;

char ssid[] = "Shashank";
char pass[] = "        ";

bool pinstate = false;

void setup()
{
  Serial.begin(115200);
  Blynk.begin(auth, ssid, pass);
  pinMode(LED, OUTPUT);
  digitalWrite(LED, pinstate);
}

void loop()
{
  Blynk.run();
}

BLYNK_WRITE(V0)
{
  int value = param.asInt();
  digitalWrite(LED, value);
  Serial.println(value);
}

int lmotor, rmotor;
int lmotorpwm, rmotorpwm;

BLYNK_WRITE(V1)
{
  String value = param.asString();
  for(int i = 0; i<value.length(); i++)
  {
    if(value[i] == '-')
    {
      lmotor = value.substring(0, i).toInt();
      rmotor = value.substring(i+1).toInt();
    } 
  }
  
  lmotorpwm = map(lmotor, 0, 100, 0, 255);
  rmotorpwm = map(rmotor, 0, 100, 0, 255);

  analogWrite(D5, lmotorpwm);
  analogWrite(D6, rmotorpwm);
  
//  Serial.println();
}
