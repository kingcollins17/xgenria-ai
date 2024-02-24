import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key});
  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});
  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
