import 'package:flutter/material.dart';
import 'package:zup_retro/model/column.dart' as zColumn;
import 'package:zup_retro/model/card.dart' as zCard;
import 'package:zup_retro/widget/card_widget.dart';

class ColumnWidget extends StatefulWidget {
  ColumnWidget({Key? key, required this.column}): super(key: key);

  final zColumn.Column column;

  @override
  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {

  void _addCard() {
    setState(() {
      widget.column.cards.add(
          zCard.Card("Card ${widget.column.cards.length+1}")
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: double.infinity,
        child: Card(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  widget.column.id,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.column.cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardWidget(
                        key: Key('$index'),
                        card: widget.column.cards[index]
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final zCard.Card item = widget.column.cards.removeAt(oldIndex);
                      widget.column.cards.insert(newIndex, item);
                    });
                  },
                ),
                TextButton(onPressed: _addCard, child: Text("Adicionar novo card")),
              ],
            )
        )
    );
  }
}