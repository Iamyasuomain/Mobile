# Mobile Project

## Description

This is a cross-platform mobile application built using Flutter. It supports Android, iOS, macOS, Windows, and web platforms.

## Features

- Multi-platform support
- Modular architecture
- Easy to extend and maintain
- Integration with ESP devices
- Server-based data processing

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/Iamyasuomain/Mobile.git
   ```
2. Navigate to the project directory:
   ```bash
   cd mobile_project
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

## Server Setup

1. Ensure you have Python installed on your system.
2. Navigate to the `server` directory:
   ```bash
   cd server
   ```
3. Install required Python packages:
   ```bash
   pip install -r requirements.txt
   ```
4. Start the server:
   ```bash
   python server.py
   ```
5. The server will run on `http://localhost:5000` by default.

## ESP Configuration

1. Flash the ESP device with the provided firmware located in the `esp` directory.
2. Update the Wi-Fi credentials in the firmware code:
   ```cpp
   const char* ssid = "YourWiFiSSID";
   const char* password = "YourWiFiPassword";
   ```
3. Ensure the ESP device is connected to the same network as the server.
4. The ESP will send data to the server's endpoint at `http://<server-ip>:5000`.

## Usage

1. Run the application:
   ```bash
   flutter run
   ```
2. For platform-specific builds, use:
   - Android: `flutter build apk`
   - iOS: `flutter build ios`
   - Web: `flutter build web`


