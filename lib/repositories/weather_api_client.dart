import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class WeatherApiClient {
  static const _endPoint = "https://www.metaweather.com";
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);


  Future<int>getLocationId(String city) async {
    final locationUrl = '$_endPoint/api/location/search/?query=$city';
    final locationResponse = await httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async{
    final weatherUrl = '$_endPoint/api/location/$locationId';

    final weatherResponse = await httpClient.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}
