import 'package:flutter/material.dart';

import '../models/inspection_data.dart';
import '../models/risk_result.dart';
import '../services/risk_engine.dart';

class RiskEngineScreen extends StatefulWidget {
  const RiskEngineScreen({super.key});

  @override
  State<RiskEngineScreen> createState() => _RiskEngineScreenState();
}

class _RiskEngineScreenState extends State<RiskEngineScreen> {
  // =====================================
  // DEFAULT FORM VALUES
  // =====================================

  String infrastructureType = 'Road';
  String severity = 'Low';
  String condition = 'Good';
  String publicImportance = 'Low';

  // =====================================
  // TEMPORARY PROTOTYPE DATA
  // =====================================

  final String inspectionId = 'INSP-001';
  final double latitude = 12.9716;
  final double longitude = 77.5946;

  // =====================================
  // TEXT CONTROLLERS
  // =====================================

  final TextEditingController repeatedReportsController =
      TextEditingController();

  final TextEditingController nearbyProblemsController =
      TextEditingController();

  // =====================================
  // RISK RESULT
  // =====================================

  RiskResult? result;

  // =====================================
  // RISK COLOUR
  // =====================================

  Color getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return Colors.green;

      case 'medium':
        return Colors.orange;

      case 'high':
        return Colors.red;

      case 'critical':
        return Colors.red.shade900;

