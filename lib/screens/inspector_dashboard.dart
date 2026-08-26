import 'package:flutter/material.dart';

import '../models/inspection_report.dart';
import '../services/auth_service.dart';
import '../services/inspection_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/report_card.dart';
import 'inspection_form_screen.dart';
import 'report_detail_screen.dart';

class InspectorDashboard extends StatefulWidget {
  final AuthService authService;

  const InspectorDashboard({
    super.key,
    required this.authService,
  });

  @override
  State<InspectorDashboard> createState() => _InspectorDashboardState();
}

class _InspectorDashboardState extends State<InspectorDashboard> {
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
    return reports.where((report) => report.status != 'Resolved').length;
  }

  int get criticalReports {
    return reports.where((report) => report.riskLevel == 'Critical').length;
  }

  int get repeatedReports {
    return reports.where((report) => report.repeatedReports).length;
  }

  Future<void> openNewInspection() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InspectionFormScreen(),
      ),
    );

    if (!mounted) return;

    setState(() {
      loadReports();
    });
  }

  Future<void> logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text(
          'Are you sure you want to logout?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout != true || !mounted) return;

    widget.authService.logout();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/role-selection',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspector Dashboard'),

        // LOGOUT BUTTON
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: openNewInspection,
        icon: const Icon(Icons.add),
        label: const Text('New Inspection'),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            loadReports();
          });
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
              childAspectRatio: 1.5,
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
                  child: Text('No inspection reports yet.'),
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

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}