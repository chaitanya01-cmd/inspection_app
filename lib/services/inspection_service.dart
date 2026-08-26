import '../models/inspection_report.dart';

class InspectionService {
  static final List<InspectionReport> _reports = [];

  static List<InspectionReport> getReports() {
    return List<InspectionReport>.from(_reports);
  }

  static void addReport(InspectionReport report) {
    _reports.add(report);
  }

  static void removeReport(String id) {
    _reports.removeWhere((report) => report.id == id);
  }
}