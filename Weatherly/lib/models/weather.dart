class Weather {
  final String cityName;
  final double temp;
  final String weatherCond;

  Weather({
    required this.cityName,
    required this.temp,
    required this.weatherCond,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      weatherCond: json['weather'][0]['main'],
    );
  }
}
