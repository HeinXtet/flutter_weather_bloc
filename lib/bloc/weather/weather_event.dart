import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequest extends WeatherEvent {
  final String city;

  WeatherRequest({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}


class WeatherRefreshedRequest extends WeatherEvent {
  final String city;

  WeatherRefreshedRequest({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
