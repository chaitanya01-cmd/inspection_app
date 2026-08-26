import 'package:flutter/material.dart';
import 'screens/risk_engine_screen.dart';

void main() {
  runApp(const RiskEngineApp());
}

class RiskEngineApp extends StatelessWidget {
  const RiskEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Risk Engine App',
      home: const RiskEngineScreen(),
    );
  }
}