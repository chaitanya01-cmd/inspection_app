import 'package:flutter/material.dart';
import 'report_details_screen.dart';

class IssueMapScreen extends StatelessWidget {
  const IssueMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF163A5F),
        foregroundColor: Colors.white,
        title: const Text(
          'Infrastructure Map',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Map background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFE8EDF2),
            child: CustomPaint(
              painter: _MapPainter(),
            ),
          ),

          // Map markers
          Positioned(
            top: 150,
            left: 110,
            child: _MapMarker(
              risk: 92,
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
          ),

          Positioned(
            top: 280,
            right: 100,
            child: _MapMarker(
              risk: 87,
              color: const Color(0xFFDC2626),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportDetailsScreen(
                      title: 'Bridge Damage',
                      location: 'River Bridge, Pune',
                      risk: '87',
                      status: 'CRITICAL',
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: 370,
            left: 180,
            child: _MapMarker(
              risk: 76,
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
          ),

          Positioned(
            top: 220,
            left: 260,
            child: _MapMarker(
              risk: 63,
              color: const Color(0xFFD97706),
              onTap: () {},
            ),
          ),

          Positioned(
            top: 430,
            right: 160,
            child: _MapMarker(
              risk: 42,
              color: const Color(0xFF16A34A),
              onTap: () {},
            ),
          ),

          // Map controls
          Positioned(
            right: 20,
            top: 20,
            child: Column(
              children: [
                _MapControl(
                  icon: Icons.add,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _MapControl(
                  icon: Icons.remove,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _MapControl(
                  icon: Icons.my_location,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Legend
          Positioned(
            left: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Level',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  _LegendItem(
                    color: Color(0xFFDC2626),
                    label: 'Critical',
                  ),
                  SizedBox(height: 6),
                  _LegendItem(
                    color: Color(0xFFEA580C),
                    label: 'High',
                  ),
                  SizedBox(height: 6),
                  _LegendItem(
                    color: Color(0xFFD97706),
                    label: 'Medium',
                  ),
                  SizedBox(height: 6),
                  _LegendItem(
                    color: Color(0xFF16A34A),
                    label: 'Low',
                  ),
                ],
              ),
            ),
          ),

          // Report count
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xFFDC2626),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '120 Reports',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
}

class _MapMarker extends StatelessWidget {
  final int risk;
  final Color color;
  final VoidCallback onTap;

  const _MapMarker({
    required this.risk,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$risk',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          CustomPaint(
            size: const Size(12, 8),
            painter: _MarkerTrianglePainter(color),
          ),
        ],
      ),
    );
  }
}

class _MapControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapControl({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            color: const Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
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
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFD0D7DE)
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke;

    final minorRoadPaint = Paint()
      ..color = const Color(0xFFD8DEE4)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // Main roads
    canvas.drawLine(
      Offset(0, size.height * 0.25),
      Offset(size.width, size.height * 0.75),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.1, size.height),
      Offset(size.width * 0.8, 0),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.55, 0),
      Offset(size.width * 0.55, size.height),
      roadPaint,
    );

    // Smaller roads
    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.35),
      minorRoadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.8, size.height),
      minorRoadPaint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.85),
      minorRoadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _MarkerTrianglePainter extends CustomPainter {
  final Color color;

  _MarkerTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}