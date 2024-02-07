// ignore_for_file: prefer_const_constructors

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'redux/store.dart';
import 'redux/xgenria_state.dart';
import 'screens/onboard.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    StoreProvider<XgenriaState>(
      store: createStore(),
        child: ProviderScope(
          child: MaterialApp(
            onGenerateRoute: _onGenerateRoute,
          ),
        )),
  );
}



MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
  Widget page = const SizedBox();
  switch (settings.name) {
    case '/':
      page = XOnboard();
      break;
    default:
  }
  return MaterialPageRoute(builder: (context) => page);
}
