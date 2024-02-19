// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/doc_provider.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/pop_up.dart';

import 'create_document.dart';

class AIDocuments extends ConsumerStatefulWidget {
  const AIDocuments({super.key});
  @override
  ConsumerState<AIDocuments> createState() => _AIDocumentsState();
}

class _AIDocumentsState extends ConsumerState<AIDocuments> {
  final _tempSymbol = [
    (
      'asset/logos/png-transparent-web-development-html'
          '-responsive-web-design-logo-javascript-html'
          '-angle-web-design-text-thumbnail.png',
      'Coding'
    ),
    ('asset/images/icon-6.png', 'Formula Bot'),
    ('asset/images/icon-1.png', 'Code Explanator'),
    ('asset/images/icon-3.png', 'Text'),
    ('asset/images/icon-5.png', 'Website'),
    ('asset/images/icon-4.png', 'Social Media'),
    ('asset/images/icon-2.png', 'Others')
  ];
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          final templates = ref.watch(templatesProvider(vm.auth.token!));
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    // templates.when(
                    //   data: (data) => Text('${data.categories!.map((e) => (
                    //         e.id,
                    //         e.name
                    //       )).toList()}'),
                    //   error: (_, __) => Text(''),
                    //   loading: () => Text('Please wait...'),
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'AI Studio',
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    templates.when(
                        loading: () => SpinKitRipple(
                            color: Theme.of(context).colorScheme.primary),
                        error: (_, __) => Text(''),
                        data: (data) => Wrap(
                              spacing: 10,
                              children: [
                                ...List.generate(
                                    data.categories?.length ?? 0,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            if (data.templates != null &&
                                                data.categories != null) {
                                              Navigator.of(context).pushNamed(
                                                '/create-doc',
                                                arguments: (
                                                  data.templates!
                                                      .where((element) =>
                                                          element.categoryId ==
                                                          data
                                                              .categories![
                                                                  index]
                                                              .id)
                                                      .toList(),
                                                  data.categories![index],
                                                  0,
                                                ),
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0x42DF40FB),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              constraints: BoxConstraints(
                                                  minHeight: 100),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    _tempSymbol[index].$1,
                                                    width: 60,
                                                    height: 60,
                                                    // color: Colors.transparent,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    data.categories![index]
                                                        .name,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                              ],
                            ))
                  ],
                ),
              ),
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

