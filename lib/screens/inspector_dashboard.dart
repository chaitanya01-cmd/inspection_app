import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class InspectorDashboard extends StatelessWidget {
  final AuthService authService;

  const InspectorDashboard({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Inspector Dashboard',
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
          'Inspector Dashboard\n\nYour teammate will build this screen.',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
