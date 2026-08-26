import 'package:flutter/material.dart';

import '../models/inspection_report.dart';

class ReportCard extends StatelessWidget {
  final InspectionReport report;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.report,
    required this.onTap,
  });

  Color _severityColor() {
    switch (report.severity) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber.shade800;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _severityIcon() {
    switch (report.severity) {
      case 'Critical':
        return Icons.dangerous;
      case 'High':
        return Icons.warning;
      case 'Medium':
        return Icons.info_outline;
      case 'Low':
        return Icons.check_circle_outline;
      default:
        return Icons.assignment;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = _severityColor();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: severityColor.withValues(alpha: 0.15),
                child: Icon(
                  _severityIcon(),
                  color: severityColor,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.location,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      report.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _StatusChip(
                          label: report.severity,
                          color: severityColor,
                        ),
                        _StatusChip(
                          label: report.status,
                          color: Colors.blue,
                        ),
                        if (report.repeatedReports)
                          const _StatusChip(
                            label: 'Repeated',
                            color: Colors.purple,
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}