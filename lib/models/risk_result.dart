class RiskResult {
  // =================================
  // INSPECTION IDENTIFICATION
  // =================================

  final String inspectionId;

  // =================================
  // LOCATION INFORMATION
  // =================================

  final double latitude;
  final double longitude;

  // =================================
  // RISK ANALYSIS
  // =================================

  final int riskScore;
  final String riskLevel;
  final String priority;

  // =================================
  // RISK EXPLANATION
  // =================================

  // Shows exactly why the risk score
  // was calculated.
  final List<String> riskExplanation;

  // =================================
  // ANOMALY DETECTION
  // =================================

  final String anomalyStatus;
  final String anomalyReason;

  // =================================
  // RECOMMENDATION
  // =================================

  final String recommendedAction;

  // =================================
  // ANALYSIS TIME
  // =================================

  final DateTime analyzedAt;

  RiskResult({
    required this.inspectionId,
    required this.latitude,
    required this.longitude,
    required this.riskScore,
    required this.riskLevel,
    required this.priority,
    required this.riskExplanation,
    required this.anomalyStatus,
    required this.anomalyReason,
    required this.recommendedAction,
    required this.analyzedAt,
  });

  // =================================
  // DASHBOARD SUMMARY
  // =================================

  String get dashboardSummary {
    return '$inspectionId | $riskLevel Risk | '
        '$priority Priority | Score: $riskScore/100';
  }
}