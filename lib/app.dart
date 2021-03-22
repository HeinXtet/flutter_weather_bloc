import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/blocs.dart';
import 'package:flutter_weather/bloc/theme/theme_bloc.dart';
import 'package:flutter_weather/bloc/theme/theme_state.dart';
import 'package:flutter_weather/repositories/repositories.dart';
import 'package:flutter_weather/view/weather.dart';

class App extends StatelessWidget {
  final WeatherRepository repository;

  App({@required this.repository}) : assert(repository != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => BlocProvider(
          create: (context) => WeatherBloc(repository: repository),
          child: Weather(),
        ),
      ),
    );
  }
}
