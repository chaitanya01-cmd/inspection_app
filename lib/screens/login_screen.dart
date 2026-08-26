import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;
  final UserRole role;

  const LoginScreen({
    super.key,
    required this.authService,
    required this.role,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  String get roleTitle {
    if (widget.role == UserRole.inspector) {
      return 'Inspector Login';
    }

    return 'Municipal Officer Login';
  }

  IconData get roleIcon {
    if (widget.role == UserRole.inspector) {
      return Icons.engineering;
    }

    return Icons.account_balance;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final success = await widget.authService.login(
      _emailController.text,
      _passwordController.text,
      widget.role,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid email or password',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roleTitle),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,

                children: [
                  // ROLE ICON
                  Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0),
                        borderRadius:
                        BorderRadius.circular(22),
                      ),
                      child: Icon(
                        roleIcon,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // TITLE
                  Text(
                    roleTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Sign in to continue to your dashboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // EMAIL
                  TextFormField(
                    controller: _emailController,
                    keyboardType:
                    TextInputType.emailAddress,

                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon:
                      Icon(Icons.email_outlined),
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // PASSWORD
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,

                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',

                      prefixIcon:
                      const Icon(Icons.lock_outline),

                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),

                        onPressed: () {
                          setState(() {
                            _isPasswordVisible =
                            !_isPasswordVisible;
                          });
                        },
                      ),
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Please enter your password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // FORGOT PASSWORD
                  Align(
                    alignment: Alignment.centerRight,

                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Forgot password coming soon',
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        'Forgot Password?',
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // LOGIN BUTTON
                  ElevatedButton(
                    onPressed:
                    _isLoading ? null : _login,

                    child: _isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,

                      child:
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CHANGE ROLE
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      '← Change Role',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
