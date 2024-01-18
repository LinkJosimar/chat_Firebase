import 'package:flutter/material.dart';
import 'package:salabatepapo/pages/sala_page.dart';

import '../repository/salas_repository.dart';

class GrupoSalasPage extends StatefulWidget {
  const GrupoSalasPage({super.key});

  @override
  State<GrupoSalasPage> createState() => _GrupoSalasPageState();
}

class _GrupoSalasPageState extends State<GrupoSalasPage> {
  var salas = SalasRepository.salas;
  var nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grupo de Salas'),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int sala) {
              return ListTile(
                leading: Image.asset(salas[sala].icone),
                title: Text(salas[sala].nome),
                onTap: () {
                  nickNameController.text = "";
                  showDialog(
                      context: context,
                      builder: (BuildContext bc) {
                        return AlertDialog(
                          title: const Text("Informe o nome"),
                          content: TextField(
                            controller: nickNameController,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancelar")),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SalaPage(
                                              sala: salas[sala].nome,
                                              nick: nickNameController.text,
                                            )));
                              },
                              child: const Text("Entrar"),
                            )
                          ],
                        );
                      });
                },
              );
            },
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: salas.length));
  }
}
