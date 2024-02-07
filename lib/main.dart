// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/screens.dart';
import 'theme.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xgenria AI',
      initialRoute: '/project',
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
    case '/chats':
      page = ChatList();
    case '/chatbox':
      page = ChatBox();
    case '/gen-image':
      page = ImageScreen();
    case '/ai-docs':
      page = AIDocuments();
    default:
  }
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => page,
  );
}
