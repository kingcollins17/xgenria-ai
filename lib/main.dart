// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/api/project.dart';
import 'package:xgenria/models/transcription.dart';
import 'package:xgenria/providers/doc_provider.dart';
import 'package:xgenria/providers/image_provider.dart';
import 'package:xgenria/providers/project_provider.dart';

import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/providers/trans_provider.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/redux/reducers/data_reducer.dart';
import 'package:xgenria/screens/create_trans.dart';
import 'package:xgenria/screens/doc_list.dart';
import 'package:xgenria/screens/image_history.dart';
import 'package:xgenria/screens/plans.dart';
import 'package:xgenria/screens/project_detail.dart';
import 'package:xgenria/screens/read_doc.dart';
import 'package:xgenria/screens/trans_detail.dart';
import 'package:xgenria/screens/trans_list.dart';
import 'api/doc.dart';
import 'api/transcription.dart';

import 'models/models.dart';
import 'screens/create_document.dart';
import 'screens/screens.dart';
import 'theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  final settings = await Hive.openBox('settings');

  var store = createStore();
  runApp(ProviderScope(
    child: StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xgenria AI',
        initialRoute: '/',
        onGenerateRoute: (routeSettings) =>
            _onGenerateRoute(routeSettings, store, settings),
        theme: XgenriaTheme.dark,
      ),
    ),
  ));
}

MaterialPageRoute _onGenerateRoute(RouteSettings routeSettings,
    Store<XgenriaState> store, Box<dynamic> settings) {
  Widget page = const SizedBox();
  switch (routeSettings.name) {
    case '/':
      if (settings.get('hasLaunched') == true) {
        page = store.state.auth.isAuthenticated ? HomeScreen() : XAuth();
      } else {
        page = XOnboard();
        settings.put('hasLaunched', true);
      }
      // page = XOnboard();
      break;
    case '/home':
      page = HomeScreen();
      break;
    case '/auth':
      page = store.state.auth.isAuthenticated ? HomeScreen() : XAuth();
      break;
    case '/plan':
    case '/plans':
    case '/subscription':
    case '/subscriptions':
      page = SubscriptionPlan();
      break;
    case '/project':
      page = XProject();
      break;
    case 'project-detail':
    case '/project-detail':
      if (routeSettings.arguments is ProjectData) {
        page = ProjectDetail(project: routeSettings.arguments as ProjectData);
      }
      break;
    case '/chats':
      page = ChatList();
      break;
    case '/chatbox':
      if (routeSettings.arguments is (ChatData, AccessToken)) {
        final args = routeSettings.arguments as (ChatData, AccessToken);
        page = ChatDM(chat: args.$1, token: args.$2);
      }
      break;
    case '/create-trans':
    case '/ai-transcript':
      page = CreateTranscription();
      break;
    case '/trans-list':
      page = TranscriptionList();
      break;
    case '/trans-detail':
      if (routeSettings.arguments is TranscriptionData) {
        page = TranscriptionDetail(
            data: routeSettings.arguments as TranscriptionData);
      }
    case '/create-chat':
      page = CreateChat();
      break;
    case '/gen-image':
      page = ImageScreen();
      break;
    case '/image-result':
      if (routeSettings.arguments is ImageData) {
        page = ImageResult(data: routeSettings.arguments as ImageData);
      }
      break;
    case '/image-history':
      page = ImageHistory();
      break;

    case '/ai-doc':
    case '/ai-docs':
      page = AIDocuments();
      break;
    case '/create-docs':
    case '/create-doc':
      if (routeSettings.arguments is (List<Template>, TemplateCategory, int)) {
        page = CreateDocument(
            data: routeSettings.arguments as (
          List<Template>,
          TemplateCategory,
          int
        ));
      }
      break;
    case '/doc-list':
      page = DocList();
      break;
    case 'read-doc':
    case '/read-doc':
      if (routeSettings.arguments is Document) {
        page = ReadDocument(doc: routeSettings.arguments as Document);
      }
      break;
    case '/change-password':
      page = ChangePassword();
      break;

    case '/forgot-password':
      page = ForgotPassword();
      break;

    case '/reset-password':
      page = ResetPassword();
      break;
    case '/test':
      page = TestAPI();
      break;
    default:
      break;
  }
  return MaterialPageRoute(
    settings: routeSettings,
    builder: (context) => page,
  );
}

class TestAPI extends StatefulWidget {
  const TestAPI({super.key});

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  File? file;

  //

  String? response;
  bool isLoading = false;
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoreConnector<XgenriaState, _ViewModel>(
        builder: (context, vm) => Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final dio = ref.watch(dioProvider);
            final images = ref.watch(
              imagesProvider(vm.auth.token!),
            );

            final trans = ref.watch(transNotifierProvider(vm.auth.token!));
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Text(file?.toString() ?? 'No file yet',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFFCFCFCF),
                            decoration: TextDecoration.none,
                          )),
                      Text(
                        '$data',
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                          // (data['data'] as List<dynamic>)
                          //     .map((e) => PlanData.fromJson(e))
                          //     .toString(),
                          // '$data',
                          trans.when(
                              data: (transData) => '$transData',
                              error: (_, __) => 'error',
                              loading: () => 'loading ...'),
                          //ImageData.fromJson(data['data']).toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFFCFCFCF),
                            decoration: TextDecoration.none,
                          )),
                      Consumer(builder: (context, ref, child) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                //
                                TranscriptionAPI.delete(dio, vm.auth.token!,
                                        id: 11)
                                    .then((value) => setState(() {
                                          isLoading = false;
                                          data = value;
                                          value.status
                                              ? ref.invalidate(
                                                  transNotifierProvider)
                                              : null;
                                        }));
                              },
                              child: Text('Press me'),
                            ),
                          ],
                        );
                      }),
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
      ),
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
