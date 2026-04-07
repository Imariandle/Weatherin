<div align="center">

# 🌤 Wheaterin

**A minimal, glassmorphism weather app built with Flutter**

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat&logo=dart&logoColor=white)
![OpenWeatherMap](https://img.shields.io/badge/OpenWeatherMap-API-orange?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

</div>

-----

## ✨ Features

- **Live weather data** via OpenWeatherMap API
- **Auto-detects your location** using GPS (no typing needed)
- **Dynamic Lottie animations** that change with the weather condition — sunny, cloudy, rainy, stormy
- **Adaptive gradient backgrounds** that shift based on current conditions
- **Glassmorphism UI card** showing humidity, wind speed, and feels-like temperature
- **Tap to refresh** with a smooth fade animation
- Custom **Plus Jakarta Sans** typography throughout

-----

## 📸 Screenshots


|Clear                          |Cloudy                           
|-------------------------------|-------------------------------|
<img width="720" height="1280" alt="sun" src="https://github.com/user-attachments/assets/9b7ceca9-d3e1-49f5-9267-458ff67aa959" />|<img width="720" height="1280" alt="cloud" src="https://github.com/user-attachments/assets/f1a8fd0f-60a6-4609-a00f-21fc937ed31b" />
|Rainy                          |Storm                          |
|-------------------------------|-------------------------------|
<img width="720" height="1280" alt="rain" src="https://github.com/user-attachments/assets/22659022-153f-4207-a138-189c267f95ee" />|
<img width="720" height="1280" alt="thunder" src="https://github.com/user-attachments/assets/a8d6cc5a-c3f5-4e4e-9c5f-d46716c058d7" />|


-----

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.x`
- A free [OpenWeatherMap API key](https://openweathermap.org/api)

### Installation

1. **Clone the repo**
   
   ```bash
   git clone https://github.com/Imariandle/wheaterin.git
   cd wheaterin
   ```
1. **Set up your API key**
   
   Copy the secrets template:
   
   ```bash
   cp lib/config/secrets.template.dart lib/config/secrets.dart
   ```
   
   Then open `lib/config/secrets.dart` and replace the placeholder:
   
   ```dart
   const String openWeatherApiKey = 'YOUR_API_KEY_HERE';
   ```

> ⚠️ `secrets.dart` is listed in `.gitignore` and will never be committed.
1. **Install dependencies**
   
   ```bash
   flutter pub get
   ```
1. **Run the app**
   
   ```bash
   flutter run
   ```

-----

## 🏗 Project Structure

```
lib/
├── config/
│   ├── secrets.template.dart   # API key template (safe to commit)
│   └── secrets.dart            # Your actual API key (git-ignored)
├── models/
│   └── weather_model.dart      # Weather data model
├── pages/
│   └── WeatherPage.dart        # Main UI page
├── service/
│   └── weather_service.dart    # OpenWeatherMap API + location logic
└── main.dart                   # App entry point

assets/
├── sunny.json                  # Lottie animation — clear weather
├── cloudy.json                 # Lottie animation — clouds/mist/fog
├── rainy.json                  # Lottie animation — rain/drizzle
└── storm.json                  # Lottie animation — thunderstorm

fonts/
├── PlusJakartaSans-Light.ttf
├── PlusJakartaSans-Regular.ttf
├── PlusJakartaSans-Medium.ttf
└── PlusJakartaSans-SemiBold.ttf
```

-----

## 📦 Dependencies

|Package                                            |Purpose                        |
|---------------------------------------------------|-------------------------------|
|[`http`](https://pub.dev/packages/http)            |HTTP requests to OpenWeatherMap|
|[`geolocator`](https://pub.dev/packages/geolocator)|Device GPS location            |
|[`geocoding`](https://pub.dev/packages/geocoding)  |Coordinates → city name        |
|[`lottie`](https://pub.dev/packages/lottie)        |Animated weather illustrations |

-----

## 🔑 API Key Setup

This app uses the [OpenWeatherMap Current Weather API](https://openweathermap.org/current).

1. Sign up at [openweathermap.org](https://home.openweathermap.org/users/sign_up) — it’s free
1. Go to **API Keys** in your account dashboard
1. Copy your key and paste it into `lib/config/secrets.dart`

The free tier supports up to **1,000 calls/day**, which is more than enough for personal use.

-----

## 📱 Platform Support

|Platform|Status                      |
|--------|----------------------------|
|Android |✅ Supported                 |
|iOS     |✅ Supported                 |
|Web     |⚠️ Location may require HTTPS|
|macOS   |✅ Supported                 |
|Windows |✅ Supported                 |
|Linux   |✅ Supported                 |

-----

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the repo
1. Create your branch: `git checkout -b feature/your-feature`
1. Commit your changes: `git commit -m 'Add your feature'`
1. Push and open a Pull Request

-----

## 📄 License

This project is licensed under the MIT License — see the <LICENSE> file for details.

-----

<div align="center">
Made with ☕ and Flutter
</div>
