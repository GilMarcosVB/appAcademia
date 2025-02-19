import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

// Página de Login
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academia Brasil"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navega para a página Home
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, // Cor do botão
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: const Text("ENTRAR"),
        ),
      ),
    );
  }
}

// Página Home
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "Bem-vindo à Página Home!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
