// ignore_for_file: prefer_const_constructors

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/screens.dart';
import 'theme.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xgenria AI',
      initialRoute: '/gen-image',
      onGenerateRoute: _onGenerateRoute,
      theme: XgenriaTheme.dark,
    ),
  ));
}

MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
  Widget page = const SizedBox();
  switch (settings.name) {
    case '/':
      page = XOnboard();
      break;
    case '/auth':
      page = XAuth();
    case '/project':
      page = XProject();

    case '/gen-image':
      page = ImageScreen();
    default:
  }
  return MaterialPageRoute(builder: (context) => page);
}
