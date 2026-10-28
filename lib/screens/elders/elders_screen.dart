
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'register_elder_screen.dart';
import 'elder_profile_screen.dart';

class EldersScreen extends StatefulWidget {
  const EldersScreen({super.key});

  @override
  State<EldersScreen> createState() => _EldersScreenState();
}

class _EldersScreenState extends State<EldersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _elders = [
    {
      'name': 'Arthur Pendelton',
      'age': 78,
      'status': 'Stable',
      'activity': 'Heart rate normal 5m ago',
      'initials': 'AP',
      'avatarColor': const Color(0xFFDCE9FF),
      'statusColor': AppTheme.green,
    },
    {
      'name': 'Martha Vance',
      'age': 82,
      'status': 'Attention Required',
      'activity': 'Missed 10:00 AM Metformin',
      'initials': 'MV',
      'avatarColor': const Color(0xFFFFE8D2),
      'statusColor': const Color(0xFFE9A23B),
    },
    {
      'name': 'David Chen',
      'age': 85,
      'status': 'Critical Alert',
      'activity': 'Fall detection trigger 12m ago',
      'initials': 'DC',
      'avatarColor': const Color(0xFFFFDCDD),
      'statusColor': AppTheme.coral,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredElders {
    final query = _searchController.text.trim().toLowerCase();

    return _elders.where((elder) {
      final name = (elder['name'] ?? '').toString().toLowerCase();
      final matchesSearch = name.contains(query);

      final status = elder['status']?.toString() ?? '';
      bool matchesFilter;

      switch (_selectedFilter) {
        case 'Stable':
          matchesFilter = status == 'Stable';
          break;
        case 'Needs Attention':
          matchesFilter = status != 'Stable';
          break;
        default:
          matchesFilter = true;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Future<void> _addElder() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterElderScreen(),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      _elders.add(result);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${result['name']} registered successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (_) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: AppTheme.blue,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.muted,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(
        color: isSelected ? AppTheme.blue : const Color(0xFFE6EAF0),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget _buildElderCard(Map<String, dynamic> elder) {
    final statusColor =
        elder['statusColor'] as Color? ?? AppTheme.green;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ElderProfileScreen(),
    ),
  );
},

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor:
                    elder['avatarColor'] as Color? ??
                        const Color(0xFFDCE9FF),
                child: Text(
                  elder['initials']?.toString() ?? '?',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.navy,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      elder['name']?.toString() ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.navy,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Age ${elder['age'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.muted,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 9,
                          color: statusColor,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            elder['status']?.toString() ?? 'Unknown',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      elder['activity']?.toString() ??
                          'No recent activity',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.muted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredElders = _filteredElders;

    return Scaffold(
      backgroundColor: AppTheme.pageBackground,
      appBar: AppBar(
        title: const Text(
          'My Elders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.navy,
          ),
        ),
        backgroundColor: AppTheme.pageBackground,
        actions: [
          IconButton(
            onPressed: _addElder,
            tooltip: 'Register a new elder',
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              size: 28,
              color: AppTheme.blue,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 18),
              child: Text(
                'Review care status and activities',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.muted,
                ),
              ),
            ),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search elders by name',
                  hintStyle: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppTheme.muted,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          tooltip: 'Clear search',
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded),
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFE6EAF0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppTheme.blue,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Stable'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Needs Attention'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Elder profiles',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.navy,
                    ),
                  ),
                  Text(
                    '${filteredElders.length} found',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.muted,
                    ),
                  ),
                ],
              ),
            ),

            // Elder list
            Expanded(
              child: filteredElders.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_search_rounded,
                              size: 54,
                              color: AppTheme.muted,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No elders found',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.navy,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Try another name or change the filter.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.muted,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _selectedFilter = 'All';
                                });
                              },
                              child: const Text('Clear search and filters'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: filteredElders.length,
                      itemBuilder: (context, index) {
                        return _buildElderCard(filteredElders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
