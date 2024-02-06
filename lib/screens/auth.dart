// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/providers/dio_provider.dart';
import 'package:xgenria/redux/actions/auth_action.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:xgenria/redux/states/auth/auth_state.dart';
import 'package:xgenria/redux/states/auth/payloads.dart';
import 'package:xgenria/redux/xgenria_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xgenria/widgets/pop_up.dart';

class XAuth extends ConsumerStatefulWidget {
  const XAuth({super.key});

  @override
  ConsumerState<XAuth> createState() => _XAuthState();
}

class _XAuthState extends ConsumerState<XAuth>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = false;
  String? email, password;

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

  @override
  Widget build(BuildContext context) {
    // var xgenriaSettings = Hive.box<XgenriaSettings>('settings').get('default')!;
    final dio = ref.watch(dioProvider);
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                                color: Theme.of(context).colorScheme.primary,
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium),
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
                  StoreConnector<XgenriaState, _ViewModel>(
                    converter: (store) => _ViewModel(store),
                    builder: (context, vm) => Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
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
                                obscureText: obscurePassword,
                                suffixIcon: GestureDetector(
                                    onTap: () => setState(() =>
                                        obscurePassword = !obscurePassword),
                                    child: Icon(
                                        obscurePassword
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 20,
                                        color:
                                            Theme.of(context).iconTheme.color)),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () =>
                                      context.go('/auth/forgot-password'),
                                  child: Text(
                                    'Forgot Password?  ',
                                    style: GoogleFonts.urbanist(
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
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
                                  // context.go('/home');
                                  vm.dispatch(AuthStateAction(
                                      type: AuthActionType.login,
                                      payload: LoginPayload(
                                        client: dio,
                                        email: email!,
                                        password: password!,
                                        onDone: () {
                                          showPopUp(controller);
                                          vm.dispatch(DataStateAction(
                                              type:
                                                  DataActionType.fetchDashboard,
                                              payload: FetchDashboardPayload(
                                                  dio: ref.read(dioProvider),
                                                  token: vm.state.accessToken!,
                                                  onDone: (data) =>
                                                      Future.delayed(
                                                          Duration(seconds: 2),
                                                          () {
                                                        context.go('/home');
                                                      }))));
                                        },
                                      )));
                                },
                                child: vm.state.isLoading
                                    ? SpinKitThreeInOut(
                                        size: 20,
                                        color: Color(0xFFFAF9F9),
                                      )
                                    : Text(
                                        'Login',
                                        style: GoogleFonts.quicksand(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            color: Color(0xFFFAF9F9),
                                            fontWeight: FontWeight.w500),
                                      ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: GoogleFonts.urbanist(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.urbanist(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (vm.state.notification != null)
                                PopUp(
                                  animation: controller,
                                  message: vm.state.notification?.message ??
                                      'Something went wrong',
                                )
                            ],
                          ),
                        )),
                  )
                ]),
          ),
        ),
      ],
    );
  }
}

class _ViewModel {
  final AuthState state;
  final Store<XgenriaState> _store;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        state = store.state.authState;

  void dispatch(XgenriaStateAction action) => _store.dispatch(action);
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
        SB(height: 10),
        Container(
          // height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceTint,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            validator: validator,
            keyboardType: type,
            obscureText: obscureText,
            onChanged: onChanged,
            cursorColor: Color(0xFF494949),
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
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
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
