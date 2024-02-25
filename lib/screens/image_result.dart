// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/image.dart';
import 'package:xgenria/providers/image_provider.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/pop_up.dart';
import 'package:share_plus/share_plus.dart';

class ImageResult extends ConsumerStatefulWidget {
  const ImageResult({super.key, required this.data});
  final ImageData data;
  @override
  ConsumerState<ImageResult> createState() => _ImageResultState();
}

class _ImageResultState extends ConsumerState<ImageResult>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  Widget? notification;
  late AnimationController controller;

  Future<void> _notify(String message, {bool? loading}) async {
    setState(() {
      isLoading = loading ?? isLoading;
      notification = PopUp(animation: controller, message: message);
    });
    return showPopUp(controller);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)?.settings.arguments as ImageResultData;
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(),
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        widget.data.url,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) =>
                                child,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      strokeWidth: 2,
                                      value: (loadingProgress
                                              .cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!),
                                    ),
                                  ),
                                );
                        },
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: TextButton(
                              onPressed: () => setState(() {}),
                              child: Text(
                                'Unable to load this image!',
                                style: GoogleFonts.quicksand(
                                    fontSize: 16, color: Colors.white),
                              )),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Share.share(widget.data.url),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.45),
                              decoration: BoxDecoration(
                                color: Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share_rounded),
                                  const SizedBox(width: 8),
                                  Text('Share'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          //download button
                          GestureDetector(
                            onTap: () {
                              _notify(
                                  'Deleting image ${widget.data.name} ... ');
                              ImageAPI.deleteImage(ref.read(dioProvider),
                                      vm.auth.token!, widget.data.imageId)
                                  .then((value) => _notify(value.status
                                              ? 'Image Deleted'
                                              : value.message)
                                          .then((_) {
                                        ref.invalidate(imagesProvider);
                                        value.status
                                            ? Navigator.of(context).pop()
                                            : null;
                                      }));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.45),
                              decoration: BoxDecoration(
                                color: Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_forever_rounded),
                                  const SizedBox(width: 8),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ]),
                        ),
                        child: Text(
                          isLoading ? 'Please wait ...' : 'Go back',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              if (notification != null)
                Positioned(
                    top: 20,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: notification!))
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
