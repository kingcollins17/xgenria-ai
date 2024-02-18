// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/redux/core.dart';

class ImageHistory extends ConsumerStatefulWidget {
  const ImageHistory({super.key});
  @override
  ConsumerState<ImageHistory> createState() => _ImageHistoryState();
}

class _ImageHistoryState extends ConsumerState<ImageHistory> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [],
            ),
          );
        });
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
