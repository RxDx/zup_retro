class Card {
  final String id;
  String? text;

  Card(this.id, {this.text});

  String get textOrPlaceholder {
    return text ?? "Escreva aqui";
  }
}