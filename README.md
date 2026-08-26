# Inspection App

A Flutter-based Municipal Inspection System that supports user authentication, role-based access, inspection reporting, and infrastructure risk management.

## Features

- Splash screen
- Role selection
- User login
- Inspector dashboard
- Municipal officer dashboard
- Create inspection reports
- View inspection report details
- Report status tracking
- Severity levels
- Critical and repeated report monitoring

## User Roles

### Inspector

Inspectors can:

- View inspection reports
- Create new inspections
- Track open reports
- View critical reports
- View repeated reports
- View report details

### Municipal Officer

Municipal officers can access their role-specific dashboard and manage inspection-related information.

## Project Structure

```text
lib/
├── main.dart
├── models/
│   ├── user_role.dart
│   └── inspection_report.dart
├── routes/
│   └── app_routes.dart
├── screens/
│   ├── splash_screen.dart
│   ├── role_selection_screen.dart
│   ├── login_screen.dart
│   ├── inspector_dashboard.dart
│   ├── municipal_dashboard.dart
│   ├── dashboard_screen.dart
│   ├── inspection_form_screen.dart
│   └── report_detail_screen.dart
├── services/
│   ├── auth_service.dart
│   └── inspection_service.dart
├── theme/
│   └── app_theme.dart
├── utils/
│   └── app_constants.dart
└── widgets/
    ├── app_button.dart
    ├── dashboard_card.dart
    └── report_card.dart