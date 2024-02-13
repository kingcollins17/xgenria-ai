// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/screens/explore_screen.dart';
import 'package:xgenria/screens/profile_screen.dart';
import 'package:xgenria/screens/projects.dart';

import '../widgets/menu.dart';
import 'index_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final pageController = PageController();
  HoverDestination previous = HoverDestination.home,
      destination = HoverDestination.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(children: [
          PageTransitionSwitcher(
            reverse: destination.index < previous.index,
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            ),
            child: destination == HoverDestination.home
                ? IndexPage()
                : destination == HoverDestination.explore
                    ? StoreConnector<XgenriaState, _ViewModel>(
                        converter: (store) => _ViewModel(store),
                        builder: (context, vm) {
                          return ExplorePage(token: vm.auth.token!);
                        })
                    : destination == HoverDestination.projects
                        ? XProject()
                        : ProfilePage(),
          ),
          Positioned(
            bottom: 5,
            child: HoverMenu(
              isOpen: true,
              onChanged: (value) => setState(() {
                previous = destination;
                destination = value;
              }),
            ),
          ),
        ]),
      ),
    );
  }
}


class _ViewModel {
  final Store<XgenriaState> _store;
  final AuthState auth;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        auth = store.state.auth;
  void dispatch(action) => _store.dispatch(action);
}
