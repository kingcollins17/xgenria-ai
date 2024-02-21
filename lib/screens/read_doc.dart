// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/doc_provider.dart';
import 'package:xgenria/redux/core.dart';

class ReadDocument extends ConsumerStatefulWidget {
  const ReadDocument({super.key, required this.doc});
  final Document doc;
  @override
  ConsumerState<ReadDocument> createState() => _ReadDocumentState();
}

class _ReadDocumentState extends ConsumerState<ReadDocument> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        actions: [
          SvgPicture.asset(
            'asset/images/logo.svg',
            color: Theme.of(context).colorScheme.primary,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.doc.name,
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.doc.content,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    () {
                      final d = widget.doc.datetime!;
                      return d.day.toString() +
                          ' ' +
                          [
                            'Jan',
                            'Feb',
                            'March',
                            'April',
                            'May',
                            'Jun',
                            'July' 'Aug',
                            'Sept',
                            'Oct',
                            'Nov',
                            'Dec'
                          ][d.month - 1] +
                          ', ' +
                          d.year.toString();
                    }(),
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: StoreConnector<XgenriaState, _ViewModel>(
                    converter: (store) => _ViewModel(store),
                    builder: (context, vm) {
                      return FilledButton(
                          onPressed: () {
                            var notifier = ref.read(
                                docNotifierProvider(vm.auth.token!).notifier);
                            setState(() {
                              isLoading = true;
                            });
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            fixedSize: MaterialStatePropertyAll(Size(
                                MediaQuery.of(context).size.width * 0.8, 45)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(isLoading ? 'Please wait ...' : 'Delete')
                            ],
                          ));
                    }),
              ))
        ],
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
