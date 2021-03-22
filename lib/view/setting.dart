import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/blocs.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) => ListTile(
              title: Text('Temperature Unis'),
              isThreeLine: true,
              subtitle: Text("Use metric measurements for temperature units."),
              trailing: Switch(
                value: state.temperatureUnits == TemperatureUnits.celsius,
                onChanged: (_) => BlocProvider.of<SettingBloc>(context).add(
                  TemperatureUnitToggled(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
