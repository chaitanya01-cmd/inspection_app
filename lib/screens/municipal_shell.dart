import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'all_reports_screen.dart';
import 'issue_map_screen.dart';
import 'ai_insights_screen.dart';
import 'analytics_screen.dart';
import 'officer_profile_screen.dart';
import '../services/inspection_service.dart';

class MunicipalShell extends StatefulWidget {
  const MunicipalShell({super.key});

  @override
  State<MunicipalShell> createState() => _MunicipalShellState();
}

class _MunicipalShellState extends State<MunicipalShell> {
  int _selectedIndex = 0;

  // ==========================================
  // BUILD SELECTED SCREEN
  // ==========================================

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        // Key forces the dashboard to rebuild when
        // returning to the dashboard after a new report.
        return DashboardScreen(
          key: ValueKey(
            'dashboard-${InspectionService.getReports().length}',
          ),
        );

      case 1:
        return AllReportsScreen(
          key: ValueKey(
            'reports-${InspectionService.getReports().length}',
          ),
        );

      case 2:
        return const IssueMapScreen();

      case 3:
        return const AIInsightsScreen();

      case 4:
        return const AnalyticsScreen();

      default:
        return const DashboardScreen();
    }
  }

  // ==========================================
  // NAVIGATION
  // ==========================================

  void _selectScreen(int index) {
    if (!mounted) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  // ==========================================
  // PROFILE
  // ==========================================

  Future<void> _openProfile() async {
    if (!mounted) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OfficerProfileScreen(),
      ),
    );

    // Rebuild after returning from profile.
    if (mounted) {
      setState(() {});
    }
  }

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ==========================================
          // MUNICIPAL NAVIGATION RAIL
          // ==========================================

          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _selectScreen,

            backgroundColor: const Color(0xFF163A5F),

            minWidth: 76,

            groupAlignment: -0.85,

            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 24,
            ),

            unselectedIconTheme: const IconThemeData(
              color: Colors.white70,
              size: 22,
            ),

            selectedLabelTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),

            unselectedLabelTextStyle: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),

            labelType: NavigationRailLabelType.all,

            leading: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ==========================================
                  // MUNICIPAL LOGO
                  // ==========================================

                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      color: Color(0xFF163A5F),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'MUNICIPAL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),

            destinations: const [
              NavigationRailDestination(
                icon: Icon(
                  Icons.dashboard_outlined,
                ),
                selectedIcon: Icon(
                  Icons.dashboard,
                ),
                label: Text('Dashboard'),
              ),

              NavigationRailDestination(
                icon: Icon(
                  Icons.assignment_outlined,
                ),
                selectedIcon: Icon(
                  Icons.assignment,
                ),
                label: Text('Reports'),
              ),

              NavigationRailDestination(
                icon: Icon(
                  Icons.map_outlined,
                ),
                selectedIcon: Icon(
                  Icons.map,
                ),
                label: Text('Map'),
              ),

              NavigationRailDestination(
                icon: Icon(
                  Icons.auto_awesome_outlined,
                ),
                selectedIcon: Icon(
                  Icons.auto_awesome,
                ),
                label: Text('AI Insights'),
              ),

              NavigationRailDestination(
                icon: Icon(
                  Icons.analytics_outlined,
                ),
                selectedIcon: Icon(
                  Icons.analytics,
                ),
                label: Text('Analytics'),
              ),
            ],
          ),

          // ==========================================
          // SELECTED SCREEN
          // ==========================================

          Expanded(
            child: Column(
              children: [
                // ==========================================
                // TOP BAR
                // ==========================================

                Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF163A5F),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Municipal Corporation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Infrastructure Monitoring',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ==========================================
                      // NOTIFICATIONS
                      // ==========================================

                      IconButton(
                        tooltip: 'Notifications',
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No new notifications',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                        ),
                      ),

                      // ==========================================
                      // PROFILE
                      // ==========================================

                      IconButton(
                        tooltip: 'Officer Profile',
                        onPressed: _openProfile,
                        icon: const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // ==========================================
                // SCREEN CONTENT
                // ==========================================

                Expanded(
                  child: _buildSelectedScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}