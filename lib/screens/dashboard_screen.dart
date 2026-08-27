import 'dart:io';

import 'package:flutter/material.dart';

import '../models/inspection_report.dart';
import '../models/user_role.dart';
import '../services/auth_service.dart';
import '../services/inspection_service.dart';

import 'all_reports_screen.dart';
import 'login_screen.dart';
import 'report_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ==========================================================
  // REPORT DATA
  // ==========================================================

  List<InspectionReport> get _reports {
    return InspectionService.getReports();
  }

  List<InspectionReport> get _criticalReports {
    return _reports.where((report) {
      return report.riskLevel.toLowerCase() == 'critical' ||
          report.severity.toLowerCase() == 'critical';
    }).toList();
  }

  int get _totalReports {
    return _reports.length;
  }

  int get _criticalCount {
    return _reports.where((report) {
      return report.riskLevel.toLowerCase() == 'critical' ||
          report.severity.toLowerCase() == 'critical';
    }).length;
  }

  int get _highPriorityCount {
    return _reports.where((report) {
      final priority = report.priority.toLowerCase();
      final risk = report.riskLevel.toLowerCase();

      return priority == 'high' ||
          priority == 'critical' ||
          risk == 'high' ||
          risk == 'critical';
    }).length;
  }

  int get _resolvedCount {
    return _reports.where((report) {
      return report.status.toLowerCase() == 'resolved';
    }).length;
  }

  // ==========================================================
  // REFRESH DASHBOARD
  // ==========================================================

  void _refreshDashboard() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  // ==========================================================
  // OPEN REPORT
  // ==========================================================

  Future<void> _openReport(
    BuildContext context,
    InspectionReport report,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportDetailsScreen(
          title: report.assetName.isEmpty
              ? 'Inspection Report'
              : report.assetName,
          location: report.address.isEmpty
              ? 'Location unavailable'
              : report.address,
          risk: report.riskScore.toStringAsFixed(0),
          status: report.riskLevel.toUpperCase(),
        ),
      ),
    );

    _refreshDashboard();
  }

  // ==========================================================
  // OPEN ALL REPORTS
  // ==========================================================

  Future<void> _openAllReports(
    BuildContext context,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AllReportsScreen(),
      ),
    );

    _refreshDashboard();
  }

  // ==========================================================
  // PROFILE
  // ==========================================================

  void _openProfile() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ==================================================
                // DRAG HANDLE
                // ==================================================

                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 22),

                // ==================================================
                // PROFILE HEADER
                // ==================================================

                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF163A5F),
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Municipal Officer',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Municipal Corporation',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ==================================================
                // PROFILE INFORMATION
                // ==================================================

                _profileRow(
                  icon: Icons.badge_outlined,
                  label: 'Officer ID',
                  value: 'MUN-001',
                ),

                _profileRow(
                  icon:
                      Icons.admin_panel_settings_outlined,
                  label: 'Role',
                  value: 'Municipal Officer',
                ),

                _profileRow(
                  icon:
                      Icons.account_balance_outlined,
                  label: 'Department',
                  value:
                      'Municipal Inspection Department',
                ),

                _profileRow(
                  icon:
                      Icons.location_city_outlined,
                  label: 'Organization',
                  value: 'Municipal Corporation',
                ),

                const SizedBox(height: 8),

                const Divider(),

                const SizedBox(height: 12),

                // ==================================================
                // LOGOUT BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFDC2626),
                      foregroundColor:
                          Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _logout();
                    },
                    icon: const Icon(
                      Icons.logout,
                    ),
                    label: const Text(
                      'LOG OUT',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Inspection Management System',
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // PROFILE INFORMATION ROW
  // ==========================================================

  Widget _profileRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  const Color(0xFF163A5F)
                      .withValues(alpha: 0.08),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color:
                  const Color(0xFF163A5F),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  void _logout() {
    final authService = AuthService();

    authService.logout();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          authService: authService,
          role: UserRole.municipal,
        ),
      ),
      (route) => false,
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FA),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF163A5F),
        foregroundColor: Colors.white,
        elevation: 0,

        titleSpacing: 16,

        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Municipal Corporation',
              style: TextStyle(
                fontSize: 17,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              'Infrastructure Monitoring',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),

        actions: [
          // ======================================================
          // NOTIFICATION BUTTON
          // ======================================================

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
              Icons.notifications_none,
            ),
          ),

          // ======================================================
          // PROFILE BUTTON
          // ======================================================

          Padding(
            padding:
                const EdgeInsets.only(
              right: 8,
            ),
            child: IconButton(
              tooltip: 'Profile',
              onPressed: _openProfile,
              icon: Container(
                width: 36,
                height: 36,
                decoration:
                    const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color:
                      Color(0xFF163A5F),
                  size: 23,
                ),
              ),
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _refreshDashboard();

            await Future<void>.delayed(
              const Duration(
                milliseconds: 250,
              ),
            );
          },

          child:
              SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(),

            padding:
                const EdgeInsets.fromLTRB(
              16,
              18,
              16,
              30,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // ==================================================
                // HEADER
                // ==================================================

                const Text(
                  'Good Morning, Officer',
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Monitor and prioritize infrastructure issues',
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // STATISTICS
                // ==================================================

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.18,

                  children: [
                    _StatCard(
                      title: 'Total Reports',
                      value:
                          _totalReports
                              .toString(),
                      icon:
                          Icons.assignment_outlined,
                      color:
                          const Color(
                        0xFF2563EB,
                      ),
                    ),

                    _StatCard(
                      title: 'Critical',
                      value:
                          _criticalCount
                              .toString(),
                      icon:
                          Icons.warning_amber_rounded,
                      color:
                          const Color(
                        0xFFDC2626,
                      ),
                    ),

                    _StatCard(
                      title: 'High Priority',
                      value:
                          _highPriorityCount
                              .toString(),
                      icon:
                          Icons.priority_high_rounded,
                      color:
                          const Color(
                        0xFFEA580C,
                      ),
                    ),

                    _StatCard(
                      title: 'Resolved',
                      value:
                          _resolvedCount
                              .toString(),
                      icon:
                          Icons.check_circle_outline,
                      color:
                          const Color(
                        0xFF16A34A,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 26),

                // ==================================================
                // CRITICAL ISSUES
                // ==================================================

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Critical Issues',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF1E293B),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        _openAllReports(
                          context,
                        );
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Color(0xFF163A5F),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if (_criticalReports.isEmpty)
                  _emptyCriticalState()
                else
                  ..._criticalReports
                      .take(5)
                      .map(
                        (report) =>
                            Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                            bottom: 10,
                          ),
                          child:
                              _criticalReportCard(
                            context,
                            report,
                          ),
                        ),
                      ),

                const SizedBox(height: 24),

                // ==================================================
                // RECENT REPORTS
                // ==================================================

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Recent Inspection Reports',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF1E293B),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        _openAllReports(
                          context,
                        );
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Color(0xFF163A5F),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if (_reports.isEmpty)
                  _emptyReportsState()
                else
                  ..._reports
                      .take(5)
                      .map(
                        (report) =>
                            Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                            bottom: 10,
                          ),
                          child:
                              _recentReportCard(
                            context,
                            report,
                          ),
                        ),
                      ),

                const SizedBox(height: 12),

                // ==================================================
                // VIEW ALL REPORTS
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child:
                      ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF163A5F,
                      ),
                      foregroundColor:
                          Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          11,
                        ),
                      ),
                    ),

                    onPressed: () {
                      _openAllReports(
                        context,
                      );
                    },

                    icon: const Icon(
                      Icons.assignment_outlined,
                      size: 20,
                    ),

                    label: const Text(
                      'VIEW ALL INSPECTION REPORTS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ==================================================
                // SYSTEM INFORMATION
                // ==================================================

                _systemInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // CRITICAL REPORT CARD
  // ==========================================================

  Widget _criticalReportCard(
    BuildContext context,
    InspectionReport report,
  ) {
    final riskLevel =
        report.riskLevel.toUpperCase();

    final Color riskColor =
        _riskColor(riskLevel);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(13),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(13),

        onTap: () {
          _openReport(
            context,
            report,
          );
        },

        child: Padding(
          padding:
              const EdgeInsets.all(12),

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ==================================================
              // EVIDENCE PHOTO
              // ==================================================

              _evidenceThumbnail(
                report,
                64,
                64,
              ),

              const SizedBox(width: 10),

              // ==================================================
              // REPORT INFORMATION
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.assetName.isEmpty
                          ? 'Unnamed Asset'
                          : report.assetName,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xFF1E293B),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      report.address.isEmpty
                          ? 'Location unavailable'
                          : report.address,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          'Risk: ${report.riskScore.toStringAsFixed(0)}',
                          style:
                              const TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 7),

                        _badge(
                          riskLevel,
                          riskColor,
                        ),
                      ],
                    ),

                    if (report.imagePaths.isNotEmpty)
                      const Padding(
                        padding:
                            EdgeInsets.only(
                          top: 5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons
                                  .photo_camera_outlined,
                              size: 13,
                              color:
                                  Color(0xFF2563EB),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Evidence attached',
                              style:
                                  TextStyle(
                                fontSize: 10,
                                color:
                                    Color(0xFF2563EB),
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // RECENT REPORT CARD
  // ==========================================================

  Widget _recentReportCard(
    BuildContext context,
    InspectionReport report,
  ) {
    final riskLevel =
        report.riskLevel.toUpperCase();

    final Color riskColor =
        _riskColor(riskLevel);

    final Color priorityColor =
        _priorityColor(
      report.priority,
    );

    final bool hasCoordinates =
        report.latitude != null &&
        report.longitude != null;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(13),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(13),

        onTap: () {
          _openReport(
            context,
            report,
          );
        },

        child: Padding(
          padding:
              const EdgeInsets.all(13),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ==================================================
              // PHOTO + TITLE
              // ==================================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  _evidenceThumbnail(
                    report,
                    74,
                    74,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Expanded(
                              child: Text(
                                report.assetName
                                        .isEmpty
                                    ? 'Unnamed Asset'
                                    : report.assetName,
                                maxLines: 2,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color:
                                      Color(
                                    0xFF1E293B,
                                  ),
                                ),
                              ),
                            ),

                            const Icon(
                              Icons.chevron_right,
                              color:
                                  Colors.grey,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          report.assetType,
                          maxLines: 1,
                          overflow:
                              TextOverflow
                                  .ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color:
                                Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(
                          height: 7,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons
                                  .photo_camera_outlined,
                              size: 14,
                              color: report
                                      .imagePaths
                                      .isNotEmpty
                                  ? const Color(
                                      0xFF2563EB,
                                    )
                                  : Colors
                                      .grey
                                      .shade500,
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            Text(
                              report.imagePaths
                                      .isNotEmpty
                                  ? '${report.imagePaths.length} evidence photo${report.imagePaths.length == 1 ? '' : 's'}'
                                  : 'No evidence photo',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: report
                                        .imagePaths
                                        .isNotEmpty
                                    ? FontWeight
                                        .w600
                                    : FontWeight
                                        .normal,
                                color: report
                                        .imagePaths
                                        .isNotEmpty
                                    ? const Color(
                                        0xFF2563EB,
                                      )
                                    : Colors
                                        .grey
                                        .shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ==================================================
              // ADDRESS
              // ==================================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 17,
                    color:
                        Colors.grey.shade600,
                  ),

                  const SizedBox(width: 7),

                  Expanded(
                    child: Text(
                      report.address.isEmpty
                          ? 'Location unavailable'
                          : report.address,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),

              // ==================================================
              // COORDINATES
              // ==================================================

              if (hasCoordinates) ...[
                const SizedBox(height: 7),

                Row(
                  children: [
                    const Icon(
                      Icons.my_location,
                      size: 16,
                      color:
                          Color(0xFF2563EB),
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        '${report.latitude!.toStringAsFixed(6)}, '
                        '${report.longitude!.toStringAsFixed(6)}',
                        style:
                            const TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 9),

              // ==================================================
              // STATUS BADGES
              // ==================================================

              Wrap(
                spacing: 6,
                runSpacing: 5,
                children: [
                  _badge(
                    'Risk ${report.riskScore.toStringAsFixed(0)}',
                    riskColor,
                  ),

                  _badge(
                    riskLevel,
                    riskColor,
                  ),

                  _badge(
                    report.priority,
                    priorityColor,
                  ),

                  _badge(
                    report.status,
                    _statusColor(
                      report.status,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EVIDENCE THUMBNAIL
  // ==========================================================

  Widget _evidenceThumbnail(
    InspectionReport report,
    double width,
    double height,
  ) {
    // ========================================================
    // NO PHOTO
    // ========================================================

    if (report.imagePaths.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:
              const Color(0xFFF1F5F9),
          borderRadius:
              BorderRadius.circular(11),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .image_not_supported_outlined,
              size: 25,
              color:
                  Colors.grey.shade500,
            ),
            const SizedBox(height: 3),
            Text(
              'No Photo',
              style: TextStyle(
                fontSize: 8,
                color:
                    Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    // ========================================================
    // FIRST PHOTO
    // ========================================================

    final String path =
        report.imagePaths.first;

    final File file = File(path);

    // ========================================================
    // PHOTO EXISTS
    // ========================================================

    if (file.existsSync()) {
      return ClipRRect(
        borderRadius:
            BorderRadius.circular(11),
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Image.file(
                file,
                fit: BoxFit.cover,
                cacheWidth:
                    (width * 3).round(),
                cacheHeight:
                    (height * 3).round(),
                errorBuilder:
                    (
                  context,
                  error,
                  stackTrace,
                ) {
                  return _imageUnavailable(
                    width,
                    height,
                  );
                },
              ),
            ),

            // ==================================================
            // PHOTO COUNT
            // ==================================================

            if (report.imagePaths.length >
                1)
              Positioned(
                right: 5,
                bottom: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.black
                        .withValues(
                      alpha: 0.75,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      6,
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.photo_library,
                        color:
                            Colors.white,
                        size: 11,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${report.imagePaths.length}',
                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    }

    // ========================================================
    // PHOTO FILE UNAVAILABLE
    // ========================================================

    return _imageUnavailable(
      width,
      height,
    );
  }

  // ==========================================================
  // IMAGE UNAVAILABLE
  // ==========================================================

  Widget _imageUnavailable(
    double width,
    double height,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            const Color(0xFFF1F5F9),
        borderRadius:
            BorderRadius.circular(11),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 24,
            color:
                Colors.grey.shade500,
          ),
          const SizedBox(height: 3),
          Text(
            'Photo unavailable',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              color:
                  Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BADGE
  // ==========================================================

  Widget _badge(
    String text,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color:
            color.withValues(
          alpha: 0.10,
        ),
        borderRadius:
            BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight:
              FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // ==========================================================
  // RISK COLOR
  // ==========================================================

  Color _riskColor(
    String risk,
  ) {
    switch (risk.toLowerCase()) {
      case 'critical':
        return const Color(0xFFDC2626);

      case 'high':
        return const Color(0xFFEA580C);

      case 'medium':
        return const Color(0xFFD97706);

      case 'low':
        return const Color(0xFF16A34A);

      default:
        return const Color(0xFF64748B);
    }
  }

  // ==========================================================
  // PRIORITY COLOR
  // ==========================================================

  Color _priorityColor(
    String priority,
  ) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return const Color(0xFFDC2626);

      case 'high':
        return const Color(0xFFEA580C);

      case 'medium':
        return const Color(0xFFD97706);

      case 'low':
        return const Color(0xFF16A34A);

      default:
        return const Color(0xFF64748B);
    }
  }

  // ==========================================================
  // STATUS COLOR
  // ==========================================================

  Color _statusColor(
    String status,
  ) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return const Color(0xFF16A34A);

      case 'open':
        return const Color(0xFF2563EB);

      case 'in progress':
        return const Color(0xFFD97706);

      default:
        return const Color(0xFF64748B);
    }
  }

  // ==========================================================
  // EMPTY CRITICAL STATE
  // ==========================================================

  Widget _emptyCriticalState() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(13),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 22,
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 46,
                color:
                    Colors.green.shade600,
              ),

              const SizedBox(height: 9),

              const Text(
                'No Critical Issues',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                _totalReports == 0
                    ? 'No inspection reports have been created yet.'
                    : 'There are currently no critical inspection reports.',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY REPORTS
  // ==========================================================

  Widget _emptyReportsState() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 42,
                color:
                    Colors.grey.shade500,
              ),

              const SizedBox(height: 10),

              Text(
                'No Inspection Reports',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SYSTEM INFORMATION
  // ==========================================================

  Widget _systemInfoCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(13),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(13),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFF163A5F,
                ).withValues(
                  alpha: 0.08,
                ),
                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),
              child: const Icon(
                Icons.sync,
                size: 21,
                color:
                    Color(0xFF163A5F),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Inspection Data',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    'Dashboard is connected to the inspection report service.',
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STAT CARD
// ============================================================

class _StatCard
    extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(13),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration:
                  BoxDecoration(
                color:
                    color.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),

            const Spacer(),

            Text(
              value,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style:
                  const TextStyle(
                fontSize: 25,
                fontWeight:
                    FontWeight.bold,
                color:
                    Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              title,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color:
                    Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}