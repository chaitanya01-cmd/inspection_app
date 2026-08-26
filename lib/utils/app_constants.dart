class AppConstants {
  // App information
  static const String appName = 'Municipal Inspection System';

  // Report statuses
  static const String statusOpen = 'Open';
  static const String statusInProgress = 'In Progress';
  static const String statusResolved = 'Resolved';

  // Severity levels
  static const String severityLow = 'Low';
  static const String severityMedium = 'Medium';
  static const String severityHigh = 'High';
  static const String severityCritical = 'Critical';

  // Lists for dropdowns
  static const List<String> severityLevels = [
    severityLow,
    severityMedium,
    severityHigh,
    severityCritical,
  ];

  static const List<String> reportStatuses = [
    statusOpen,
    statusInProgress,
    statusResolved,
  ];
}