// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/_config.dart';
import 'package:xgenria/models/image.dart';
import 'package:xgenria/providers/image_provider.dart';
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
          final images = ref.watch(imagesProvider(vm.auth.token!));
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Created Images',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                SvgPicture.asset(
                  'asset/images/logo.svg',
                  color: Theme.of(context).colorScheme.primary,
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 5)
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: images.when(
                      data: (data) => Column(
                            children: [
                              Wrap(
                                spacing: 4,
                                runSpacing: 5,
                                children: [
                                  ...List.generate(
                                      data!.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  '/image-result',
                                                  arguments: (
                                                    status: true,
                                                    message: 'Image result',
                                                    data: {
                                                      'url':
                                                          '$uploadsBaseUrl/${data[index].image}'
                                                    }
                                                  ));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: 120,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF2C2C2C),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Image.network(
                                                Uri.parse(
                                                        '$uploadsBaseUrl/${data[index].image}')
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                        loadingProgress) =>
                                                    loadingProgress == null
                                                        ? child
                                                        : Center(
                                                            child: SizedBox(
                                                              width: 18,
                                                              height: 18,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth:
                                                                    1.4,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Center(
                                                        child: Icon(
                                                  Icons.error_outline_rounded,
                                                  color: Colors.grey,
                                                  size: 20,
                                                )),
                                              ),
                                            ),
                                          ))
                                ],
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                      error: (_, __) =>
                          Text('Oops!, Something went wrong, Please refresh'),
                      loading: () => Text('Please wait'))),
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
