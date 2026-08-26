import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF163A5F),
        foregroundColor: Colors.white,
        title: const Text(
          'Municipal Analytics',
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
              'Infrastructure Analytics',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Overview of municipal reports and infrastructure performance',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Summary cards
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Total Reports',
                    value: '120',
                    subtitle: '+18 this week',
                    icon: Icons.assignment_outlined,
                    iconColor: const Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: 'Resolved',
                    value: '68',
                    subtitle: '56.7% resolution',
                    icon: Icons.check_circle_outline,
                    iconColor: const Color(0xFF16A34A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Pending',
                    value: '52',
                    subtitle: '43.3% remaining',
                    icon: Icons.pending_actions,
                    iconColor: const Color(0xFFEA580C),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: 'Avg. Resolution',
                    value: '3.2d',
                    subtitle: '↓ 0.8d this month',
                    icon: Icons.timer_outlined,
                    iconColor: const Color(0xFF7C3AED),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Reports by Category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 12),

            _CategoryCard(
              title: 'Road Damage',
              count: '42',
              percentage: 0.75,
              color: const Color(0xFF2563EB),
            ),

            const SizedBox(height: 10),

            _CategoryCard(
              title: 'Streetlights',
              count: '28',
              percentage: 0.50,
              color: const Color(0xFFEA580C),
            ),

            const SizedBox(height: 10),

            _CategoryCard(
              title: 'Water & Drainage',
              count: '24',
              percentage: 0.43,
              color: const Color(0xFF0891B2),
            ),

            const SizedBox(height: 10),

            _CategoryCard(
              title: 'Waste Management',
              count: '16',
              percentage: 0.29,
              color: const Color(0xFF16A34A),
            ),

            const SizedBox(height: 10),

            _CategoryCard(
              title: 'Other',
              count: '10',
              percentage: 0.18,
              color: const Color(0xFF7C3AED),
            ),

            const SizedBox(height: 30),

            const Text(
              'Risk Distribution',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                children: [
                  _RiskRow(
                    label: 'Critical',
                    count: '12',
                    percentage: '10%',
                    color: const Color(0xFFDC2626),
                  ),
                  const SizedBox(height: 18),
                  _RiskRow(
                    label: 'High',
                    count: '25',
                    percentage: '21%',
                    color: const Color(0xFFEA580C),
                  ),
                  const SizedBox(height: 18),
                  _RiskRow(
                    label: 'Medium',
                    count: '47',
                    percentage: '39%',
                    color: const Color(0xFFD97706),
                  ),
                  const SizedBox(height: 18),
                  _RiskRow(
                    label: 'Low',
                    count: '36',
                    percentage: '30%',
                    color: const Color(0xFF16A34A),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Most Affected Areas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 12),

            _AreaCard(
              rank: '1',
              area: 'MG Road',
              reports: '18 reports',
              risk: '92',
              color: const Color(0xFFDC2626),
            ),

            const SizedBox(height: 10),

            _AreaCard(
              rank: '2',
              area: 'Station Road',
              reports: '14 reports',
              risk: '76',
              color: const Color(0xFFEA580C),
            ),

            const SizedBox(height: 10),

            _AreaCard(
              rank: '3',
              area: 'FC Road',
              reports: '11 reports',
              risk: '68',
              color: const Color(0xFFD97706),
            ),

            const SizedBox(height: 30),

            // Resolution performance
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
                        Icons.insights,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Performance Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Resolution performance has improved by 14% this month. '
                    'Road damage remains the largest source of municipal '
                    'reports and MG Road currently has the highest risk level.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 26,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: iconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String count;
  final double percentage;
  final Color color;

  const _CategoryCard({
    required this.title,
    required this.count,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                count,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percentage,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: const Color(0xFFE2E8F0),
            color: color,
          ),
        ],
      ),
    );
  }
}

class _RiskRow extends StatelessWidget {
  final String label;
  final String count;
  final String percentage;
  final Color color;

  const _RiskRow({
    required this.label,
    required this.count,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 42,
          child: Text(
            percentage,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _AreaCard extends StatelessWidget {
  final String rank;
  final String area;
  final String reports;
  final String risk;
  final Color color;

  const _AreaCard({
    required this.rank,
    required this.area,
    required this.reports,
    required this.risk,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank,
                style: TextStyle(
                  color: color,
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
                  area,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reports,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Risk',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              Text(
                risk,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}