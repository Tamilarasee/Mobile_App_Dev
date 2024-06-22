import 'dart:convert';
import 'package:battleships/utils/sessionmanager.dart';
import 'package:battleships/views/battleships.dart';
import 'package:flutter/material.dart';
import 'package:battleships/views/games_list_page.dart';
import 'package:http/http.dart' as http;

import 'menu.dart';

/// Screen for logging in or registering a new user.
class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String baseUrl = 'http://165.227.117.48';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battleships'),
        centerTitle: true
        ),
      
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => _login(context),
                    child: const Text('Log in'),
                  ),
                  TextButton(
                    onPressed: () => _register(context),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url, 
      headers: {
        'Content-Type': 'application/json', 
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      })
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      // Successful login. Save the session token or user info.

      // parse the session token from the response header
      // final sessionToken = response.headers['set-cookie']!.split(';')[0];
      final sessionToken = jsonDecode(response.body)['access_token'];
      await SessionManager.setSessionToken(sessionToken, username);

      if (!context.mounted) return;

      // go to the main screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => GamesListPage(isActive: true,)
      ));
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }

  Future<void> _register(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(url, 
      headers: {
        'Content-Type': 'application/json', 
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      })
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      // Successful registration. Treat this like a login.

      // parse the session token from the response header
      // final sessionToken = response.headers['set-cookie']!.split(';')[0];
      final sessionToken = jsonDecode(response.body)['access_token'];
      await SessionManager.setSessionToken(sessionToken, username);

      if (!context.mounted) return;

      // go to the main screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => GamesListPage(isActive: true,)
      ));
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    } 
  }
}
