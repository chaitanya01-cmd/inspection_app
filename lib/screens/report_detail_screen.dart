import 'package:flutter/material.dart';

import '../models/inspection_report.dart';

class ReportDetailScreen extends StatelessWidget {
  final InspectionReport report;

  const ReportDetailScreen({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Inspection Report',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  _DetailRow(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: report.location,
                  ),

                  const Divider(),

                  _DetailRow(
                    icon: Icons.description,
                    label: 'Description',
                    value: report.description,
                  ),

                  const Divider(),

                  _DetailRow(
                    icon: Icons.warning_amber,
                    label: 'Severity',
                    value: report.severity,
                  ),

                  const Divider(),

                  _DetailRow(
                    icon: Icons.pending_actions,
                    label: 'Status',
                    value: report.status,
                  ),

                  const Divider(),

                  _DetailRow(
                    icon: Icons.repeat,
                    label: 'Repeated Issue',
                    value: report.repeatedReports ? 'Yes' : 'No',
                  ),

                  const Divider(),

                  _DetailRow(
                    icon: Icons.calendar_today,
                    label: 'Created',
                    value: report.createdAt.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}