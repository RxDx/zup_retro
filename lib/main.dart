import 'package:flutter/material.dart';
import 'package:zup_retro/widget/board_widget.dart';
import 'package:zup_retro/model/board.dart';
import 'package:zup_retro/model/column.dart' as zColumn;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZupRetro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardWidget(
          board: Board(
            "ZupRetro",
            [
              zColumn.Column("Continuar fazendo", []),
              zColumn.Column("Podemos melhorar", []),
            ]
          )
      ),
    );
  }
}
