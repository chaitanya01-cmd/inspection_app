import 'package:flutter/material.dart';
import 'report_details_screen.dart';

class AIInsightsScreen extends StatelessWidget {
  const AIInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF163A5F),
        foregroundColor: Colors.white,
        title: const Text(
          'AI Insights',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Infrastructure Intelligence',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'AI-powered analysis of municipal infrastructure reports',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // AI system status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFC7D2FE),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.smart_toy_outlined,
                    color: Color(0xFF4F46E5),
                    size: 32,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Analysis Engine',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Monitoring infrastructure reports in real time',
                          style: TextStyle(
                            color: Color(0xFF6366F1),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: Color(0xFF16A34A),
                    size: 12,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Risk Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _RiskCard(
                    label: 'Critical',
                    value: '12',
                    color: const Color(0xFFDC2626),
                    icon: Icons.warning_amber_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _RiskCard(
                    label: 'High',
                    value: '25',
                    color: const Color(0xFFEA580C),
                    icon: Icons.priority_high_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _RiskCard(
                    label: 'Medium',
                    value: '47',
                    color: const Color(0xFFD97706),
                    icon: Icons.info_outline,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _RiskCard(
                    label: 'Low',
                    value: '36',
                    color: const Color(0xFF16A34A),
                    icon: Icons.check_circle_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'Detected Anomalies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 12),

            _AnomalyCard(
              icon: Icons.alt_route,
              title: 'Road Damage Cluster',
              description:
                  '5 similar road damage reports detected within 500 meters.',
              severity: 'HIGH',
              color: const Color(0xFFDC2626),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportDetailsScreen(
                      title: 'Major Road Damage',
                      location: 'MG Road, Pune',
                      risk: '92',
                      status: 'CRITICAL',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _AnomalyCard(
              icon: Icons.water_drop_outlined,
              title: 'Water Leakage Pattern',
              description:
                  '3 leakage reports detected in the same locality.',
              severity: 'MEDIUM',
              color: const Color(0xFFD97706),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportDetailsScreen(
                      title: 'Water Leakage',
                      location: 'FC Road, Pune',
                      risk: '58',
                      status: 'MEDIUM',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _AnomalyCard(
              icon: Icons.lightbulb_outline,
              title: 'Streetlight Failure Pattern',
              description:
                  'Multiple streetlight failures detected along Station Road.',
              severity: 'HIGH',
              color: const Color(0xFFEA580C),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportDetailsScreen(
                      title: 'Streetlight Failure',
                      location: 'Station Road, Pune',
                      risk: '76',
                      status: 'HIGH',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'AI Recommendations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 12),

            _RecommendationCard(
              priority: '1',
              title: 'Prioritize MG Road',
              description:
                  'High-risk road damage combined with multiple nearby reports suggests immediate inspection.',
              color: const Color(0xFFDC2626),
            ),

            const SizedBox(height: 10),

            _RecommendationCard(
              priority: '2',
              title: 'Inspect Station Road',
              description:
                  'Repeated streetlight failures indicate a possible systemic electrical issue.',
              color: const Color(0xFFEA580C),
            ),

            const SizedBox(height: 10),

            _RecommendationCard(
              priority: '3',
              title: 'Investigate FC Road',
              description:
                  'Multiple water leakage complaints may indicate an underground pipeline problem.',
              color: const Color(0xFFD97706),
            ),

            const SizedBox(height: 28),

            // AI summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF163A5F),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'AI Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    '12 critical infrastructure issues require immediate attention. '
                    'The system has identified 8 potential issue clusters that '
                    'may represent larger infrastructure problems.',
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _RiskCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _RiskCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 25,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnomalyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String severity;
  final Color color;
  final VoidCallback onTap;

  const _AnomalyCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.severity,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          severity,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1.4,
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

class _RecommendationCard extends StatelessWidget {
  final String priority;
  final String title;
  final String description;
  final Color color;

  const _RecommendationCard({
    required this.priority,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                priority,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}