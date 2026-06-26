# Virtual Display
## MQTT IoT Dashboard for Real-Time Monitoring and Control

Virtual Display is an Android application that works as a real-time MQTT dashboard for IoT devices, allowing users to monitor sensors and control embedded systems without the need for a physical display.

The idea behind the project is to transform a smartphone into a virtual display for IoT systems, providing a flexible and configurable interface for telemetry and device control.

## 🚀 Features
* MQTT communication support
* Multiple broker management with persistence
* Real-time data visualization
* Dynamic dashboard configuration based on device data types
* Interactive buttons for sending MQTT commands
* JSON-based message protocol
* Real-time charts and sensor monitoring

## 📡 Communication
The application uses MQTT protocol as the main communication layer. /
All messages are exchanged in JSON format, enabling flexible integration with different devices and sensors. /
For more informations, see ESP32 Example Project.

## 📱 Platform
Android (currently supported)

## 🧪 Project Status
This project is currently under development but already functional for testing and integration with IoT devices. /
A stable release will be published soon on the Play Store.

## 📦 ESP32 Example Project
This repository: https://github.com/GabrielComim/virtualDisplayDevice.git includes an example firmware for ESP32-S3 using ESP-IDF, and HiveMQ cloud as a broker. /
The purpose of the firmware is to demonstrate how to integrate IoT devices with Virtual Display using MQTT.

## 🔍 SEO Keywords
* MQTT dashboard
* Flutter MQTT
* ESP32 MQTT
* IOT dashboard
* Sensor monitoring
* Industrial monitoring
* Real-time telemetry

## 🎯 Vision
The goal of Virtual Display is to eliminate the need for physical screens in IoT projects—particularly during initial development—by providing a flexible, mobile-based visualization layer for embedded systems.

## 📌 License
This project is free and open for use in learning and development.
