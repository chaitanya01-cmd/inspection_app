import 'package:flutter/material.dart';

import 'municipal_shell.dart';
import '../services/auth_service.dart';

class MunicipalDashboard extends StatelessWidget {
  final AuthService authService;

  const MunicipalDashboard({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return const MunicipalShell();
  }
}