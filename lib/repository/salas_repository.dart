import 'package:salabatepapo/models/sala_model.dart';

class SalasRepository {
  static List<SalaModel> salas = [
    SalaModel(nome: 'Amizade', icone: 'images/amizade.png'),
    SalaModel(nome: 'Diversos', icone: 'images/diversos.PNG'),
    SalaModel(nome: 'Namoro', icone: 'images/namoro.jpg'),
    SalaModel(nome: 'Tecnologia', icone: 'images/tecnologia.PNG')
  ];
}
