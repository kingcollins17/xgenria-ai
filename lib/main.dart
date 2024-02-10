// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/api/auth.dart';
import 'package:xgenria/api/image.dart';
import 'package:xgenria/providers/auth_provider.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';

import 'screens/screens.dart';
import 'theme.dart';

void main() {
  runApp(ProviderScope(
    child: StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xgenria AI',
        initialRoute: '/test',
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
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final dio = ref.watch(dioProvider);
        final auth = ref.watch(authNotifierProvider);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
                ref.read(authNotifierProvider).token?.toString() ??
                    'No authentication yet',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                )),
            // Text(response ?? 'No response yet',
            //     style: GoogleFonts.poppins(
            //       fontSize: 16,
            //       color: Colors.red,
            //       decoration: TextDecoration.none,
            //     )),
            FilledButton(
              onPressed: () {
                setState(() => isLoading = true);
                // ImageAPI.createImage(dio, ref.read(authNotifierProvider).token!,
                //         input: '')
                //     .then((value) => setState(() {
                //           isLoading = false;
                //           response = value.toString();
                //         }));
                ref
                    .read(authNotifierProvider.notifier)
                    .login(
                        email: 'ajayimarvellous777@gmail.com',
                        password: 'password')
                    .then((value) => setState(() {
                          isLoading = false;
                          response = value.toString();
                        }));
              },
              child: Text('Press me'),
            ),
            if (isLoading)
              SpinKitPulse(
                color: Colors.purple,
                size: 50,
              )
          ]),
        );
      },
    );
  }
}
