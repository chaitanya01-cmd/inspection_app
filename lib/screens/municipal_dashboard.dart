import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class MunicipalDashboard extends StatelessWidget {
  final AuthService authService;

  const MunicipalDashboard({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Municipal Dashboard',
        ),

        actions: [

          IconButton(

            icon: const Icon(
              Icons.logout,
            ),

            onPressed: () {

              authService.logout();

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                    (route) => false,
              );
            },
          ),
        ],
      ),

      body: const Center(

        child: Text(
          'Municipal Dashboard\n\nYour teammate will build this screen.',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
