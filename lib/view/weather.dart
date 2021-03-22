import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/blocs.dart';
import 'package:flutter_weather/bloc/theme/theme_bloc.dart';
import 'package:flutter_weather/bloc/theme/theme_event.dart';
import 'package:flutter_weather/bloc/theme/theme_state.dart';
import 'package:flutter_weather/view/city_selection.dart';
import 'package:flutter_weather/view/combined_weather_condition.dart';
import 'package:flutter_weather/view/gradient_background.dart';
import 'package:flutter_weather/view/last_updated.dart';
import 'package:flutter_weather/view/location.dart';
import 'package:flutter_weather/view/setting.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Setting()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CitySelection()));
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context).add(
                  WeatherRequest(city: city),
                );
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoadSuccess) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            BlocProvider.of<ThemeBloc>(context).add(
              WeatherChanged(
                weatherCondition: state.weather.condition,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Center(
              child: Text("Please Select Location."),
            );
          }

          if (state is WeatherLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is WeatherLoadFailure) {
            return Center(
              child: Text("Something went wrong."),
            );
          }
          if (state is WeatherLoadSuccess) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) => GradientContainer(
                color: themeState.color,
                child: RefreshIndicator(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Location(
                            location: state.weather.location,
                          ),
                        ),
                      ),
                      Center(
                        child: LastUpdated(
                          dateTime: state.weather.lastUpdated,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                          child: CombinedWeatherTemperature(
                            weather: state.weather,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context).add(
                      WeatherRefreshedRequest(city: state.weather.location),
                    );
                    return _refreshCompleter.future;
                  },
                ),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
