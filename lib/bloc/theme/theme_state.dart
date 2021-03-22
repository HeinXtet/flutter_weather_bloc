import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ThemeState extends Equatable {
  final ThemeData themeData;
  final MaterialColor color;

  ThemeState({@required this.themeData, @required this.color})
      : assert(themeData != null),
        assert(color != null);

  @override
  List<Object> get props => [themeData, color];
}

