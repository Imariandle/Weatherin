import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../service/weather_service.dart';
import '../models/weather_model.dart';
import 'package:wheaterin/config/secrets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with SingleTickerProviderStateMixin {
  final _weatherService = WeatherService(openWeatherApiKey);
  Weather? _weather;
  bool _isTapping = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _fetchWeather();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
      _controller.forward();
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'fog':
      case 'haze':
      case 'dust':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  List<Color> _getGradientColors(String? condition) {
    if (condition == null) {
      return [const Color(0xFF1a1a2e), const Color(0xFF16213e), const Color(0xFF0f3460)];
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return [const Color(0xFF1a1a2e), const Color(0xFF1B3A6B), const Color(0xFF2E6DB4)];
      case 'clouds':
        return [const Color(0xFF2C3E50), const Color(0xFF3D5068), const Color(0xFF4A6080)];
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return [const Color(0xFF0F2027), const Color(0xFF203A43), const Color(0xFF2C5364)];
      case 'thunderstorm':
        return [const Color(0xFF0a0a0a), const Color(0xFF1a0a2e), const Color(0xFF2d1b4e)];
      case 'mist':
      case 'fog':
      case 'haze':
      case 'smoke':
      case 'dust':
        return [const Color(0xFF2C3338), const Color(0xFF3D4952), const Color(0xFF4A5568)];
      default:
        return [const Color(0xFF1a1a2e), const Color(0xFF16213e), const Color(0xFF0f3460)];
    }
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white38,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getGradientColors(_weather?.mainCondition),
          ),
        ),
        child: SafeArea(
          child: _weather == null
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white54),
                )
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _weather!.cityName,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Morocco',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _getFormattedDate(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Lottie.asset(
                          getWeatherAnimation(_weather!.mainCondition),
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            _controller.reset();
                            _fetchWeather();
                          },
                          onTapDown: (_) => setState(() => _isTapping = true),
                          onTapUp: (_) => setState(() => _isTapping = false),
                          onTapCancel: () => setState(() => _isTapping = false),
                          child: AnimatedScale(
                            scale: _isTapping ? 0.93 : 1.0,
                            duration: const Duration(milliseconds: 100),
                            child: Text(
                              '${_weather!.temperature.round()}°',
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _weather!.mainCondition,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white60,
                            letterSpacing: 1.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _statItem('Humidity', '${_weather!.humidity}%'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.15),
                              ),
                              _statItem('Wind', '${_weather!.windSpeed} km/h'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.15),
                              ),
                              _statItem('Feels like', '${_weather!.feelsLike.round()}°'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}