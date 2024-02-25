// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/pop_up.dart';

enum _FormType { login, register }

class XAuth extends ConsumerStatefulWidget {
  const XAuth({super.key});

  @override
  ConsumerState<XAuth> createState() => _XAuthState();
}

class _XAuthState extends ConsumerState<XAuth>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  bool isLoading = false;
  String? name, email, password, confirmedPassword;

  bool rememberMe = false;

  Widget? popUp;

  var formType = _FormType.login;
  late AnimationController controller;

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

  Future<void> _notify(String message, {bool? loading}) {
    setState(() {
      isLoading = loading ?? isLoading;
      popUp = PopUp(animation: controller, message: message);
    });
    return showPopUp(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<XgenriaState, _ViewModel>(
              builder: (context, vm) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SB(height: 20),
                      const SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'asset/images/logo.svg',
                            width: 90,
                            height: 90,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Xgenria',
                                style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'AI',
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Form(
                          key: formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                if (formType == _FormType.register)
                                  _InputField(
                                    label: 'Name',
                                    hint: 'Enter your name',
                                    validator: (p0) => p0 == null || p0.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onChanged: (p0) => name = p0,
                                  ),
                                const SizedBox(height: 25),
                                _InputField(
                                  label: 'Email Address',
                                  hint: 'Your email',
                                  validator: (p0) => p0 == null || p0.isEmpty
                                      ? "Email is required to login"
                                      : null,
                                  type: TextInputType.emailAddress,
                                  onChanged: (p0) => email = p0,
                                ),
                                const SB(height: 30),
                                _InputField(
                                  hint: 'Your password',
                                  label: 'Password',
                                  onChanged: (p0) => password = p0,
                                  type: TextInputType.visiblePassword,
                                  validator: (p0) => p0 == null || p0.isEmpty
                                      ? "Password is required"
                                      : null,
                                  obscureText: obscurePassword,
                                  suffixIcon: GestureDetector(
                                      onTap: () => setState(() =>
                                          obscurePassword = !obscurePassword),
                                      child: Icon(
                                          obscurePassword
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded,
                                          size: 20,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color)),
                                ),
                                if (formType == _FormType.register) ...[
                                  const SizedBox(height: 25),
                                  _InputField(
                                    hint: 'Enter password again',
                                    label: 'Confirm Password',
                                    onChanged: (p0) => confirmedPassword = p0,
                                    type: TextInputType.visiblePassword,
                                    validator: (p0) => p0 == null || p0.isEmpty
                                        ? "Confirm Password is required"
                                        : password != confirmedPassword
                                            ? "Confirm Password does not match"
                                            : null,
                                    obscureText: obscurePassword,
                                    suffixIcon: GestureDetector(
                                        onTap: () => setState(() =>
                                            obscurePassword = !obscurePassword),
                                        child: Icon(
                                            obscurePassword
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                            size: 20,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color)),
                                  ),
                                ],
                                const SizedBox(height: 10),
                                if (formType == _FormType.login)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () =>
                                          Navigator.of(context).pushNamed(
                                        '/forgot-password',
                                      ),
                                      child: Text(
                                        'Forgot Password?  ',
                                        style: GoogleFonts.urbanist(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (formType == _FormType.login)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: rememberMe,
                                            onChanged: (bool? value) =>
                                                setState(() {
                                                  rememberMe =
                                                      value ?? rememberMe;
                                                })),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Remember me',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                const SB(height: 30),
                                FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme.of(context).colorScheme.primary),
                                    fixedSize: MaterialStatePropertyAll(
                                      Size(
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          45),
                                    ),
                                  ),
                                  onPressed: () {
                                    if ((!isLoading) &&
                                        (formKey.currentState?.validate() ??
                                            false)) {
                                      handleSubmit(vm, context);
                                    }
                                  },
                                  child: vm.state.isLoading
                                      ? SpinKitThreeInOut(
                                          color: Colors.white, size: 20)
                                      : Text(
                                          formType == _FormType.login
                                              ? 'Login'
                                              : 'Sign up',
                                          style: GoogleFonts.quicksand(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              color: const Color(0xFFFAF9F9),
                                              fontWeight: FontWeight.w500),
                                        ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      formType = formType == _FormType.login
                                          ? _FormType.register
                                          : _FormType.login;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formType == _FormType.login
                                              ? "Don't have an account? "
                                              : "Already have an account?",
                                          style: GoogleFonts.urbanist(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                        Text(
                                          formType == _FormType.login
                                              ? ' Register'
                                              : ' Login',
                                          style: GoogleFonts.urbanist(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w600,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          )),
                    ]);
              },
              converter: (store) => _ViewModel(store),
            ),
          ),
        ),
        if (popUp != null)
          Positioned(
              top: 50,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width, child: popUp!)),
      ],
    );
  }

  void handleSubmit(_ViewModel vm, BuildContext context) {
    if (formType == _FormType.login) {
      vm.dispatch(AuthAction(
          type: AuthActionType.login,
          payload: LoginPayload(
            client: ref.read(dioProvider),
            email: email!,
            password: password!,
            rememberMe: rememberMe,
            onDone: (p0) {
              if (p0 is ({String message, AccessToken? token}) &&
                  p0.token != null) {
                Hive.box('settings').put('token', {
                  'type': p0.token!.type,
                  'value': p0.token!.value,
                  'expiration': p0.token!.expiration?.inSeconds
                });
              }
              _notifyMessage('You are logged in').then(
                  (value) => Navigator.of(context).popAndPushNamed('/home'));
            },
            onError: (p0) {
              p0 as ({String message, AccessToken? token});
              _notifyMessage(p0.message);
            },
          )));
    } else if (formType == _FormType.register) {
      vm.dispatch(AuthAction(
          type: AuthActionType.register,
          payload: RegistrationPayload(
            client: ref.read(dioProvider),
            name: name!,
            email: email!,
            password: password!,
            confirmedPassword: confirmedPassword!,
            onDone: (value) => _notifyMessage(
                    'User registered, please login into your account')
                .then((value) => setState(() => formType = _FormType.login)),
            onError: (p0) => _notifyMessage(p0.toString()),
          )));
    }
  }

  Future<dynamic> _notifyMessage(String message) {
    setState(() {
      popUp = PopUp(animation: controller, message: message);
    });
    return showPopUp(controller, delay: Duration(seconds: 4));
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    super.key,
    required this.hint,
    required this.label,
    this.validator,
    this.onChanged,
    this.type,
    this.suffixIcon,
    this.obscureText = false,
  });
  final String hint, label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? type;
  final Widget? suffixIcon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: GoogleFonts.quicksand(
              textStyle: Theme.of(context).textTheme.bodySmall,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SB(height: 10),
        Container(
          // height: 60,
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.surfaceTint,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            validator: validator,
            keyboardType: type,
            obscureText: obscureText,
            onChanged: onChanged,
            cursorColor: const Color(0xFF494949),
            style: GoogleFonts.quicksand(
              textStyle: Theme.of(context).textTheme.bodySmall,
              fontWeight: FontWeight.w500,
            ),
            cursorWidth: 1.3,
            cursorHeight: 16,
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              border: const UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary)),
              hintText: hint,
              hintStyle: GoogleFonts.quicksand(
                  color: Colors.grey,
                  textStyle: Theme.of(context).textTheme.bodySmall),
            ),
          ),
        ),
      ],
    );
  }
}

typedef SB = SizedBox;

class _ViewModel {
  final Store<XgenriaState> _store;
  final AuthState state;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        state = store.state.auth;

  void dispatch(AuthAction action) => _store.dispatch(action);
}
