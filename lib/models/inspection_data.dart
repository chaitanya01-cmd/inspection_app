class InspectionData {
  // Inspection identification
  final String inspectionId;

  // Infrastructure information
  final String infrastructureType;
  final String severity;
  final String condition;
  final String publicImportance;

  // Report history
  final int repeatedReports;
  final int nearbyProblems;

  // Location information
  final double latitude;
  final double longitude;

  // Inspection date and time
  final DateTime inspectionDateTime;

  InspectionData({
    required this.inspectionId,
    required this.infrastructureType,
    required this.severity,
    required this.condition,
    required this.publicImportance,
    required this.repeatedReports,
    required this.nearbyProblems,
    required this.latitude,
    required this.longitude,
    required this.inspectionDateTime,
  });
}