import '../models/inspection_data.dart';
import '../models/risk_result.dart';

class RiskEngine {
  static RiskResult analyze(InspectionData data) {
    int score = 0;

    // This list stores the explanation for the risk score.
    final List<String> riskExplanation = [];

    // ========================================
    // 1. SEVERITY RISK
    // ========================================

    int severityScore = 0;

    if (data.severity == 'Low') {
      severityScore = 20;
    } else if (data.severity == 'Medium') {
      severityScore = 40;
    } else if (data.severity == 'High') {
      severityScore = 70;
    } else if (data.severity == 'Critical') {
      severityScore = 90;
    }

    score += severityScore;

    riskExplanation.add(
      'Severity: ${data.severity} → +$severityScore',
    );

    // ========================================
    // 2. INFRASTRUCTURE CONDITION RISK
    // ========================================

    int conditionScore = 0;

    if (data.condition == 'Good') {
      conditionScore = 0;
    } else if (data.condition == 'Minor Damage') {
      conditionScore = 10;
    } else if (data.condition == 'Damaged') {
      conditionScore = 20;
    } else if (data.condition == 'Severely Damaged') {
      conditionScore = 30;
    }

    score += conditionScore;

    riskExplanation.add(
      'Condition: ${data.condition} → +$conditionScore',
    );

    // ========================================
    // 3. PUBLIC IMPORTANCE RISK
    // ========================================

    int importanceScore = 0;

    if (data.publicImportance == 'Low') {
      importanceScore = 0;
    } else if (data.publicImportance == 'Medium') {
      importanceScore = 5;
    } else if (data.publicImportance == 'High') {
      importanceScore = 10;
    } else if (data.publicImportance == 'Critical') {
      importanceScore = 15;
    }

    score += importanceScore;

    riskExplanation.add(
      'Public Importance: ${data.publicImportance} → +$importanceScore',
    );

    // ========================================
    // 4. REPEATED REPORTS RISK
    // ========================================

    final int repeatedReportsScore = data.repeatedReports * 2;

    score += repeatedReportsScore;

    riskExplanation.add(
      'Repeated Reports: ${data.repeatedReports} → +$repeatedReportsScore',
    );

    // ========================================
    // 5. NEARBY PROBLEMS RISK
    // ========================================

    final int nearbyProblemsScore = data.nearbyProblems;

    score += nearbyProblemsScore;

    riskExplanation.add(
      'Nearby Problems: ${data.nearbyProblems} → +$nearbyProblemsScore',
    );

    // ========================================
    // 6. INFRASTRUCTURE TYPE IMPORTANCE
    // ========================================

    int infrastructureTypeScore = 0;

    if (data.infrastructureType == 'Bridge') {
      infrastructureTypeScore = 10;
    } else if (data.infrastructureType == 'Water Pipe') {
      infrastructureTypeScore = 5;
    } else if (data.infrastructureType == 'Road') {
      infrastructureTypeScore = 3;
    } else if (data.infrastructureType == 'Streetlight') {
      infrastructureTypeScore = 0;
    }

    score += infrastructureTypeScore;

    riskExplanation.add(
      'Infrastructure Type: ${data.infrastructureType} → +$infrastructureTypeScore',
    );

    // ========================================
    // 7. KEEP SCORE BETWEEN 0 AND 100
    // ========================================

    final int originalScore = score;

    if (score > 100) {
      score = 100;

      riskExplanation.add(
        'Raw calculated score: $originalScore → Final score capped at 100',
      );
    }

    // ========================================
    // 8. FIND RISK LEVEL
    // ========================================

    String level;

    if (score < 30) {
      level = 'LOW';
    } else if (score < 60) {
      level = 'MEDIUM';
    } else if (score < 80) {
      level = 'HIGH';
    } else {
      level = 'CRITICAL';
    }

    // ========================================
    // 9. FIND PRIORITY
    // ========================================

    String priority;

    if (score >= 80) {
      priority = 'URGENT';
    } else if (score >= 60) {
      priority = 'HIGH';
    } else if (score >= 30) {
      priority = 'MEDIUM';
    } else {
      priority = 'LOW';
    }

    // ========================================
    // 10. SMART ANOMALY DETECTION
    // ========================================

    String anomalyStatus;
    String anomalyReason;

    if ((data.severity == 'High' ||
            data.severity == 'Critical') &&
        (data.condition == 'Damaged' ||
            data.condition == 'Severely Damaged') &&
        (data.publicImportance == 'High' ||
            data.publicImportance == 'Critical')) {
      anomalyStatus = 'CRITICAL ANOMALY DETECTED';

      anomalyReason =
          'A serious infrastructure problem has been detected in a highly important public location.';
    } else if (data.repeatedReports >= 3 &&
        data.nearbyProblems >= 5) {
      anomalyStatus = 'ANOMALY DETECTED';

      anomalyReason =
          'Multiple reports and nearby infrastructure problems indicate a possible problem cluster.';
    } else if (data.severity == 'Critical' &&
        data.repeatedReports <= 1) {
      anomalyStatus = 'ANOMALY DETECTED';

      anomalyReason =
          'A sudden critical problem was reported with very few previous reports.';
    } else if (data.condition == 'Severely Damaged') {
      anomalyStatus = 'ANOMALY DETECTED';

      anomalyReason =
          'The infrastructure condition is severely damaged and requires immediate attention.';
    } else if (data.repeatedReports >= 5) {
      anomalyStatus = 'ANOMALY DETECTED';

      anomalyReason =
          'The same infrastructure problem has been reported repeatedly.';
    } else if (data.nearbyProblems >= 10) {
      anomalyStatus = 'ANOMALY DETECTED';

      anomalyReason =
          'A large number of nearby infrastructure problems have been detected.';
    } else {
      anomalyStatus = 'NO ANOMALY DETECTED';

      anomalyReason =
          'The inspection data does not show any unusual or dangerous pattern.';
    }

    // ========================================
    // 11. RECOMMENDED ACTION
    // ========================================

    String recommendedAction;

    if (score >= 80) {
      recommendedAction =
          'Emergency inspection and immediate repair required.';
    } else if (score >= 60) {
      recommendedAction =
          'High priority inspection required as soon as possible.';
    } else if (score >= 30) {
      recommendedAction =
          'Schedule an inspection and maintenance within 7 days.';
    } else {
      recommendedAction =
          'Monitor the problem and schedule routine maintenance.';
    }

    // ========================================
    // 12. RETURN COMPLETE RESULT
    // ========================================

    return RiskResult(
      inspectionId: data.inspectionId,
      latitude: data.latitude,
      longitude: data.longitude,

      riskScore: score,
      riskLevel: level,
      priority: priority,

      // New explainable AI / score explanation data
      riskExplanation: riskExplanation,

      anomalyStatus: anomalyStatus,
      anomalyReason: anomalyReason,

      recommendedAction: recommendedAction,

      analyzedAt: DateTime.now(),
    );
  }
}