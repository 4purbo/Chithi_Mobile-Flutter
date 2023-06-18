import 'package:chithi/theme/custom_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:chithi/root.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chithi/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String localDB = "ldb";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ConnectivityResult result = await Connectivity().checkConnectivity();

  if (result != ConnectivityResult.none) {
    await Firebase.initializeApp();

    await Hive.initFlutter();

    await Hive.openBox(localDB);

    FlutterNativeSplash.remove();

    runApp(
      const ProviderScope(
        child: Env(),
      ),
    );
  }
}

class Env extends ConsumerStatefulWidget {
  const Env({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnvState();
}

class _EnvState extends ConsumerState<Env> {
  // box
  final Box _box = Hive.box(localDB);

  @override
  void initState() {
    super.initState();

    String? savedTheme = _box.get("theme");

    if (savedTheme == null) {
      setSystemProvider(context);
    }
  }

  Future setSystemProvider(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (context.mounted) {
      Brightness currentBrightness = MediaQuery.platformBrightnessOf(context);

      ref.read(systemThemeProvider.notifier).state = currentBrightness;
      _box.put(
        "theme",
        currentBrightness == Brightness.dark
            ? CustomTheme.dark.toString()
            : CustomTheme.light.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);

    return MaterialApp(
      themeMode:
          currentTheme == CustomTheme.light ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      home: const Root(),
    );
  }
}