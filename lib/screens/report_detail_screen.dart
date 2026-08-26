import 'package:flutter/material.dart';

import '../models/inspection_report.dart';

class ReportDetailScreen extends StatelessWidget {
  final InspectionReport report;

  const ReportDetailScreen({
    super.key,
    required this.report,
  });

  Color _getRiskColor() {
    switch (report.riskLevel) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber.shade800;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _scoreRow(
    String label,
    int score,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            '$score / 5',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final riskColor = _getRiskColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Report'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ==========================================
          // RISK SUMMARY
          // ==========================================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Risk Engine Assessment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    report.riskScore.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),

                  Text(
                    report.riskLevel,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Status: ${report.status}',
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // INSPECTION DETAILS
          // ==========================================
          _sectionTitle(
            'Inspection Details',
            Icons.assignment,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _detailRow(
                    'Report ID',
                    report.id,
                  ),
                  _detailRow(
                    'Inspection Type',
                    report.inspectionType,
                  ),
                  _detailRow(
                    'Inspector',
                    report.inspectorName,
                  ),
                  _detailRow(
                    'Inspector ID',
                    report.inspectorId,
                  ),
                  _detailRow(
                    'Department',
                    report.department,
                  ),
                  _detailRow(
                    'Inspection Date',
                    report.inspectionDate.toString(),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // ASSET DETAILS
          // ==========================================
          _sectionTitle(
            'Asset & Location',
            Icons.location_city,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _detailRow(
                    'Asset Name',
                    report.assetName,
                  ),
                  _detailRow(
                    'Asset Type',
                    report.assetType,
                  ),
                  _detailRow(
                    'Address',
                    report.address,
                  ),
                  _detailRow(
                    'Ward',
                    report.ward,
                  ),
                  _detailRow(
                    'Zone',
                    report.zone,
                  ),
                  _detailRow(
                    'Asset Age',
                    '${report.assetAge} years',
                  ),
                  _detailRow(
                    'Authority',
                    report.responsibleAuthority,
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // HAZARD DETAILS
          // ==========================================
          _sectionTitle(
            'Hazard Identification',
            Icons.warning_amber_rounded,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _detailRow(
                    'Hazard Category',
                    report.hazardCategory,
                  ),
                  _detailRow(
                    'Description',
                    report.hazardDescription,
                  ),
                  _detailRow(
                    'Root Cause',
                    report.rootCause,
                  ),
                  _detailRow(
                    'Affected Area',
                    report.affectedArea,
                  ),
                  _detailRow(
                    'Visible Damage',
                    report.visibleDamage ? 'Yes' : 'No',
                  ),
                  _detailRow(
                    'Damage Details',
                    report.damageDescription.isEmpty
                        ? 'Not specified'
                        : report.damageDescription,
                  ),
                  _detailRow(
                    'Previous Incidents',
                    report.previousIncidents ? 'Yes' : 'No',
                  ),
                  _detailRow(
                    'Incident Count',
                    report.previousIncidentCount.toString(),
                  ),
                  _detailRow(
                    'Repeated Reports',
                    report.repeatedReports ? 'Yes' : 'No',
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // RISK FACTORS
          // ==========================================
          _sectionTitle(
            'Core Risk Factors',
            Icons.analytics,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _scoreRow(
                    'Likelihood',
                    report.likelihoodScore,
                  ),
                  _scoreRow(
                    'Impact',
                    report.impactScore,
                  ),
                  _scoreRow(
                    'Exposure',
                    report.exposureScore,
                  ),
                  _scoreRow(
                    'Vulnerability',
                    report.vulnerabilityScore,
                  ),
                  const Divider(),
                  _detailRow(
                    'Risk Formula',
                    'Likelihood × Impact × Exposure × Vulnerability',
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // ADDITIONAL FACTORS
          // ==========================================
          _sectionTitle(
            'Additional Risk Factors',
            Icons.tune,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _scoreRow(
                    'Urgency',
                    report.urgencyScore,
                  ),
                  _scoreRow(
                    'Detectability',
                    report.detectabilityScore,
                  ),
                  _scoreRow(
                    'Control Effectiveness',
                    report.controlEffectivenessScore,
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // IMPACT ANALYSIS
          // ==========================================
          _sectionTitle(
            'Impact Analysis',
            Icons.groups,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _scoreRow(
                    'Human Safety',
                    report.humanSafetyImpact,
                  ),
                  _scoreRow(
                    'Property / Asset',
                    report.propertyImpact,
                  ),
                  _scoreRow(
                    'Environmental',
                    report.environmentalImpact,
                  ),
                  _scoreRow(
                    'Financial',
                    report.financialImpact,
                  ),
                  _scoreRow(
                    'Service Disruption',
                    report.serviceDisruptionImpact,
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // EVIDENCE
          // ==========================================
          _sectionTitle(
            'Evidence',
            Icons.camera_alt,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _detailRow(
                    'Photos',
                    report.imagePaths.isEmpty
                        ? 'No photos attached'
                        : '${report.imagePaths.length} photo(s)',
                  ),
                  _detailRow(
                    'Evidence Notes',
                    report.evidenceNotes.isEmpty
                        ? 'No evidence notes'
                        : report.evidenceNotes,
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // ACTION PLAN
          // ==========================================
          _sectionTitle(
            'Mitigation & Action Plan',
            Icons.assignment_turned_in,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _detailRow(
                    'Immediate Action',
                    report.immediateActionRequired
                        ? 'Required'
                        : 'Not Required',
                  ),
                  _detailRow(
                    'Immediate Action Plan',
                    report.immediateAction.isEmpty
                        ? 'Not specified'
                        : report.immediateAction,
                  ),
                  _detailRow(
                    'Recommended Action',
                    report.recommendedAction,
                  ),
                  _detailRow(
                    'Responsible Department',
                    report.responsibleDepartment,
                  ),
                  _detailRow(
                    'Priority',
                    report.priority,
                  ),
                  _detailRow(
                    'Target Resolution',
                    report.targetResolutionDate.toString(),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // INSPECTOR NOTES
          // ==========================================
          _sectionTitle(
            'Inspector Notes',
            Icons.notes,
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                report.inspectorNotes.isEmpty
                    ? 'No additional notes.'
                    : report.inspectorNotes,
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}