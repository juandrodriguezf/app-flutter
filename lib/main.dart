import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const RateMyPcApp());
}

class RateMyPcApp extends StatefulWidget {
  const RateMyPcApp({super.key});

  @override
  State<RateMyPcApp> createState() => _RateMyPcAppState();
}

class _RateMyPcAppState extends State<RateMyPcApp> {
  late final AppState _appState = AppState();

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      appState: _appState,
      child: MaterialApp(
        title: 'RateMyPc',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const LoginScreen(),
      ),
    );
  }
}
