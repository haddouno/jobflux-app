import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  final bool isEntrepreneur;
  const SignupScreen({super.key, required this.isEntrepreneur});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Map<String, TextEditingController> _controllers = {};

  List<Map<String, String>> get _fields {
    if (widget.isEntrepreneur) {
      return [
        {'label': 'Company name :', 'hint': 'Your company name'},
        {'label': 'Email address :', 'hint': 'your@email.com'},
        {'label': 'Phone number :', 'hint': '+212 6xx xxx xxx'},
        {'label': 'Sector :', 'hint': 'e.g. Technology, Finance...'},
      ];
    } else {
      return [
        {'label': 'Full name :', 'hint': 'Your full name'},
        {'label': 'Email address :', 'hint': 'your@email.com'},
        {'label': 'Phone number :', 'hint': '+212 6xx xxx xxx'},
        {'label': 'Institute :', 'hint': 'Your school / university'},
        {'label': 'Filière :', 'hint': 'Your field of study'},
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    for (final f in _fields) {
      _controllers[f['label']!] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  void _signUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(isEntrepreneur: widget.isEntrepreneur),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Back
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back,
                    color: AppTheme.darkText, size: 24),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                'Sign up',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.mediumText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isEntrepreneur ? 'as Entrepreneur' : 'as Student',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.grayText,
                ),
              ),
              const SizedBox(height: 32),
              // Fields
              ..._fields.map((f) => _buildField(f)),
              const SizedBox(height: 32),
              // Sign up button
              Center(
                child: SizedBox(
                  width: 153,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('SIGN UP'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Already have account
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: RichText(
                    text: const TextSpan(
                      style:
                          TextStyle(fontSize: 13, color: AppTheme.grayText),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(Map<String, String> f) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            f['label']!,
            style: const TextStyle(fontSize: 14, color: AppTheme.darkText),
          ),
          const SizedBox(height: 4),
          Container(
            height: 51,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              controller: _controllers[f['label']],
              style:
                  const TextStyle(fontSize: 14, color: AppTheme.darkText),
              decoration: InputDecoration(
                hintText: f['hint'],
                hintStyle: const TextStyle(
                    color: AppTheme.grayText, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
