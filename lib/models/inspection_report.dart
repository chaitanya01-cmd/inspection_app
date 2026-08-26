class InspectionReport {
  final String id;

  // ==========================================
  // INSPECTION DETAILS
  // ==========================================
  final DateTime inspectionDate;
  final String inspectorName;
  final String inspectorId;
  final String department;
  final String inspectionType;

  // ==========================================
  // ASSET / LOCATION DETAILS
  // ==========================================
  final String assetName;
  final String assetType;
  final String address;
  final String ward;
  final String zone;
  final double? latitude;
  final double? longitude;
  final int assetAge;
  final String responsibleAuthority;

  // ==========================================
  // HAZARD DETAILS
  // ==========================================
  final String hazardCategory;
  final String hazardDescription;
  final String rootCause;
  final String affectedArea;

  final bool visibleDamage;
  final String damageDescription;

  final bool previousIncidents;
  final int previousIncidentCount;
  final bool repeatedReports;

  // ==========================================
  // RISK FACTORS
  // ==========================================
  final int likelihoodScore;
  final int impactScore;
  final int exposureScore;
  final int vulnerabilityScore;
  final int urgencyScore;
  final int detectabilityScore;
  final int controlEffectivenessScore;

  // ==========================================
  // IMPACT ANALYSIS
  // ==========================================
  final int humanSafetyImpact;
  final int propertyImpact;
  final int environmentalImpact;
  final int financialImpact;
  final int serviceDisruptionImpact;

  // ==========================================
  // RISK ENGINE RESULT
  // ==========================================
  final double riskScore;
  final String riskLevel;
  final String severity;
  final String status;

  // ==========================================
  // EVIDENCE
  // ==========================================
  final List<String> imagePaths;
  final String evidenceNotes;

  // ==========================================
  // ACTION PLAN
  // ==========================================
  final bool immediateActionRequired;
  final String immediateAction;
  final String recommendedAction;
  final String responsibleDepartment;
  final String priority;
  final DateTime targetResolutionDate;

  // ==========================================
  // INSPECTOR NOTES
  // ==========================================
  final String inspectorNotes;

  InspectionReport({
    required this.id,

    // Inspection details
    required this.inspectionDate,
    required this.inspectorName,
    required this.inspectorId,
    required this.department,
    required this.inspectionType,

    // Asset / location
    required this.assetName,
    required this.assetType,
    required this.address,
    required this.ward,
    required this.zone,
    this.latitude,
    this.longitude,
    required this.assetAge,
    required this.responsibleAuthority,

    // Hazard
    required this.hazardCategory,
    required this.hazardDescription,
    required this.rootCause,
    required this.affectedArea,
    required this.visibleDamage,
    required this.damageDescription,
    required this.previousIncidents,
    required this.previousIncidentCount,
    required this.repeatedReports,

    // Risk factors
    required this.likelihoodScore,
    required this.impactScore,
    required this.exposureScore,
    required this.vulnerabilityScore,
    required this.urgencyScore,
    required this.detectabilityScore,
    required this.controlEffectivenessScore,

    // Impact analysis
    required this.humanSafetyImpact,
    required this.propertyImpact,
    required this.environmentalImpact,
    required this.financialImpact,
    required this.serviceDisruptionImpact,

    // Risk engine
    required this.riskScore,
    required this.riskLevel,
    required this.severity,
    required this.status,

    // Evidence
    required this.imagePaths,
    required this.evidenceNotes,

    // Action plan
    required this.immediateActionRequired,
    required this.immediateAction,
    required this.recommendedAction,
    required this.responsibleDepartment,
    required this.priority,
    required this.targetResolutionDate,

    // Notes
    required this.inspectorNotes,
  });

  // ==========================================
  // RISK SCORE CALCULATION
  // ==========================================
  //
  // Base risk formula:
  //
  // Risk = Likelihood × Impact × Exposure × Vulnerability
  //
  static double calculateRiskScore({
    required int likelihood,
    required int impact,
    required int exposure,
    required int vulnerability,
  }) {
    return (likelihood * impact * exposure * vulnerability).toDouble();
  }

  // ==========================================
  // RISK LEVEL CLASSIFICATION
  // ==========================================
  static String calculateRiskLevel(double score) {
    if (score >= 400) {
      return 'Critical';
    }

    if (score >= 250) {
      return 'High';
    }

    if (score >= 100) {
      return 'Medium';
    }

    if (score >= 25) {
      return 'Low';
    }

    return 'Very Low';
  }

  // ==========================================
  // COPY WITH
  // Useful when updating report status later.
  // ==========================================
  InspectionReport copyWith({
    String? id,
    DateTime? inspectionDate,
    String? inspectorName,
    String? inspectorId,
    String? department,
    String? inspectionType,
    String? assetName,
    String? assetType,
    String? address,
    String? ward,
    String? zone,
    double? latitude,
    double? longitude,
    int? assetAge,
    String? responsibleAuthority,
    String? hazardCategory,
    String? hazardDescription,
    String? rootCause,
    String? affectedArea,
    bool? visibleDamage,
    String? damageDescription,
    bool? previousIncidents,
    int? previousIncidentCount,
    bool? repeatedReports,
    int? likelihoodScore,
    int? impactScore,
    int? exposureScore,
    int? vulnerabilityScore,
    int? urgencyScore,
    int? detectabilityScore,
    int? controlEffectivenessScore,
    int? humanSafetyImpact,
    int? propertyImpact,
    int? environmentalImpact,
    int? financialImpact,
    int? serviceDisruptionImpact,
    double? riskScore,
    String? riskLevel,
    String? severity,
    String? status,
    List<String>? imagePaths,
    String? evidenceNotes,
    bool? immediateActionRequired,
    String? immediateAction,
    String? recommendedAction,
    String? responsibleDepartment,
    String? priority,
    DateTime? targetResolutionDate,
    String? inspectorNotes,
  }) {
    return InspectionReport(
      id: id ?? this.id,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      inspectorName: inspectorName ?? this.inspectorName,
      inspectorId: inspectorId ?? this.inspectorId,
      department: department ?? this.department,
      inspectionType: inspectionType ?? this.inspectionType,
      assetName: assetName ?? this.assetName,
      assetType: assetType ?? this.assetType,
      address: address ?? this.address,
      ward: ward ?? this.ward,
      zone: zone ?? this.zone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      assetAge: assetAge ?? this.assetAge,
      responsibleAuthority:
          responsibleAuthority ?? this.responsibleAuthority,
      hazardCategory: hazardCategory ?? this.hazardCategory,
      hazardDescription:
          hazardDescription ?? this.hazardDescription,
      rootCause: rootCause ?? this.rootCause,
      affectedArea: affectedArea ?? this.affectedArea,
      visibleDamage: visibleDamage ?? this.visibleDamage,
      damageDescription:
          damageDescription ?? this.damageDescription,
      previousIncidents:
          previousIncidents ?? this.previousIncidents,
      previousIncidentCount:
          previousIncidentCount ?? this.previousIncidentCount,
      repeatedReports: repeatedReports ?? this.repeatedReports,
      likelihoodScore:
          likelihoodScore ?? this.likelihoodScore,
      impactScore: impactScore ?? this.impactScore,
      exposureScore: exposureScore ?? this.exposureScore,
      vulnerabilityScore:
          vulnerabilityScore ?? this.vulnerabilityScore,
      urgencyScore: urgencyScore ?? this.urgencyScore,
      detectabilityScore:
          detectabilityScore ?? this.detectabilityScore,
      controlEffectivenessScore:
          controlEffectivenessScore ??
              this.controlEffectivenessScore,
      humanSafetyImpact:
          humanSafetyImpact ?? this.humanSafetyImpact,
      propertyImpact: propertyImpact ?? this.propertyImpact,
      environmentalImpact:
          environmentalImpact ?? this.environmentalImpact,
      financialImpact: financialImpact ?? this.financialImpact,
      serviceDisruptionImpact:
          serviceDisruptionImpact ??
              this.serviceDisruptionImpact,
      riskScore: riskScore ?? this.riskScore,
      riskLevel: riskLevel ?? this.riskLevel,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      imagePaths: imagePaths ?? this.imagePaths,
      evidenceNotes: evidenceNotes ?? this.evidenceNotes,
      immediateActionRequired:
          immediateActionRequired ??
              this.immediateActionRequired,
      immediateAction:
          immediateAction ?? this.immediateAction,
      recommendedAction:
          recommendedAction ?? this.recommendedAction,
      responsibleDepartment:
          responsibleDepartment ??
              this.responsibleDepartment,
      priority: priority ?? this.priority,
      targetResolutionDate:
          targetResolutionDate ??
              this.targetResolutionDate,
      inspectorNotes:
          inspectorNotes ?? this.inspectorNotes,
    );
  }
}