class InspectionReport {
  final String id;
  final String location;
  final String description;
  final String severity;
  final String status;
  final bool repeatedReports;
  final DateTime createdAt;

  InspectionReport({
    required this.id,
    required this.location,
    required this.description,
    required this.severity,
    required this.status,
    required this.repeatedReports,
    required this.createdAt,
  });
}