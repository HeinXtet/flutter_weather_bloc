import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/blocs.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingState(temperatureUnits: TemperatureUnits.celsius));

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    // TODO: implement mapEventToState
    if (event is TemperatureUnitToggled) {
      yield SettingState(
          temperatureUnits: state.temperatureUnits == TemperatureUnits.celsius
              ? TemperatureUnits.fahrenheit
              : TemperatureUnits.celsius);
    }
  }
}
