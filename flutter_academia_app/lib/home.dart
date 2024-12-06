import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> planos = [];

  @override
  void initState() {
    super.initState();
    listaPlanos();
  }

  Future<void> listaPlanos() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.56.45.23/public/api/planos'));

      if (response.statusCode == 200) {
        setState(() {
          planos = json.decode(response.body);
        });
      }
    } catch (e) {
      mostrarError('Erro: $e');
    }
  }

  void mostrarError(String mensagem) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagem),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Planos Academia"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: const [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  child: Text(
                    "Bem-Vindo , Cliente",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text("Login"),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Serviços"),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("Dúvidas"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("Academia Brasil"),
              ),
            ],
          ),
        ),
        body: planos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: planos.length,
                itemBuilder: (context, index) {
                  final plano = planos[index];
                  return SizedBox(
                    height: 150, // Ajuste a altura conforme necessário
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            plano['imagem'] != null
                                ? Image.network(
                                    plano['imagem'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey,
                                    child:
                                        const Icon(Icons.image_not_supported),
                                  ),
                            const SizedBox(
                                width: 16), // Espaço entre a imagem e os dados
                            // Dados à direita
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plano['nome_plano'] ?? 'Sem nome',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 8), // Espaço entre os textos
                                  Text(
                                    'Duração: ${plano['duracao'] ?? 'Sem duração'} dias',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(
                                      height: 4), // Espaço entre os textos
                                  Text(
                                    'Preço: R\$ ${double.tryParse(plano['preco'].toString())?.toStringAsFixed(2) ?? '0.00'}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
