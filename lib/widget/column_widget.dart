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

  void _onDelete(int index) {
    setState(() {
      widget.column.cards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: double.infinity,
        child: Card(
            child: ReorderableListView(
              padding: EdgeInsets.all(16),
              header: Text(
                widget.column.id,
                key: Key('title_text'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              children: [
                for (int index = 0; index < widget.column.cards.length; index++)
                  CardWidget(
                    key: Key('$index'),
                    card: widget.column.cards[index],
                    onDelete: () => _onDelete(index),
                  ),
                TextButton(
                    key: Key('add_card_button'),
                    onPressed: _addCard,
                    child: Text("Adicionar novo card")
                ),
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex == widget.column.cards.length ||
                    newIndex == widget.column.cards.length + 1) return;
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final zCard.Card item = widget.column.cards.removeAt(oldIndex);
                  widget.column.cards.insert(newIndex, item);
                });
              },
            )
        )
    );
  }
}