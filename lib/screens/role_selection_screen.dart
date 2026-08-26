import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../services/auth_service.dart';

class RoleSelectionScreen extends StatelessWidget {
  final AuthService authService;

  const RoleSelectionScreen({
    super.key,
    required this.authService,
  });

  void _selectRole(
      BuildContext context,
      UserRole role,
      ) {
    Navigator.pushNamed(
      context,
      '/login',
      arguments: role,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.location_city,
                  color: Colors.white,
                  size: 50,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Please select your role to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              // INSPECTOR
              _RoleCard(
                icon: Icons.engineering,
                title: 'Inspector',
                description:
                'Login as an inspector to perform inspections and manage inspection records.',
                color: Colors.blue,
                onTap: () {
                  _selectRole(
                    context,
                    UserRole.inspector,
                  );
                },
              ),

              const SizedBox(height: 20),

              // MUNICIPAL OFFICER
              _RoleCard(
                icon: Icons.account_balance,
                title: 'Municipal Officer',
                description:
                'Login as a municipal officer to monitor inspections and manage reports.',
                color: Colors.green,
                onTap: () {
                  _selectRole(
                    context,
                    UserRole.municipal,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
