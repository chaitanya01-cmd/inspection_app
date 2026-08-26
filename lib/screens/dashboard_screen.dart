import 'package:flutter/material.dart';

import '../models/inspection_report.dart';
import '../services/inspection_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/report_card.dart';
import 'inspection_form_screen.dart';
import 'report_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<InspectionReport> reports = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() {
    reports = InspectionService.getReports();
  }

  int get openReports {
    return reports.where((r) => r.status != 'Resolved').length;
  }

  int get criticalReports {
    return reports.where((r) => r.severity == 'Critical').length;
  }

  int get repeatedReports {
    return reports.where((r) => r.repeatedReports).length;
  }

  Future<void> openNewInspection() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InspectionFormScreen(),
      ),
    );

    if (!mounted) return;

    setState(loadReports);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspector Dashboard'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: openNewInspection,
        icon: const Icon(Icons.add),
        label: const Text('New Inspection'),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(loadReports);
        },

        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Welcome, Inspector 👷',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              // Increased height to prevent card overflow.
              childAspectRatio: 1.2,

              children: [
                DashboardCard(
                  title: 'Total Reports',
                  value: '${reports.length}',
                  icon: Icons.assignment,
                ),
                DashboardCard(
                  title: 'Open Reports',
                  value: '$openReports',
                  icon: Icons.pending_actions,
                ),
                DashboardCard(
                  title: 'Critical Reports',
                  value: '$criticalReports',
                  icon: Icons.warning,
                ),
                DashboardCard(
                  title: 'Repeated Reports',
                  value: '$repeatedReports',
                  icon: Icons.repeat,
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'My Reports',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (reports.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'No inspection reports yet.',
                  ),
                ),
              ),

            ...reports.map(
              (report) => ReportCard(
                report: report,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportDetailScreen(
                        report: report,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}