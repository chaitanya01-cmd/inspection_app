import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../services/auth_service.dart';

import '../screens/login_screen.dart';
import '../screens/role_selection_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/inspector_dashboard.dart';
import '../screens/municipal_dashboard.dart';

enum UserRole {
  inspector,
  municipal,
}
