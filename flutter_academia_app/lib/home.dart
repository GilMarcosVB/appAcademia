import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> servicos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    carregarServicos(); // Carrega os dados ao iniciar
  }

  // Método para simular carregamento de dados
  void carregarServicos() async {
    try {
      // Simulando dados (você pode substituir por uma chamada a uma API)
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        servicos = [
          {
            "titulo": "Corte de Cabelo",
            "descricao": "Corte moderno e estiloso.",
            "valor": "50.00",
            "fotos": [
              {"imagem": "https://via.placeholder.com/100"}
            ],
          },
          {
            "titulo": "Manicure e Pedicure",
            "descricao": "Cuidados especiais para suas unhas.",
            "valor": "30.00",
            "fotos": [
              {"imagem": "https://via.placeholder.com/100"}
            ],
          },
        ];
      });
    } catch (e) {
      mostrarError("Erro ao carregar os serviços.");
    }
  }

  void mostrarError(String mensagem) {
    setState(() {
      isLoading = false;
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
                padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                child: Text(
                  "Olá, Gilzao",
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
              title: Text("Sobre o BookMeNow"),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: servicos.length,
              itemBuilder: (context, index) {
                final servico = servicos[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Verifica se há imagem disponível
                      if (servico['fotos'] != null &&
                          servico['fotos'].isNotEmpty)
                        Image.network(
                          servico['fotos'][0]['imagem'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      else
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                servico['titulo'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                servico['descricao'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'R\$ ${double.tryParse(servico['valor'])?.toStringAsFixed(2) ?? '0.00'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
