// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/redux/state.dart';
import 'package:xgenria/widgets/pop_up.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                SvgPicture.asset(
                  'asset/images/logo.svg',
                  width: 40,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 5)
              ],
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Reset your Password',
                        // textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'This field is required'
                                      : null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                                labelText: 'New Password',
                                labelStyle: GoogleFonts.quicksand(),
                                isDense: true,
                                hintText: 'Enter your New password',
                                hintStyle: GoogleFonts.quicksand(fontSize: 14),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'This field is required'
                                      : null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                                labelText: 'Confirm Password',
                                labelStyle: GoogleFonts.quicksand(),
                                isDense: true,
                                hintText: 'Enter your new password again',
                                hintStyle: GoogleFonts.quicksand(fontSize: 14),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          // icon: Icon(Icons.lock_open_rounded),
                          child: Text(
                            'Reset password',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  PopUp? notification;

  String? currentPassword, newPassword, confirmPassword;

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

  Future<void> _notify(String message, {bool? loading}) {
    setState(() {
      isLoading = loading ?? isLoading;
      notification = PopUp(animation: _controller, message: message);
    });
    return showPopUp(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    SvgPicture.asset(
                      'asset/images/logo.svg',
                      width: 40,
                      height: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 5)
                  ],
                ),
                body: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Change Password',
                              // textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    onChanged: (value) =>
                                        currentPassword = value,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'This field is required'
                                            : null,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.lock_outline_rounded),
                                      labelText: 'Current Password',
                                      labelStyle: GoogleFonts.quicksand(),
                                      isDense: true,
                                      hintText: 'Enter your current password',
                                      hintStyle:
                                          GoogleFonts.quicksand(fontSize: 14),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextFormField(
                                    onChanged: (value) => newPassword = value,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'This field is required'
                                            : null,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.lock_outline_rounded),
                                      labelText: 'New Password',
                                      labelStyle: GoogleFonts.quicksand(),
                                      isDense: true,
                                      hintText: 'Enter your New password',
                                      hintStyle:
                                          GoogleFonts.quicksand(fontSize: 14),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextFormField(
                                    onChanged: (value) =>
                                        confirmPassword = value,
                                    validator: (value) => value == null ||
                                            value.isEmpty
                                        ? 'This field is required'
                                        : confirmPassword != newPassword
                                            ? 'Confirm password does not match new password'
                                            : null,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.lock_outline_rounded),
                                      labelText: 'Confirm Password',
                                      labelStyle: GoogleFonts.quicksand(),
                                      isDense: true,
                                      hintText: 'Enter your new password again',
                                      hintStyle:
                                          GoogleFonts.quicksand(fontSize: 14),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _notify('Changing your password',
                                        loading: true);

                                    AuthAPI.changePassword(
                                            ref.read(dioProvider),
                                            vm.auth.token!,
                                            currentPassword: currentPassword!,
                                            newPassword: newPassword!,
                                            confirmPassword: confirmPassword!)
                                        .then((response) => _notify(
                                                response.message,
                                                loading: false)
                                            .then((value) => response.status
                                                ? Navigator.pop(context)
                                                : null));
                                  }
                                },
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                // icon: Icon(Icons.lock_open_rounded),
                                child: Text(
                                  isLoading ? 'Please wait ...' : 'Submit',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (notification != null)
                Positioned(
                    top: 40,
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
