# Weatherly - A Flutter Weather App

## Overview
Weatherly is a real-time weather app built using Flutter. It fetches weather data based on the user's current location or a specified city using the OpenWeatherMap API. The app provides temperature, weather conditions, and dynamic animations based on the weather state.

## Features
- Fetches real-time weather data using OpenWeatherMap API.
- Automatically detects the user's current city via geolocation.
- Displays temperature, city name, and weather condition.
- Uses Lottie animations to visualize different weather conditions.
- Aesthetic UI with a gradient background and network image handling.

## Installation
To run this project on your local machine:
1. Clone the repository:
   ```sh
   git clone https://github.com/HuzaifaLatif13/Flutter-App-Development.git
   ```
2. Navigate to the project directory:
   ```sh
   cd Flutter-App-Development
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Replace the API key in `weather_service.dart`:
   ```dart
   final _weatherService = WeatherService('YOUR_API_KEY');
   ```
5. Run the app:
   ```sh
   flutter run
   ```

## Dependencies
This project uses the following dependencies:
- `geolocator`: For fetching the user's current location.
- `geocoding`: To convert coordinates into city names.
- `http`: For making API requests to OpenWeatherMap.
- `lottie`: To display animations based on weather conditions.

## Screenshots
(Add relevant screenshots here)

## Contributions
Feel free to fork the repository and submit pull requests for improvements or new features!

## License
This project is licensed under the MIT License.

---
Happy Coding! 🚀