// signup_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    final email = _emailController.text.trim();
    final pwd = _passwordController.text;
    if (email.isEmpty || pwd.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill required fields')));
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // simulate API
    // In real app: call sign-up endpoint here
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create An Account'), backgroundColor: Colors.teal),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 8),
                  TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email Address', hintText: 'Enter your email address')),
                  const SizedBox(height: 8),
                  TextFormField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone Number', hintText: '+880171111111')),
                  const SizedBox(height: 8),
                  TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name', hintText: 'Enter your name')),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscure = !_obscure)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(onPressed: _isLoading ? null : _createAccount, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal), child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Create An Account')),
                  ),
                  const SizedBox(height: 12),
                  const Text('Or Sign Up with'),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.blue)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.g_mobiledata, color: Colors.red)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.apple, color: Colors.black)),
                  ]),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
