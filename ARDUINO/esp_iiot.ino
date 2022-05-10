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
  int value = param.asInt ();
  digitalWrite(LED, value);
  Serial.println(value);
}

BLYNK_WRITE(V1)
{
  String value = param.asString();
  String lat, lon;
  
  for (int i = 0; i < value.length(); i++) {
    if (value.substring(i, i+1) == "o") {
      lat = value.substring(3, i-1);
      lon = value.substring(i+2);
      break;
    }
  }
  Serial.println(lat);
  Serial.println(lon);
}
