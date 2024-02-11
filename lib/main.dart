// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/auth.dart';
import 'package:xgenria/api/image.dart';
import 'package:xgenria/models/image.dart';

import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/typing_text/ext.dart';

import 'screens/screens.dart';
import 'theme.dart';

void main() {
  runApp(ProviderScope(
    child: StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xgenria AI',
        initialRoute: '/',
        onGenerateRoute: _onGenerateRoute,
        theme: XgenriaTheme.dark,
      ),
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
    case '/create-chat':
      page = CreateChat();
      break;
    case '/gen-image':
      page = ImageScreen();
      break;
    case '/image-result':
      page = ImageResult();
      break;

    case '/ai-doc':
    case '/ai-docs':
      page = AIDocuments();
      break;
    case '/create-docs':
    case '/create-doc':
      page = CreateDocument();
      break;
    case '/test':
      page = TestAPI();
      break;
    default:
      break;
  }
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => page,
  );
}

class TestAPI extends StatefulWidget {
  const TestAPI({super.key});

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  String? response;
  bool isLoading = false;
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
      builder: (context, vm) => Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final dio = ref.watch(dioProvider);
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    // Text(vm.state.toString(),
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 16,
                    //       color: Color(0xFFFFFFFF),
                    //       decoration: TextDecoration.none,
                    //     )),
                    Text(response ?? 'No response yet',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color(0xFFCFCFCF),
                          decoration: TextDecoration.none,
                        )),
                    // Text(data.toString()),
                    Text(
                        (data as List<dynamic>)
                            .map((e) => ImageData.fromJson(e))
                            .toList()
                            .toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color(0xFFCFCFCF),
                          decoration: TextDecoration.none,
                        )).animateTyping(autoPlay: true, secondsPerChar: 0.005),
                    // Text(vm.state.message ?? 'No message yet',
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 16,
                    //       color: Color(0xFFFFFFFF),
                    //       decoration: TextDecoration.none,
                    //     )),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        ImageAPI.images(
                          dio, vm.state.token!,
                          // input: 'Image of a man under the rain',
                        ).then((value) => setState(() {
                              isLoading = false;
                              data = value;
                              response = value.runtimeType.toString();
                            }));
                      },
                      child: Text('Press me'),
                    ),
                    if (isLoading || vm.state.isLoading)
                      SpinKitPulse(
                        color: Colors.purple,
                        size: 50,
                      )
                  ]),
            ),
          );
        },
      ),
      converter: (Store<XgenriaState> store) => _ViewModel(store),
    );
  }
}

class _ViewModel {
  final Store<XgenriaState> _store;
  final AuthState state;

  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        state = store.state.auth;

  void dispatch(AuthAction action) => _store.dispatch(action);
}