      default:
        return Colors.grey;
    }
  }

  // =====================================
  // PRIORITY COLOUR
  // =====================================

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return Colors.green;

      case 'medium':
        return Colors.orange;

      case 'high':
        return Colors.red;

      case 'critical':
        return Colors.red.shade900;

      default:
        return Colors.grey;
    }
  }

  // =====================================
  // VALIDATE NUMBER INPUT
  // =====================================

  int? validateNonNegativeNumber(
    String value,
    String fieldName,
  ) {
    // Empty field is treated as 0.
    if (value.trim().isEmpty) {
      return 0;
    }

    final int? number = int.tryParse(value.trim());

    if (number == null) {
      showErrorMessage(
        '$fieldName must contain a valid whole number.',
      );
      return null;
    }

    if (number < 0) {
      showErrorMessage(
        '$fieldName cannot be negative.',
      );
      return null;
    }

    return number;
  }

  // =====================================
  // SHOW ERROR MESSAGE
  // =====================================

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =====================================
  // ANALYZE RISK
  // =====================================

  void analyzeRisk() {
    final int? repeatedReports = validateNonNegativeNumber(
      repeatedReportsController.text,
      'Number of Repeated Reports',
    );

    if (repeatedReports == null) {
      return;
    }

    final int? nearbyProblems = validateNonNegativeNumber(
      nearbyProblemsController.text,
      'Nearby Infrastructure Problems',
    );

    if (nearbyProblems == null) {
      return;
    }

    // Create inspection data.
    final inspectionData = InspectionData(
      inspectionId: inspectionId,
      infrastructureType: infrastructureType,
      severity: severity,
      condition: condition,
      publicImportance: publicImportance,
      repeatedReports: repeatedReports,
      nearbyProblems: nearbyProblems,
      latitude: latitude,
      longitude: longitude,
      inspectionDateTime: DateTime.now(),
    );

    // Analyze risk.
    final RiskResult riskResult =
        RiskEngine.analyze(inspectionData);

    setState(() {
      result = riskResult;
    });
  }

  // =====================================
  // RESET / NEW INSPECTION
  // =====================================

  void resetInspection() {
    setState(() {
      infrastructureType = 'Road';
      severity = 'Low';
      condition = 'Good';
      publicImportance = 'Low';

      repeatedReportsController.clear();
      nearbyProblemsController.clear();

      result = null;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
  }

  // =====================================
  // DISPOSE
  // =====================================

  @override
  void dispose() {
    repeatedReportsController.dispose();
    nearbyProblemsController.dispose();
    super.dispose();
  }

  // =====================================
  // SECTION TITLE
  // =====================================

  Widget sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // =====================================
  // REUSABLE RESULT CARD
  // =====================================

  Widget resultCard({
    required String title,
    required Widget child,
    IconData? icon,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            child,
          ],
        ),
      ),
    );
  }

  // =====================================
  // BUILD SCREEN
  // =====================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infrastructure Risk Engine'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // =====================================
          // HEADER
          // =====================================

          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.account_balance,
                    size: 45,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Municipal Infrastructure Inspection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Inspection ID: $inspectionId',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'GPS: $latitude, $longitude',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          // =====================================
          // INSPECTION DETAILS
          // =====================================

          sectionTitle(
            'Inspection Details',
            Icons.assignment,
          ),

          const SizedBox(height: 15),

          // INFRASTRUCTURE TYPE

          const Text(
            'Infrastructure Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: infrastructureType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Road',
                child: Text('Road'),
              ),
              DropdownMenuItem(
                value: 'Bridge',
                child: Text('Bridge'),
              ),
              DropdownMenuItem(
                value: 'Streetlight',
                child: Text('Streetlight'),
              ),
              DropdownMenuItem(
                value: 'Water Pipe',
                child: Text('Water Pipe'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                infrastructureType = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // SEVERITY

          const Text(
            'Severity of Problem',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: severity,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Low',
                child: Text('Low'),
              ),
              DropdownMenuItem(
                value: 'Medium',
                child: Text('Medium'),
              ),
              DropdownMenuItem(
                value: 'High',
                child: Text('High'),
              ),
              DropdownMenuItem(
                value: 'Critical',
                child: Text('Critical'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                severity = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // INFRASTRUCTURE CONDITION

          const Text(
            'Infrastructure Condition',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: condition,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Good',
                child: Text('Good'),
              ),
              DropdownMenuItem(
                value: 'Minor Damage',
                child: Text('Minor Damage'),
              ),
              DropdownMenuItem(
                value: 'Damaged',
                child: Text('Damaged'),
              ),
              DropdownMenuItem(
                value: 'Severely Damaged',
                child: Text('Severely Damaged'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                condition = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // PUBLIC IMPORTANCE

          const Text(
            'Public Importance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: publicImportance,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Low',
                child: Text('Low'),
              ),
              DropdownMenuItem(
                value: 'Medium',
                child: Text('Medium'),
              ),
              DropdownMenuItem(
                value: 'High',
                child: Text('High'),
              ),
              DropdownMenuItem(
                value: 'Critical',
                child: Text('Critical'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                publicImportance = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // REPEATED REPORTS

          TextField(
            controller: repeatedReportsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Number of Repeated Reports',
              hintText: 'Example: 5',
              prefixIcon: Icon(Icons.repeat),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          // NEARBY PROBLEMS

          TextField(
            controller: nearbyProblemsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nearby Infrastructure Problems',
              hintText: 'Example: 10',
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          // =====================================
          // ANALYZE RISK BUTTON
          // =====================================

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: analyzeRisk,
              icon: const Icon(Icons.analytics),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'ANALYZE RISK',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // =====================================
          // NEW INSPECTION BUTTON
          // =====================================

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: resetInspection,
              icon: const Icon(Icons.refresh),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'NEW INSPECTION',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // =====================================
          // RISK ANALYSIS RESULTS
          // =====================================

          if (result != null) ...[
            sectionTitle(
              'Risk Analysis Dashboard',
              Icons.dashboard,
            ),

            const SizedBox(height: 15),

            // =====================================
            // RISK SCORE CARD + PROGRESS BAR
            // =====================================

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Text(
                      'RISK SCORE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      '${result!.riskScore} / 100',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: getRiskColor(result!.riskLevel),
                      ),
                    ),

                    // NEW: RISK SCORE PROGRESS BAR

                    const SizedBox(height: 15),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (result!.riskScore / 100)
                            .clamp(0.0, 1.0),
                        minHeight: 14,
                        color: getRiskColor(result!.riskLevel),
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      result!.riskLevel,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: getRiskColor(result!.riskLevel),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // RISK LEVEL BADGE

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: getRiskColor(
                          result!.riskLevel,
                        ).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: getRiskColor(result!.riskLevel),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        '${result!.riskLevel.toUpperCase()} RISK',
                        style: TextStyle(
                          color: getRiskColor(result!.riskLevel),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =====================================
            // COLOUR-CODED PRIORITY CARD
            // =====================================

            Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Icon(
                      Icons.priority_high,
                      size: 35,
                      color: getPriorityColor(result!.priority),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Priority',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: getPriorityColor(
                                result!.priority,
                              ).withValues(alpha: 0.15),
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            child: Text(
                              result!.priority.toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: getPriorityColor(
                                  result!.priority,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================
            // INSPECTION INFORMATION
            // =====================================

            resultCard(
              title: 'Inspection Information',
              icon: Icons.description,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inspection ID: ${result!.inspectionId}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'GPS: ${result!.latitude}, ${result!.longitude}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Analyzed At: ${result!.analyzedAt}',
                  ),
                ],
              ),
            ),

            // =====================================
            // WHY THIS SCORE?
            // =====================================

            resultCard(
              title: 'Why This Score?',
              icon: Icons.lightbulb_outline,
              child: Column(
                children: result!.riskExplanation
                    .map(
                      (explanation) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                explanation,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            // =====================================
            // ANOMALY DETECTION
            // =====================================

            resultCard(
              title: 'Anomaly Detection',
              icon: Icons.warning_amber_rounded,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    result!.anomalyStatus,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Reason',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    result!.anomalyReason,
                  ),
                ],
              ),
            ),

            // =====================================
            // RECOMMENDED ACTION
            // =====================================

            resultCard(
              title: 'Recommended Action',
              icon: Icons.build_circle_outlined,
              child: Text(
                result!.recommendedAction,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // =====================================
            // DASHBOARD SUMMARY
            // =====================================

            resultCard(
              title: 'Dashboard Summary',
              icon: Icons.summarize,
              child: Text(
                result!.dashboardSummary,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ],
      ),
    );
  }
}