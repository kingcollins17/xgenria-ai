// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/providers/doc_provider.dart';
import 'package:xgenria/redux/core.dart';

class DocList extends ConsumerStatefulWidget {
  const DocList({super.key});
  @override
  ConsumerState<DocList> createState() => _DocListState();
}

class _DocListState extends ConsumerState<DocList> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          final docs = ref.watch(docNotifierProvider(vm.auth.token!));
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'All AI Documents',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: docs.when(
              data: (data) => data != null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        ...List.generate(
                            data.documents.length,
                            (index) => GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/read-doc',
                                      arguments: data.documents[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF272727),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                )),
                                            child: Icon(
                                              Icons.edit_document,
                                              size: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.documents[index].name,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '${data.documents[index].content.substring(0, 20)}...',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                      ]),
                    )
                  : Text(
                      'Something went wrong!',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
              error: (_, __) => Text(''),
              loading: () => SpinKitRipple(
                  color: Theme.of(context).colorScheme.primary, size: 30),
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
