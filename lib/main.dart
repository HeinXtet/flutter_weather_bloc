import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/AppObserver.dart';
import 'package:flutter_weather/app.dart';
import 'package:flutter_weather/bloc/setting/setting_bloc.dart';
import 'package:flutter_weather/bloc/theme/theme_bloc.dart';
import 'package:flutter_weather/repositories/repositories.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = AppObserver();

  final WeatherRepository repository =
      WeatherRepository(apiClient: WeatherApiClient(httpClient: http.Client()));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingBloc>(
          create: (context) => SettingBloc(),
        )
      ],
      child: App(
        repository: repository,
      ),
    ),
  );
}
