// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xgenria/providers/project_provider.dart';
import 'package:xgenria/providers/trans_provider.dart';
import 'package:xgenria/redux/core.dart';

class TranscriptionList extends ConsumerStatefulWidget {
  const TranscriptionList({super.key});
  @override
  ConsumerState<TranscriptionList> createState() => _TranscriptionListState();
}

class _TranscriptionListState extends ConsumerState<TranscriptionList> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          // ref.watch(trans_provider);
          final transcriptions =
              ref.watch(transNotifierProvider(vm.auth.token!));
          final projects = ref.watch(projectNotifierProvider(vm.auth.token!));

          return Stack(
            children: [
              Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'AI Transcriptions ',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  body: transcriptions.when(
                      data: (data) => data.data != null
                          ? SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(children: [
                                  ...List.generate(
                                      data.data!.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6.0),
                                            child: GestureDetector(
                                              onTap: () => Navigator.of(context)
                                                  .pushNamed('/trans-detail',
                                                      arguments:
                                                          data.data![index]),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    minHeight: 75,
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFF333333),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.data![index].name,
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        () {
                                                          final content = data
                                                              .data![index]
                                                              .content;
                                                          return content
                                                                  .substring(
                                                                      0, 50) +
                                                              '...';
                                                        }(),
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFFCFCFCF),
                                                        ),
                                                      ),
                                                      if (data.data![index]
                                                              .projectId !=
                                                          null)
                                                        Text(
                                                          'project' +
                                                              projects
                                                                  .value!.data!
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .projectId ==
                                                                      data
                                                                          .data![
                                                                              index]
                                                                          .projectId)
                                                                  .toString(),
                                                          style: GoogleFonts
                                                              .quicksand(
                                                                  fontSize: 12),
                                                        )
                                                    ]),
                                              ),
                                            ),
                                          ))
                                ]),
                              ),
                            )
                          : Text(
                              'You do not have any transcriptions',
                              style: GoogleFonts.quicksand(
                                  fontSize: 16, color: Colors.white),
                            ),
                      error: (_, __) => Text(
                          'Unable to retreive transcriptions at the moment'),
                      loading: () => SpinKitThreeInOut(
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ))),
              Positioned(
                  bottom: 20,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/create-trans');
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary
                            ])),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Transcription',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(Icons.add_rounded)
                            ]),
                      ),
                    ),
                  ))
            ],
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
