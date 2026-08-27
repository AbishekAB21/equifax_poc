import 'package:equifax_poc/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: Scaffold(
        appBar: AppBar(title: Text(AppStrings.appName)),
        body: const Center(child: Text(AppStrings.appIsRunning)),
      ),
    );
  }
}
