#include <WiFi.h>
#include <DHT.h>
#include <Firebase_ESP_Client.h>
#include "config.h"

// === DHT Sensor ===
#define DHTPIN 27
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);

// === Firebase ===
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// === Timing ===
unsigned long sendDataPrevMillis = 0;

void setup() {
  Serial.begin(115200);
  dht.begin();

  // Connect Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println("\nWi-Fi connected");

  // Firebase setup
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  if (millis() - sendDataPrevMillis > 5000) {
    sendDataPrevMillis = millis();

    float temp = dht.readTemperature();
    float hum = dht.readHumidity();

    if (isnan(temp) || isnan(hum)) {
      Serial.println("Failed to read from DHT sensor!");
      return;
    }

    Serial.printf("Temp: %.2f °C, Hum: %.2f %%\n", temp, hum);

    if (Firebase.ready()) {
      Serial.println("Firebase ready to use.");
      if (Firebase.RTDB.setFloat(&fbdo, "/ESP/Temperature", temp)) {
        Serial.println("Temperature uploaded!");
      } else {
        Serial.print("Temp error: ");
        Serial.println(fbdo.errorReason());
      }

      if (Firebase.RTDB.setFloat(&fbdo, "/ESP/Humidity", hum)) {
        Serial.println("Humidity uploaded!");
      } else {
        Serial.print("Humidity error: ");
        Serial.println(fbdo.errorReason());
      }

      if (Firebase.RTDB.setTimestamp(&fbdo, "/ESP/Timestamp")) {
        Serial.println("Timestamp uploaded!");
      } else {
        Serial.print("Timestamp error: ");
        Serial.println(fbdo.errorReason());
      }
    }
  }
}
