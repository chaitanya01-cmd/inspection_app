import '../models/inspection_report.dart';

class InspectionService {
  static final List<InspectionReport> _reports = [
    InspectionReport(
      id: 'REP-001',

      // ==========================================
      // INSPECTION DETAILS
      // ==========================================
      inspectionDate: DateTime.now(),
      inspectorName: 'Inspector',
      inspectorId: 'INS-001',
      department: 'Municipal Inspection Department',
      inspectionType: 'Infrastructure Inspection',

      // ==========================================
      // ASSET / LOCATION
      // ==========================================
      assetName: 'Main Road Bridge',
      assetType: 'Bridge',
      address: 'Central City Area',
      ward: 'Ward 5',
      zone: 'North Zone',
      latitude: null,
      longitude: null,
      assetAge: 18,
      responsibleAuthority: 'Municipal Corporation',

      // ==========================================
      // HAZARD DETAILS
      // ==========================================
      hazardCategory: 'Structural Damage',
      hazardDescription:
          'Visible cracks and surface deterioration were found on the bridge structure.',
      rootCause: 'Ageing infrastructure and continuous heavy traffic.',
      affectedArea: 'Bridge support and roadway surface',

      visibleDamage: true,
      damageDescription:
          'Multiple cracks visible on the concrete surface.',

      previousIncidents: true,
      previousIncidentCount: 2,
      repeatedReports: true,

      // ==========================================
      // RISK FACTORS
      // ==========================================
      likelihoodScore: 4,
      impactScore: 5,
      exposureScore: 5,
      vulnerabilityScore: 4,
      urgencyScore: 5,
      detectabilityScore: 4,
      controlEffectivenessScore: 2,

      // ==========================================
      // IMPACT ANALYSIS
      // ==========================================
      humanSafetyImpact: 5,
      propertyImpact: 4,
      environmentalImpact: 2,
      financialImpact: 4,
      serviceDisruptionImpact: 5,

      // ==========================================
      // RISK ENGINE RESULT
      // 4 × 5 × 5 × 4 = 400
      // ==========================================
      riskScore: 400,
      riskLevel: 'High',
      severity: 'Critical',
      status: 'Open',

      // ==========================================
      // EVIDENCE
      // ==========================================
      imagePaths: [],
      evidenceNotes:
          'Visual inspection completed. Photographic evidence will be attached.',

      // ==========================================
      // ACTION PLAN
      // ==========================================
      immediateActionRequired: true,
      immediateAction:
          'Restrict heavy vehicle movement until a detailed structural assessment is completed.',
      recommendedAction:
          'Conduct structural engineering assessment and repair damaged sections.',
      responsibleDepartment: 'Public Works Department',
      priority: 'High',
      targetResolutionDate:
          DateTime.now().add(const Duration(days: 7)),

      // ==========================================
      // INSPECTOR NOTES
      // ==========================================
      inspectorNotes:
          'This location requires immediate engineering review.',
    ),
  ];

  // ==========================================
  // GET ALL REPORTS
  // ==========================================
  static List<InspectionReport> getReports() {
    return List.unmodifiable(_reports);
  }

  // ==========================================
  // GET REPORT BY ID
  // ==========================================
  static InspectionReport? getReportById(String id) {
    try {
      return _reports.firstWhere(
        (report) => report.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  // ==========================================
  // ADD NEW REPORT
  // ==========================================
  static void addReport(InspectionReport report) {
    _reports.insert(0, report);
  }

  // ==========================================
  // UPDATE EXISTING REPORT
  // ==========================================
  static void updateReport(InspectionReport updatedReport) {
    final index = _reports.indexWhere(
      (report) => report.id == updatedReport.id,
    );

    if (index != -1) {
      _reports[index] = updatedReport;
    }
  }

  // ==========================================
  // DELETE REPORT
  // ==========================================
  static void deleteReport(String id) {
    _reports.removeWhere(
      (report) => report.id == id,
    );
  }

  // ==========================================
  // GENERATE REPORT ID
  // ==========================================
  static String generateReportId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    return 'REP-$timestamp';
  }

  // ==========================================
  // CALCULATE RISK
  // ==========================================
  static double calculateRisk({
    required int likelihood,
    required int impact,
    required int exposure,
    required int vulnerability,
  }) {
    return InspectionReport.calculateRiskScore(
      likelihood: likelihood,
      impact: impact,
      exposure: exposure,
      vulnerability: vulnerability,
    );
  }

  // ==========================================
  // CALCULATE RISK LEVEL
  // ==========================================
  static String getRiskLevel(double score) {
    return InspectionReport.calculateRiskLevel(score);
  }

  // ==========================================
  // DASHBOARD STATISTICS
  // ==========================================
  static int get totalReports => _reports.length;

  static int get openReports {
    return _reports
        .where((report) => report.status != 'Resolved')
        .length;
  }

  static int get criticalReports {
    return _reports
        .where(
          (report) =>
              report.riskLevel == 'Critical' ||
              report.severity == 'Critical',
        )
        .length;
  }

  static int get repeatedReports {
    return _reports
        .where((report) => report.repeatedReports)
        .length;
  }
}