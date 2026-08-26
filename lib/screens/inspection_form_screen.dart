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

  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedSeverity = 'Low';

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitInspection() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final report = InspectionReport(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      location: _locationController.text.trim(),
      description: _descriptionController.text.trim(),
      severity: _selectedSeverity,
      status: 'Open',
      repeatedReports: false,
      createdAt: DateTime.now(),
    );

    InspectionService.addReport(report);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inspection report created successfully.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Inspection'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Create Inspection Report',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter inspection location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Issue Description',
                  hintText: 'Describe the issue found during inspection',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedSeverity,
                decoration: const InputDecoration(
                  labelText: 'Severity',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.warning_amber),
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
                  if (value != null) {
                    setState(() {
                      _selectedSeverity = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 32),

              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submitInspection,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Submit Inspection',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}