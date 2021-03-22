import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/blocs.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:flutter_weather/repositories/repositories.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({@required this.repository})
      : assert(repository != null),
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequest) {
      yield* _mapWeatherRequestedToState(event.city);
    } else if (event is WeatherRefreshedRequest) {
      yield* _mapWeatherRefreshRequestedToState(event.city);
    }
  }

  Stream<WeatherState> _mapWeatherRequestedToState(String city) async* {
    yield WeatherLoadInProgress();
    try {
      final weather = await repository.getWeather(city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (error) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> _mapWeatherRefreshRequestedToState(String city) async* {
    try {
      final Weather weather = await repository.getWeather(city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {}
  }
}
