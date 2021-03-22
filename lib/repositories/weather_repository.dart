import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:flutter_weather/repositories/repositories.dart';

class WeatherRepository {
  final WeatherApiClient apiClient;
  WeatherRepository({@required this.apiClient}) : assert(apiClient != null);
  Future<Weather> getWeather(String city) async {
    final locationId = await apiClient.getLocationId(city);
    final weather = await apiClient.fetchWeather(locationId);
    return weather;
  }
}
