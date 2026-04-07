import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService(this.apiKey);

  /// Fetches current weather for the given [cityName].
  Future<Weather> getWeather(String cityName) async {
    final uri = Uri.parse('$_baseUrl?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to fetch weather (status ${response.statusCode})',
      );
    }
  }

  /// Returns the city name for the device's current GPS position.
  Future<String> getCurrentCity() async {
    // Check and request location permission if needed
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final city = placemarks.first.locality;
    if (city == null || city.isEmpty) {
      throw Exception('Could not determine city from coordinates.');
    }

    return city;
  }
}
