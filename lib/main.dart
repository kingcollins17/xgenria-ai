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
      initialRoute: '/home',
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
    case '/home':
      page = HomeScreen();
      break;
    case '/auth':
      page = XAuth();
      break;
    case '/project':
      page = XProject();
      break;
    case '/chats':
      page = ChatList();
      break;
    case '/chatbox':
      page = ChatBox();
      break;
    case '/gen-image':
      page = ImageScreen();
      break;
    case '/ai-doc':
    case '/ai-docs':
      page = AIDocuments();
      break;
    case '/create-docs':
    case '/create-doc':
      page = CreateDocument();
      break;
    default:
      break;
  }
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => page,
  );
}
