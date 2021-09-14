import 'package:flutter/material.dart';
import 'package:zup_retro/model/card.dart' as zCard;
import 'package:zup_retro/model/column.dart' as zColumn;
import 'package:zup_retro/widget/card_widget.dart';

class ColumnWidget extends StatefulWidget {
  ColumnWidget({Key? key, required this.column, required this.onDeleteColumn}): super(key: key);

  final zColumn.Column column;
  final VoidCallback onDeleteColumn;

  @override
  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {

  bool _isEditing = false;
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange(){
    if (!_focus.hasFocus) {
      setState(() {
        _isEditing = false;
      });
    }
    debugPrint("Focus: "+_focus.hasFocus.toString());
  }

  void _addCard() {
    setState(() {
      widget.column.cards.add(
          zCard.Card("Card ${widget.column.cards.length+1}")
      );
    });
  }

  void _onDeleteCard(int index) {
    setState(() {
      widget.column.cards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 64,
        height: double.infinity,
        child: Card(
            child: ReorderableListView(
              padding: EdgeInsets.all(16),
              header: Row(
                children: [
                  Expanded(
                    child: _isEditing ?
                    TextField(
                      autofocus: true,
                      focusNode: _focus,
                      onChanged: (a) {
                        debugPrint("TF changed: "+a.toString());
                      },
                      controller: TextEditingController()..text = widget.column.nameOrPlaceholder,
                      onSubmitted: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            widget.column.name = value;
                          }
                          _isEditing = false;
                        });
                      },
                    ) :
                    InkWell(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: Text(
                        widget.column.nameOrPlaceholder,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_rounded),
                    color: Colors.redAccent,
                    onPressed: widget.onDeleteColumn,
                  )
                ],
              ),
              children: [
                for (int index = 0; index < widget.column.cards.length; index++)
                  CardWidget(
                    key: Key('$index'),
                    card: widget.column.cards[index],
                    onDeleteCard: () => _onDeleteCard(index),
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