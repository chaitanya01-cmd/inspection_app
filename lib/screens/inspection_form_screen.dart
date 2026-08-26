import 'package:flutter/material.dart';

import '../models/inspection_report.dart';
import '../services/inspection_service.dart';

class InspectionFormScreen extends StatefulWidget {
  const InspectionFormScreen({super.key});

  @override
  State<InspectionFormScreen> createState() =>
      _InspectionFormScreenState();
}

class _InspectionFormScreenState extends State<InspectionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // ==========================================
  // TEXT CONTROLLERS
  // ==========================================

  final _inspectorNameController = TextEditingController();
  final _inspectorIdController = TextEditingController();

  final _assetNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _wardController = TextEditingController();
  final _zoneController = TextEditingController();
  final _assetAgeController = TextEditingController();
  final _authorityController = TextEditingController();

  final _hazardDescriptionController = TextEditingController();
  final _rootCauseController = TextEditingController();
  final _affectedAreaController = TextEditingController();
  final _damageDescriptionController = TextEditingController();

  final _previousIncidentCountController =
      TextEditingController(text: '0');

  final _evidenceNotesController = TextEditingController();

  final _immediateActionController = TextEditingController();
  final _recommendedActionController = TextEditingController();
  final _responsibleDepartmentController =
      TextEditingController();

  final _inspectorNotesController = TextEditingController();

  // ==========================================
  // DROPDOWN VALUES
  // ==========================================

  String _inspectionType = 'Infrastructure Inspection';

  String _assetType = 'Road';

  String _hazardCategory = 'Structural Damage';

  String _priority = 'Medium';

  // ==========================================
  // BOOLEAN VALUES
  // ==========================================

  bool _visibleDamage = false;
  bool _previousIncidents = false;
  bool _repeatedReports = false;
  bool _immediateActionRequired = false;

  // ==========================================
  // RISK SCORES
  // Scale: 1 to 5
  // ==========================================

  double _likelihoodScore = 3;
  double _impactScore = 3;
  double _exposureScore = 3;
  double _vulnerabilityScore = 3;

  double _urgencyScore = 3;
  double _detectabilityScore = 3;
  double _controlEffectivenessScore = 3;

  // ==========================================
  // IMPACT SCORES
  // ==========================================

  double _humanSafetyImpact = 3;
  double _propertyImpact = 3;
  double _environmentalImpact = 3;
  double _financialImpact = 3;
  double _serviceDisruptionImpact = 3;

  // ==========================================
  // CALCULATED RISK
  // ==========================================

  double get _riskScore {
    return InspectionService.calculateRisk(
      likelihood: _likelihoodScore.toInt(),
      impact: _impactScore.toInt(),
      exposure: _exposureScore.toInt(),
      vulnerability: _vulnerabilityScore.toInt(),
    );
  }

  String get _riskLevel {
    return InspectionService.getRiskLevel(_riskScore);
  }

  // ==========================================
  // DISPOSE
  // ==========================================

  @override
  void dispose() {
    _inspectorNameController.dispose();
    _inspectorIdController.dispose();

    _assetNameController.dispose();
    _addressController.dispose();
    _wardController.dispose();
    _zoneController.dispose();
    _assetAgeController.dispose();
    _authorityController.dispose();

    _hazardDescriptionController.dispose();
    _rootCauseController.dispose();
    _affectedAreaController.dispose();
    _damageDescriptionController.dispose();

    _previousIncidentCountController.dispose();

    _evidenceNotesController.dispose();

    _immediateActionController.dispose();
    _recommendedActionController.dispose();
    _responsibleDepartmentController.dispose();

    _inspectorNotesController.dispose();

    super.dispose();
  }

  // ==========================================
  // SAVE REPORT
  // ==========================================

  void _saveReport() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final report = InspectionReport(
      id: InspectionService.generateReportId(),

      // Inspection details
      inspectionDate: DateTime.now(),
      inspectorName: _inspectorNameController.text.trim(),
      inspectorId: _inspectorIdController.text.trim(),
      department: 'Municipal Inspection Department',
      inspectionType: _inspectionType,

      // Asset details
      assetName: _assetNameController.text.trim(),
      assetType: _assetType,
      address: _addressController.text.trim(),
      ward: _wardController.text.trim(),
      zone: _zoneController.text.trim(),
      latitude: null,
      longitude: null,
      assetAge: int.tryParse(_assetAgeController.text.trim()) ?? 0,
      responsibleAuthority: _authorityController.text.trim(),

      // Hazard details
      hazardCategory: _hazardCategory,
      hazardDescription: _hazardDescriptionController.text.trim(),
      rootCause: _rootCauseController.text.trim(),
      affectedArea: _affectedAreaController.text.trim(),

      visibleDamage: _visibleDamage,
      damageDescription: _damageDescriptionController.text.trim(),

      previousIncidents: _previousIncidents,
      previousIncidentCount:
          int.tryParse(_previousIncidentCountController.text.trim()) ?? 0,
      repeatedReports: _repeatedReports,

      // Risk factors
      likelihoodScore: _likelihoodScore.toInt(),
      impactScore: _impactScore.toInt(),
      exposureScore: _exposureScore.toInt(),
      vulnerabilityScore: _vulnerabilityScore.toInt(),

      urgencyScore: _urgencyScore.toInt(),
      detectabilityScore: _detectabilityScore.toInt(),
      controlEffectivenessScore:
          _controlEffectivenessScore.toInt(),

      // Impact analysis
      humanSafetyImpact: _humanSafetyImpact.toInt(),
      propertyImpact: _propertyImpact.toInt(),
      environmentalImpact: _environmentalImpact.toInt(),
      financialImpact: _financialImpact.toInt(),
      serviceDisruptionImpact:
          _serviceDisruptionImpact.toInt(),

      // Risk result
      riskScore: _riskScore,
      riskLevel: _riskLevel,
      severity: _riskLevel == 'Critical' ? 'Critical' : _riskLevel,
      status: 'Open',

      // Evidence
      imagePaths: [],
      evidenceNotes: _evidenceNotesController.text.trim(),

      // Action plan
      immediateActionRequired: _immediateActionRequired,
      immediateAction: _immediateActionController.text.trim(),
      recommendedAction:
          _recommendedActionController.text.trim(),
      responsibleDepartment:
          _responsibleDepartmentController.text.trim(),
      priority: _priority,
      targetResolutionDate:
          DateTime.now().add(const Duration(days: 7)),

      // Notes
      inspectorNotes: _inspectorNotesController.text.trim(),
    );

    InspectionService.addReport(report);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inspection report created successfully'),
      ),
    );

    Navigator.pop(context);
  }

  // ==========================================
  // SECTION TITLE
  // ==========================================

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
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

  // ==========================================
  // TEXT FIELD
  // ==========================================

  Widget _textField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  // ==========================================
  // DROPDOWN
  // ==========================================

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  // ==========================================
  // SCORE SLIDER
  // ==========================================

  Widget _scoreSlider({
    required String label,
    required String description,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label: ${value.toInt()}/5',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),

            Slider(
              value: value,
              min: 1,
              max: 5,
              divisions: 4,
              label: value.toInt().toString(),
              onChanged: onChanged,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: const [
                Text('Low'),
                Text('Medium'),
                Text('High'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SWITCH TILE
  // ==========================================

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // ==========================================
  // BUILD UI
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Risk Inspection'),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ======================================
            // INSPECTION DETAILS
            // ======================================

            _sectionTitle(
              'Inspection Details',
              Icons.assignment,
            ),

            _textField(
              controller: _inspectorNameController,
              label: 'Inspector Name',
            ),

            _textField(
              controller: _inspectorIdController,
              label: 'Inspector ID',
            ),

            _dropdown(
              label: 'Inspection Type',
              value: _inspectionType,
              items: const [
                'Infrastructure Inspection',
                'Building Inspection',
                'Road Inspection',
                'Bridge Inspection',
                'Drainage Inspection',
                'Electrical Inspection',
                'Environmental Inspection',
                'Emergency Inspection',
              ],
              onChanged: (value) {
                setState(() {
                  _inspectionType = value!;
                });
              },
            ),

            const Divider(height: 32),

            // ======================================
            // ASSET & LOCATION
            // ======================================

            _sectionTitle(
              'Asset & Location Details',
              Icons.location_city,
            ),

            _textField(
              controller: _assetNameController,
              label: 'Asset / Property Name',
            ),

            _dropdown(
              label: 'Asset Type',
              value: _assetType,
              items: const [
                'Road',
                'Bridge',
                'Building',
                'Drainage',
                'Water Pipeline',
                'Electrical Infrastructure',
                'Public Facility',
                'Other',
              ],
              onChanged: (value) {
                setState(() {
                  _assetType = value!;
                });
              },
            ),

            _textField(
              controller: _addressController,
              label: 'Address / Location',
              maxLines: 2,
            ),

            _textField(
              controller: _wardController,
              label: 'Ward',
            ),

            _textField(
              controller: _zoneController,
              label: 'Zone',
            ),

            _textField(
              controller: _assetAgeController,
              label: 'Asset Age (Years)',
              keyboardType: TextInputType.number,
            ),

            _textField(
              controller: _authorityController,
              label: 'Responsible Authority',
            ),

            const Divider(height: 32),

            // ======================================
            // HAZARD DETAILS
            // ======================================

            _sectionTitle(
              'Hazard Identification',
              Icons.warning_amber_rounded,
            ),

            _dropdown(
              label: 'Hazard Category',
              value: _hazardCategory,
              items: const [
                'Structural Damage',
                'Fire Hazard',
                'Flood Risk',
                'Electrical Hazard',
                'Water Leakage',
                'Road Damage',
                'Environmental Pollution',
                'Public Safety Risk',
                'Equipment Failure',
                'Other',
              ],
              onChanged: (value) {
                setState(() {
                  _hazardCategory = value!;
                });
              },
            ),

            _textField(
              controller: _hazardDescriptionController,
              label: 'Hazard Description',
              maxLines: 4,
            ),

            _textField(
              controller: _rootCauseController,
              label: 'Possible Root Cause',
              maxLines: 3,
            ),

            _textField(
              controller: _affectedAreaController,
              label: 'Affected Area',
            ),

            _switchTile(
              title: 'Visible Damage',
              subtitle:
                  'Is physical or visible damage present?',
              value: _visibleDamage,
              onChanged: (value) {
                setState(() {
                  _visibleDamage = value;
                });
              },
            ),

            if (_visibleDamage)
              _textField(
                controller: _damageDescriptionController,
                label: 'Damage Description',
                maxLines: 3,
              ),

            _switchTile(
              title: 'Previous Incidents',
              subtitle:
                  'Has this asset experienced incidents before?',
              value: _previousIncidents,
              onChanged: (value) {
                setState(() {
                  _previousIncidents = value;
                });
              },
            ),

            if (_previousIncidents)
              _textField(
                controller:
                    _previousIncidentCountController,
                label: 'Number of Previous Incidents',
                keyboardType: TextInputType.number,
              ),

            _switchTile(
              title: 'Repeated Reports',
              subtitle:
                  'Has the same issue been reported multiple times?',
              value: _repeatedReports,
              onChanged: (value) {
                setState(() {
                  _repeatedReports = value;
                });
              },
            ),

            const Divider(height: 32),

            // ======================================
            // CORE RISK ANALYSIS
            // ======================================

            _sectionTitle(
              'Core Risk Engine Analysis',
              Icons.analytics,
            ),

            _scoreSlider(
              label: 'Likelihood',
              description:
                  'Probability that the hazard will occur.',
              value: _likelihoodScore,
              onChanged: (value) {
                setState(() {
                  _likelihoodScore = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Impact',
              description:
                  'Potential severity if the incident occurs.',
              value: _impactScore,
              onChanged: (value) {
                setState(() {
                  _impactScore = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Exposure',
              description:
                  'How frequently people or assets are exposed.',
              value: _exposureScore,
              onChanged: (value) {
                setState(() {
                  _exposureScore = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Vulnerability',
              description:
                  'How susceptible the asset is to damage.',
              value: _vulnerabilityScore,
              onChanged: (value) {
                setState(() {
                  _vulnerabilityScore = value;
                });
              },
            ),

            const Divider(height: 32),

            // ======================================
            // ADDITIONAL RISK FACTORS
            // ======================================

            _sectionTitle(
              'Additional Risk Factors',
              Icons.tune,
            ),

            _scoreSlider(
              label: 'Urgency',
              description:
                  'How quickly the issue requires attention.',
              value: _urgencyScore,
              onChanged: (value) {
                setState(() {
                  _urgencyScore = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Detectability',
              description:
                  'How difficult the hazard is to detect before failure.',
              value: _detectabilityScore,
              onChanged: (value) {
                setState(() {
                  _detectabilityScore = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Control Effectiveness',
              description:
                  'How effective existing safety controls are.',
              value: _controlEffectivenessScore,
              onChanged: (value) {
                setState(() {
                  _controlEffectivenessScore = value;
                });
              },
            ),

            const Divider(height: 32),

            // ======================================
            // IMPACT ANALYSIS
            // ======================================

            _sectionTitle(
              'Impact Analysis',
              Icons.groups,
            ),

            _scoreSlider(
              label: 'Human Safety Impact',
              description:
                  'Potential impact on human life and safety.',
              value: _humanSafetyImpact,
              onChanged: (value) {
                setState(() {
                  _humanSafetyImpact = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Property / Asset Impact',
              description:
                  'Potential damage to property and infrastructure.',
              value: _propertyImpact,
              onChanged: (value) {
                setState(() {
                  _propertyImpact = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Environmental Impact',
              description:
                  'Potential environmental consequences.',
              value: _environmentalImpact,
              onChanged: (value) {
                setState(() {
                  _environmentalImpact = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Financial Impact',
              description:
                  'Estimated financial consequences.',
              value: _financialImpact,
              onChanged: (value) {
                setState(() {
                  _financialImpact = value;
                });
              },
            ),

            _scoreSlider(
              label: 'Service Disruption Impact',
              description:
                  'Potential interruption of public services.',
              value: _serviceDisruptionImpact,
              onChanged: (value) {
                setState(() {
                  _serviceDisruptionImpact = value;
                });
              },
            ),

            const Divider(height: 32),

            // ======================================
            // LIVE RISK RESULT
            // ======================================

            _sectionTitle(
              'Live Risk Assessment',
              Icons.speed,
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Calculated Risk Score',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _riskScore.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _riskLevel,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Risk Score = Likelihood × Impact × Exposure × Vulnerability',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 32),

            // ======================================
            // EVIDENCE
            // ======================================

            _sectionTitle(
              'Evidence & Documentation',
              Icons.camera_alt,
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: const Text(
                  'Camera Evidence',
                ),
                subtitle: const Text(
                  'Photo capture will be added in the next step.',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Camera integration is the next step.',
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            _textField(
              controller: _evidenceNotesController,
              label: 'Evidence Notes',
              maxLines: 3,
              required: false,
            ),

            const Divider(height: 32),

            // ======================================
            // ACTION PLAN
            // ======================================

            _sectionTitle(
              'Risk Mitigation & Action Plan',
              Icons.assignment_turned_in,
            ),

            _switchTile(
              title: 'Immediate Action Required',
              subtitle:
                  'Does this risk require immediate intervention?',
              value: _immediateActionRequired,
              onChanged: (value) {
                setState(() {
                  _immediateActionRequired = value;
                });
              },
            ),

            if (_immediateActionRequired)
              _textField(
                controller: _immediateActionController,
                label: 'Immediate Action Required',
                maxLines: 3,
              ),

            _textField(
              controller: _recommendedActionController,
              label: 'Recommended Corrective Action',
              maxLines: 4,
            ),

            _textField(
              controller:
                  _responsibleDepartmentController,
              label: 'Responsible Department',
            ),

            _dropdown(
              label: 'Action Priority',
              value: _priority,
              items: const [
                'Low',
                'Medium',
                'High',
                'Critical',
              ],
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
            ),

            _textField(
              controller: _inspectorNotesController,
              label: 'Inspector Notes',
              maxLines: 4,
              required: false,
            ),

            const SizedBox(height: 24),

            // ======================================
            // SAVE BUTTON
            // ======================================

            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _saveReport,
                icon: const Icon(Icons.save),
                label: const Text(
                  'CREATE RISK INSPECTION REPORT',
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}