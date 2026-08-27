import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  bool _allRead = false;

  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'CRITICAL',
      'title': 'Major Road Damage Detected',
      'description':
          'A critical infrastructure report has been received from MG Road.',
      'location': 'MG Road',
      'time': '2 min ago',
      'icon': Icons.warning_amber_rounded,
      'color': Color(0xFFDC2626),
    },
    {
      'type': 'HIGH PRIORITY',
      'title': 'Streetlight Failure Reported',
      'description':
          'A high-priority streetlight failure requires officer attention.',
      'location': 'Station Road',
      'time': '18 min ago',
      'icon': Icons.lightbulb_outline,
      'color': Color(0xFFEA580C),
    },
    {
      'type': 'AI ANOMALY',
      'title': 'Infrastructure Cluster Detected',
      'description':
          'AI detected 5 similar road damage reports within 500 meters.',
      'location': 'FC Road',
      'time': '1 hr ago',
      'icon': Icons.auto_awesome,
      'color': Color(0xFF7C3AED),
    },
    {
      'type': 'REPORT',
      'title': 'New Water Leakage Report',
      'description':
          'A new infrastructure complaint has been submitted.',
      'location': 'Shivaji Nagar',
      'time': '2 hrs ago',
      'icon': Icons.water_drop_outlined,
      'color': Color(0xFF0891B2),
    },
    {
      'type': 'RESOLVED',
      'title': 'Report Marked Resolved',
      'description':
          'The damaged footpath report has been successfully resolved.',
      'location': 'Kothrud',
      'time': '4 hrs ago',
      'icon': Icons.check_circle_outline,
      'color': Color(0xFF16A34A),
    },
  ];

  void _markAllAsRead() {
    setState(() {
      _allRead = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _allRead ? 0 : 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF163A5F),
        foregroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Notification summary
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDC2626)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$unreadCount New Alerts',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Requires your attention',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                20,
              ),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notification = _notifications[index];

                final bool isUnread =
                    !_allRead && index < 3;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isUnread
                        ? Colors.white
                        : const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isUnread
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFFEEEEEE),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: notification['color']
                              .withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Icon(
                          notification['icon'],
                          color: notification['color'],
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: notification['color']
                                        .withValues(alpha: 0.1),
                                    borderRadius:
                                        BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    notification['type'],
                                    style: TextStyle(
                                      color:
                                          notification['color'],
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (isUnread)
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration:
                                        const BoxDecoration(
                                      color:
                                          Color(0xFF2563EB),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              notification['title'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              notification['description'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 9),

                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  notification['location'],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.access_time,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  notification['time'],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}