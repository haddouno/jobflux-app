import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';

class AddScreen extends StatefulWidget {
  final bool isEntrepreneur;
  const AddScreen({super.key, required this.isEntrepreneur});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  int _step = 0; // 0=Select type, 1=Fill form, 2=Published
  String _selectedType = '';

  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _requireCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  final List<Map<String, dynamic>> _types = [
    {
      'label': 'GIG',
      'subtitle': 'Freelance / quick task',
      'icon': Icons.handshake_outlined,
      'color': const Color(0xFF6C63FF),
    },
    {
      'label': 'STAGE',
      'subtitle': 'Internship offer',
      'icon': Icons.school_outlined,
      'color': const Color(0xFFFF9500),
    },
    {
      'label': 'WORK',
      'subtitle': 'Full / part-time job',
      'icon': Icons.work_outline,
      'color': AppTheme.accentColor,
    },
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _requireCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          _buildHeader(),
          _buildStepIndicator(),
          Expanded(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        isEntrepreneur: widget.isEntrepreneur,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    HomeScreen(isEntrepreneur: widget.isEntrepreneur),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        right: 20,
        bottom: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.grid_view_rounded,
                color: AppTheme.accentColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 37,
              decoration: BoxDecoration(
                color: AppTheme.lightBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  'Post an Opportunity',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkText,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_outlined,
              color: AppTheme.darkText, size: 25),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        children: List.generate(3, (i) {
          final done = i < _step;
          final current = i == _step;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done || current
                        ? AppTheme.accentColor
                        : AppTheme.borderColor,
                  ),
                  child: Center(
                    child: done
                        ? const Icon(Icons.check,
                            color: Colors.white, size: 14)
                        : Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: current
                                  ? Colors.white
                                  : AppTheme.grayText,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                if (i < 2)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: done ? AppTheme.accentColor : AppTheme.borderColor,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBody() {
    switch (_step) {
      case 0:
        return _buildTypeSelection();
      case 1:
        return _buildForm();
      case 2:
        return _buildSuccess();
      default:
        return const SizedBox();
    }
  }

  Widget _buildTypeSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What do you want to post?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.darkText,
            ),
          ),
          const SizedBox(height: 24),
          ..._types.map((t) => _TypeCard(
                type: t,
                selected: _selectedType == t['label'],
                onTap: () => setState(() => _selectedType = t['label']),
              )),
          const Spacer(),
          if (_selectedType.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () => setState(() => _step = 1),
                child: const Text('Next'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FormField(
            label: 'Title',
            controller: _titleCtrl,
            hint: 'e.g. Full-Stack Developer Needed',
          ),
          _FormField(
            label: 'Description',
            controller: _descCtrl,
            hint: 'Describe the role, responsibilities...',
            maxLines: 4,
          ),
          _FormField(
            label: 'Requirements',
            controller: _requireCtrl,
            hint: 'List the required skills or qualifications...',
            maxLines: 3,
          ),
          _FormField(
            label: 'Compensation',
            controller: _priceCtrl,
            hint: 'e.g. 2000–4000 MAD/month or 20 MAD/delivery',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => setState(() => _step = 0),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.accentColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  minimumSize: const Size(105, 36),
                ),
                child: const Text('Back',
                    style: TextStyle(color: AppTheme.accentColor)),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _step = 2),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(104, 36),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Publish'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 172,
            height: 172,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppTheme.accentColor,
              size: 90,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Published!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppTheme.mediumText,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your opportunity has been posted successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: AppTheme.grayText, height: 1.5),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 270,
            height: 36,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      HomeScreen(isEntrepreneur: widget.isEntrepreneur),
                ),
              ),
              child: const Text('Back to Home'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final Map<String, dynamic> type;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard(
      {required this.type, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = type['color'] as Color;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.08) : AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? color : AppTheme.borderColor,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(type['icon'] as IconData, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type['label'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selected ? color : AppTheme.darkText,
                  ),
                ),
                Text(
                  type['subtitle'] as String,
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.grayText),
                ),
              ],
            ),
            const Spacer(),
            if (selected)
              Icon(Icons.check_circle, color: color, size: 22)
            else
              const Icon(Icons.radio_button_unchecked,
                  color: AppTheme.borderColor, size: 22),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;

  const _FormField({
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.lightBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 13, color: AppTheme.darkText),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    fontSize: 12, color: AppTheme.grayText),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
