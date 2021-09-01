import 'package:flutter/material.dart';
import 'package:zup_retro/widget/column_widget.dart';
import '../model/board.dart';
import '../model/column.dart' as zc;

class BoardWidget extends StatefulWidget {
  BoardWidget({Key? key, required this.board}): super(key: key);

  final Board board;

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.board.columns.add(zc.Column("Nova coluna", []));
    });
  }

  void _onDeleteColumn(int index) {
    setState(() {
      widget.board.columns.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.board.id + ' - Sprint $_counter'),
      ),
      body: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: widget.board.columns.length,
        itemBuilder:  (BuildContext context, int index) {
          return ColumnWidget(
            key: Key('$index'),
            column: widget.board.columns[index],
            onDeleteColumn: () => _onDeleteColumn(index),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final zc.Column item = widget.board.columns.removeAt(oldIndex);
            widget.board.columns.insert(newIndex, item);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}