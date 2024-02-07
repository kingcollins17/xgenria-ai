
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import '../providers/providers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/pop_up.dart';

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
                  Form(
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
                                // conte
                              },
                              child: Text(
                                        'Login',
                                        style: GoogleFonts.quicksand(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                    color: const Color(0xFFFAF9F9),
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
                          
                            ],
                          ),
                      )),
                ]),
          ),
        ),
      ],
    );
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
            color: Theme.of(context).colorScheme.surfaceTint,
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
