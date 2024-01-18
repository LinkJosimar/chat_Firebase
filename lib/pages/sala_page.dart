import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/text_model.dart';

class SalaPage extends StatefulWidget {
  final String sala;
  final String nick;
  const SalaPage({super.key, required this.sala, required this.nick});

  @override
  State<SalaPage> createState() => _SalaPageState();
}

class _SalaPageState extends State<SalaPage> {
  final db = FirebaseFirestore.instance;
  String userId = "";
  var textoController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    carregaUsuario();
  }

  carregaUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sala),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection("Salas")
                        .where('sala', isEqualTo: widget.sala)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const CircularProgressIndicator()
                          : ListView(
                              children: snapshot.data!.docs.map((e) {
                                var textModel = TextModel.fromJson(
                                    (e.data() as Map<String, dynamic>));
                                return Container(
                                  alignment: userId == textModel.userId
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: textModel.userId == userId
                                            ? Colors.blueGrey
                                            : Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(textModel.text),
                                  ),
                                );
                              }).toList(),
                            );
                    })),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: Colors.blueGrey,
                  )),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: textoController,
                  decoration:
                      const InputDecoration(focusedBorder: InputBorder.none),
                  style: const TextStyle(fontSize: 18),
                )),
                IconButton(
                    onPressed: () async {
                      var textModel = TextModel(
                          nickName: widget.nick,
                          sala: widget.sala,
                          text: textoController.text,
                          userId: userId);
                      await db.collection("Salas").add(textModel.toJson());
                      textoController.text = '';
                    },
                    icon: const Icon(Icons.send)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
