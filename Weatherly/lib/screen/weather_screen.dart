import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/service/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('34d3494545e6ad9c6e36165419a7b451');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final city = await _weatherService.getCity();
      final weather = await _weatherService.getWeather(city);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
      setState(() {
        _weather = null; // Handle error state
      });
    }
  }

  String _getAnimationPath() {
    if (_weather == null) return 'assets/default.json';

    final weatherCondition = _weather!.weatherCond.toLowerCase();

    switch (weatherCondition) {
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
      case 'smoke':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/raining.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/default.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withOpacity(0.5),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 28, color: Colors.white70),
        title: const Text('Weatherly'),
        backgroundColor: Colors.black87,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://img.freepik.com/free-photo/clouds-sky-vertical-shot_23-2148824916.jpg?t=st=1723990053~exp=1723993653~hmac=37f91ff60f4a9948c7bbce856990f416d0c7d3f0da20993c52b1f708e74d7cde&w=360',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // show sky blue background
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueAccent.withOpacity(0.5),
                        Colors.blueAccent.withOpacity(0.1),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "${_weather?.cityName ?? 'Loading Your City...'}",
                    style: const TextStyle(fontSize: 28, color: Colors.white70),
                  ),
                  Text(
                    "${_weather?.temp.round() ?? 'Loading Temperature...'}°C",
                    style: const TextStyle(fontSize: 28, color: Colors.white70),
                  ),
                  Lottie.asset(_getAnimationPath()),
                  Center(
                    child: Text(
                      _weather?.weatherCond ??
                          "Loading City Weather Condition...",
                      style: const TextStyle(fontSize: 30, color: Colors.white70,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadiusDirectional.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Developed by Huzaifa Latif.',
                    style: TextStyle(color: Colors.white70),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
