// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/redux/reducers/data_reducer.dart';

import 'models/models.dart';
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
      if (settings.arguments is (ChatData, AccessToken)) {
        final args = settings.arguments as (ChatData, AccessToken);
        page = ChatDM(chat: args.$1, token: args.$2);
      }
      break;
    case '/create-chat':
      page = CreateChat();
      break;
    case '/gen-image':
      page = ImageScreen();
      break;
    case '/image-result':
      page = ImageResult(data: settings.arguments as ImageResultData);
      break;

    case '/ai-doc':
    case '/ai-docs':
      page = AIDocuments();
      break;
    case '/create-docs':
    case '/create-doc':
      if (settings.arguments is Template) {
        page = CreateDocument(template: settings.arguments as Template);
      }
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
                    // Text(vm.data.toString() ?? 'No response yet',
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 16,
                    //       color: Color(0xFFCFCFCF),
                    //       decoration: TextDecoration.none,
                    //     )),
                    Text(data.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color(0xFFCFCFCF),
                          decoration: TextDecoration.none,
                        )),
                    Text(
                      vm.data.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        // ChatAPI.messages(
                        //   dio,
                        //   vm.auth.token!,
                        //   chatId: 20,
                        //   // content: 'Hello there',
                        // ).then((value) => setState(() {
                        //       isLoading = false;
                        //       response = value.toString();
                        //       data = value;
                        //     }));
                        vm.dispatch(
                          DataAction(
                              type: DataActionType.reset,
                              payload: NetworkFetchPayload(
                                  client: dio, token: vm.auth.token!)),
                        );
                      },
                      child: Text('Press me'),
                    ),
                    if (isLoading || vm.data.isLoading)
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
  final AuthState auth;
  final DataState data;

  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        auth = store.state.auth,
        data = store.state.data;

  void dispatch(XgenriaAction action) => _store.dispatch(action);
}
