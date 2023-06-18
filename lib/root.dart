import 'package:chithi/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chithi/screens/screens.dart';

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<User?> authState = ref.watch(authStateStreamProvider);

    if (authState.value == null) {
      return const AuthScreen();
    } else {
      return const Base();
    }
  }
}
