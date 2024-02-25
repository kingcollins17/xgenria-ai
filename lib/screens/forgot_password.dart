// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/pop_up.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String? email;

  PopUp? notification;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _notify(String message, {bool? loading}) async {
    setState(() {
      isLoading = loading ?? isLoading;
      notification = PopUp(animation: _controller, message: message);
    });

    showPopUp(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Did you forget your password?',
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          Text(
                            'Enter your email address and we will send a reset link to your email',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.quicksand(),
                          hintText: 'Enter your email address',
                          hintStyle: GoogleFonts.quicksand(fontSize: 14),
                          border: OutlineInputBorder(),
                          isDense: false,
                        ),
                      ),
                      const SizedBox(height: 70),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton.icon(
                            onPressed: () {
                              if (email != null) {
                                _notify('Sending a token to your email',
                                    loading: true);
                                AuthAPI.forgotPassword(ref.read(
                                  dioProvider,
                                )).then((value) {
                                  _notify(value.message, loading: false);
                                  value.status ? Navigator.pop(context) : null;
                                });
                              }
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            icon: Icon(Icons.send),
                            label: Text(
                              'Send email',
                              style: GoogleFonts.poppins(fontSize: 14),
                            )),
                      )
                    ],
                  ),
                ),
                if (notification != null)
                  Positioned(
                      top: 10,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: notification!))
              ],
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
