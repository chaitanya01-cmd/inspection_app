import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  final AuthService authService;

  const SplashScreen({
    super.key,
    required this.authService,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _startApp();
  }

  Future<void> _startApp() async {
    // Keep splash screen visible for 2 seconds.
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    // -----------------------------------------
    // USER ALREADY LOGGED IN
    // -----------------------------------------
    if (widget.authService.isLoggedIn) {
      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
      );

      return;
    }

    // -----------------------------------------
    // NEW / LOGGED-OUT USER
    // -----------------------------------------
    // First select Inspector or Municipal Officer.
    Navigator.pushReplacementNamed(
      context,
      '/role-selection',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1565C0),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // =====================================
                // APP LOGO
                // =====================================

                Container(
                  width: 105,
                  height: 105,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.18,
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.location_city,
                    size: 58,
                    color: Color(0xFF1565C0),
                  ),
                ),

                const SizedBox(height: 30),

                // =====================================
                // APP NAME
                // =====================================

                const Text(
                  'Municipal Inspection',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 10),

                // =====================================
                // APP DESCRIPTION
                // =====================================

                const Text(
                  'Smart Inspection & Management System',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 45),

                // =====================================
                // LOADING INDICATOR
                // =====================================

                const SizedBox(
                  width: 32,
                  height: 32,

                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
