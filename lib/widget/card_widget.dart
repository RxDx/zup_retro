import 'package:flutter/material.dart';
import '../model/card.dart' as zc;

class CardWidget extends StatefulWidget {
  CardWidget({Key? key, required this.card, required this.onDeleteCard}): super(key: key);

  final zc.Card card;
  final VoidCallback onDeleteCard;

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          title: Text(
            widget.card.id,
            style: Theme.of(context).textTheme.bodyText2,
            textScaleFactor: 0.9,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_rounded),
            color: Colors.redAccent,
            onPressed: widget.onDeleteCard,
          ),
          onTap: () {},
        )
    );
  }
}