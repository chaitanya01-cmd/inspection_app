import 'package:flutter/material.dart';
import 'report_details_screen.dart';

class AllReportsScreen extends StatefulWidget {
  const AllReportsScreen({super.key});

  @override
  State<AllReportsScreen> createState() => _AllReportsScreenState();
}

class _AllReportsScreenState extends State<AllReportsScreen> {
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<Map<String, String>> _reports = [
    {
      'title': 'Major Road Damage',
      'location': 'MG Road, Pune',
      'category': 'Road Damage',
      'risk': '92',
      'status': 'Critical',
    },
    {
      'title': 'Bridge Damage',
      'location': 'River Bridge, Pune',
      'category': 'Road Damage',
      'risk': '87',
      'status': 'Critical',
    },
    {
      'title': 'Streetlight Failure',
      'location': 'Station Road, Pune',
      'category': 'Streetlights',
      'risk': '76',
      'status': 'High',
    },
    {
      'title': 'Water Leakage',
      'location': 'FC Road, Pune',
      'category': 'Water & Drainage',
      'risk': '68',
      'status': 'Medium',
    },
    {
      'title': 'Garbage Accumulation',
      'location': 'Kothrud, Pune',
      'category': 'Waste Management',
      'risk': '54',
      'status': 'Medium',
    },
    {
      'title': 'Damaged Footpath',
      'location': 'Shivaji Nagar, Pune',
      'category': 'Road Damage',
      'risk': '48',
      'status': 'Low',
    },
    {
      'title': 'Open Drain',
      'location': 'Aundh Road, Pune',
      'category': 'Water & Drainage',
      'risk': '81',
      'status': 'High',
    },
    {
      'title': 'Broken Traffic Signal',
      'location': 'Deccan, Pune',
      'category': 'Other',
      'risk': '89',
      'status': 'Critical',
    },
  ];

  List<Map<String, String>> get _filteredReports {
    return _reports.where((report) {
      final matchesFilter = _selectedFilter == 'All' ||
          report['status'] == _selectedFilter;

      final query = _searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          report['title']!.toLowerCase().contains(query) ||
          report['location']!.toLowerCase().contains(query) ||
          report['category']!.toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Critical':
        return const Color(0xFFDC2626);
      case 'High':
        return const Color(0xFFEA580C);
      case 'Medium':
        return const Color(0xFFD97706);
      case 'Low':
        return const Color(0xFF16A34A);
      default:
        return Colors.grey;
    }
  }

  void _openReport(Map<String, String> report) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportDetailsScreen(
          title: report['title']!,
          location: report['location']!,
          risk: report['risk']!,
          status: report['status']!.toUpperCase(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _filteredReports;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF163A5F),
        foregroundColor: Colors.white,
        title: const Text(
          'Infrastructure Reports',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search reports...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                ),
              ),
            ),
          ),

          // Filters
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _selectedFilter == 'All',
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'All';
                    });
                  },
                ),
                _FilterChip(
                  label: 'Critical',
                  selected: _selectedFilter == 'Critical',
                  color: const Color(0xFFDC2626),
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'Critical';
                    });
                  },
                ),
                _FilterChip(
                  label: 'High',
                  selected: _selectedFilter == 'High',
                  color: const Color(0xFFEA580C),
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'High';
                    });
                  },
                ),
                _FilterChip(
                  label: 'Medium',
                  selected: _selectedFilter == 'Medium',
                  color: const Color(0xFFD97706),
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'Medium';
                    });
                  },
                ),
                _FilterChip(
                  label: 'Low',
                  selected: _selectedFilter == 'Low',
                  color: const Color(0xFF16A34A),
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'Low';
                    });
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
            child: Row(
              children: [
                Text(
                  '${filteredReports.length} Reports',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                if (_selectedFilter != 'All' || _searchQuery.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilter = 'All';
                        _searchQuery = '';
                      });
                    },
                    child: const Text('Clear'),
                  ),
              ],
            ),
          ),

          Expanded(
            child: filteredReports.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 55,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No reports found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Try another search or filter.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: filteredReports.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final report = filteredReports[index];
                      final color = _statusColor(report['status']!);

                      return InkWell(
                        onTap: () => _openReport(report),
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
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.report_problem_outlined,
                                  color: color,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      report['title']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 3),
                                        Expanded(
                                          child: Text(
                                            report['location']!,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 9),
                                    Row(
                                      children: [
                                        Text(
                                          'Risk ${report['risk']}/100',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                color.withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            report['status']!,
                                            style: TextStyle(
                                              color: color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? const Color(0xFF163A5F);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: chipColor,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: selected ? Colors.white : const Color(0xFF475569),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        side: BorderSide(
          color: selected
              ? chipColor
              : const Color(0xFFE2E8F0),
        ),
      ),
    );
  }
}