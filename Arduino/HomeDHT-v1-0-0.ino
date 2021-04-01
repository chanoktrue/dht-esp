#include "DHT.h"
#include "ESP8266WiFi.h"
#include "PubSubClient.h"

// Config DHT22
#define DHTPIN 5
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);

// Config LED 3 color
#define blue D3
#define green D5
#define red D7

// Config WiFi
#define ssid "npswifi_ap"
#define pass "computer"

// Config MQTT Server
#define mqttServer "homenano.trueddns.com"
#define mqttPort 24347
#define mqttUser "roj"
#define mqttPassword "123456"

String  company = "NP";
String  location_id = "BANMOH";
String  thCode = "ESP01";


/*
#define mqttServer "110.170.42.146"
#define mqttPort 1883
#define mqttUser "admin"
#define mqttPassword "computer"
*/

WiFiClient wifiClient;
PubSubClient client(wifiClient);

void setup() {
  pinMode(blue, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(red, OUTPUT);
  digitalWrite(blue, LOW);
  digitalWrite(green, LOW); 
  digitalWrite(red, LOW); 

  digitalWrite(red, HIGH);
  connect();  
  
  setupMQTT();  
  setupDHT();
}

void loop() {
  loopDHT();
}



void setupMQTT() {
  client.setServer(mqttServer, mqttPort);
  if (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP8266Client", mqttUser, mqttPassword)) {
      Serial.println("connected");

      client.publish("dht/temperature", "Hello from ESP8266");       
      
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
      return;
    }
  } 
 
}

void setupDHT() {
  dht.begin();  
}

void loopDHT() {
  delay(2000);

  float h = dht.readHumidity();  
  float t = dht.readTemperature(); 
  float f = dht.readTemperature(true);

  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    digitalWrite(green, LOW);
    digitalWrite(red, HIGH);
    delay(100);
    digitalWrite(red, LOW);
    digitalWrite(green, HIGH);
    delay(100);
    return;
    }else{
     status_connect();
     delay(8000); 
  }

  // Compute heat index in Fahrenheit (the default)
  float hif = dht.computeHeatIndex(f, h);
  // Compute heat index in Celsius (isFahreheit = false)
  float hic = dht.computeHeatIndex(t, h, false);

 
  String humidity;
  humidity += h;
  client.publish("dht-ESP001/humidity", (char*) humidity.c_str());

  String temperature;
  temperature += t;
  client.publish("dht-ESP001/temperature", (char*) temperature.c_str());

  Serial.print(("Humidity: "));
  Serial.print(h);
  Serial.print(" %");
  
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(f);
  
  Serial.print(F("°F  Heat index: "));
  Serial.print(hic);
  Serial.print(F("°C "));
  Serial.print(hif);
  Serial.println(F("°F"));  
  delay(100);
  status_connect();
}

void connect()
{
  Serial.begin(9600);
  Serial.println("Starting...");
  WiFi.begin(ssid, pass);
   while (WiFi.status() != WL_CONNECTED) 
   {
      delay(250);
      digitalWrite(red, LOW);
      digitalWrite(blue, HIGH);
      Serial.print(".");
   } 
   digitalWrite(blue, LOW);
   Serial.println("WiFi connected");  
   Serial.println("IP address: ");
   Serial.println(WiFi.localIP());  
}

void status_connect(){

  if (WiFi.status() == 3) {
    digitalWrite(blue, LOW); //blue
    digitalWrite(green, HIGH); //green
    digitalWrite(red, LOW); //red
  }
  else if (WiFi.status() == 4) {
    digitalWrite(blue, HIGH); //blue
    digitalWrite(green, LOW); //green
    digitalWrite(red, LOW); //red
  }
  else if (WiFi.status() == 6) {
    digitalWrite(blue, LOW); //blue
    digitalWrite(green, LOW); //green
    digitalWrite(red, HIGH); //red
  }
  else {
   Serial.println("error");
  }
}
