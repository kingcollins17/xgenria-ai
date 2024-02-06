import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xgenria/redux/store.dart';
import 'package:xgenria/redux/xgenria_state.dart';
import 'package:xgenria/theme.dart';

import './router.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
        child: StoreProvider<XgenriaState>(
      store: createStore(),
      child: MaterialApp.router(
        title: 'Xgenria AI',
        routerConfig: xRouter(),
        debugShowCheckedModeBanner: false,
        themeAnimationCurve: Curves.easeInOutCubic,
        themeAnimationDuration: const Duration(milliseconds: 300),
        theme: XgenriaTheme.dark,
        darkTheme: XgenriaTheme.dark,
        themeMode: ThemeMode.dark,
      ),
    )),
  );
}
