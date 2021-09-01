import 'package:zup_retro/model/card.dart';

class Column {
  final String id;
  String? name;
  List<Card> cards = [];

  Column(this.id, {this.name});

  String get nameOrPlaceholder {
    return name ?? "Nova coluna 🚀";
  }
}