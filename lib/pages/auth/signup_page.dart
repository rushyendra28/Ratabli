import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ratabli/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _repwCtrl = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _loading = false;
  String _accountType = 'Individual';

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _pwCtrl.dispose();
    _repwCtrl.dispose();
    super.dispose();
  }

  void _trySignUp() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created for ${_emailCtrl.text}')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: mq.height * 0.07,
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔸 Logo at the top (same as in LoginPage)
                  SizedBox(
                    height:
                        mq.height * 0.10, // Adjust size as needed (0.08–0.12)
                    child: Image.asset(
                      'lib/assets/logo.png', // ← Make sure this path is correct
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔸 Form Card
                  Card(
                    color: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Colors.deepOrange,
                                  Colors.orangeAccent,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds),
                              child: Text(
                                'Create your account',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // First Name
                            TextFormField(
                              controller: _firstCtrl,
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                                labelStyle: TextStyle(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.black87,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Enter first name'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            // Last Name
                            TextFormField(
                              controller: _lastCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: TextStyle(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black87,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Enter last name'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            // Account Type
                            DropdownButtonFormField<String>(
                              value: _accountType,
                              decoration: const InputDecoration(
                                labelText: 'Account Type',
                                labelStyle: TextStyle(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.black87,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Individual',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Individual'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Organisation',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.business_outlined,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Organisation'),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (v) => setState(
                                () => _accountType = v ?? 'Individual',
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Email
                            TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.black87,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Enter email';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(v)) {
                                  return 'Invalid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Phone
                            IntlPhoneField(
                              controller: _phoneCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.phone_outlined,
                                  color: Colors.black87,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              initialCountryCode: 'OM',
                              onChanged: (phone) {},
                              style: const TextStyle(color: Colors.black87),
                              validator: (v) {
                                if (v == null || v.number.isEmpty) {
                                  return 'Enter phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Password
                            TextFormField(
                              controller: _pwCtrl,
                              obscureText: _obscure1,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.black87,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure1
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscure1 = !_obscure1),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Enter password';
                                }
                                if (v.length < 6) {
                                  return 'Password too short';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Re-enter Password
                            TextFormField(
                              controller: _repwCtrl,
                              obscureText: _obscure2,
                              decoration: InputDecoration(
                                labelText: 'Re-enter Password',
                                labelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_reset_outlined,
                                  color: Colors.black87,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscure2 = !_obscure2),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              validator: (v) {
                                if (v != _pwCtrl.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),

                            // Sign Up Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _trySignUp,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.deepOrange.withOpacity(
                                    0.4,
                                  ),
                                  elevation: 4,
                                ),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.deepOrange,
                                        Colors.orangeAccent,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    child: _loading
                                        ? const SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Continue with Google
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.login,
                                  color: Colors.deepOrange,
                                ),
                                label: const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Google Sign-Up placeholder',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Back to Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
