import 'package:go_router/go_router.dart';
import 'package:xgenria/screens/auth.dart';
import 'package:xgenria/screens/gen_image.dart';
import 'package:xgenria/screens/home.dart';

GoRouter xRouter() => GoRouter(routes: [
      GoRoute(
        path: '/',
        // builder: (context, state) => XOnboard(),
        builder: (context, state) => XGenImage(),
      ),
      GoRoute(path: '/auth', builder: (context, state) => XAuth()),
      GoRoute(path: '/home', builder: (context, state) => XHome()),
    ]);
