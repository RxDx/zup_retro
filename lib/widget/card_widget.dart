import 'package:flutter/material.dart';
import '../model/card.dart' as zc;

class CardWidget extends StatefulWidget {
  CardWidget({Key? key, required this.card}): super(key: key);

  final zc.Card card;

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
          trailing: Icon(Icons.delete_rounded),
          onTap: () { },
        )
    );
  }
}