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

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          title: _isEditing ?
          TextField(
            autofocus: true,
            focusNode: _focus,
            controller: TextEditingController()..text = widget.card.text ?? "",
            onSubmitted: (value) {
              setState(() {
                if (value.isNotEmpty) {
                  widget.card.text = value;
                }
                _isEditing = false;
              });
            },
          ) :
          Text(
            widget.card.textOrPlaceholder,
            style: Theme.of(context).textTheme.bodyText2,
            textScaleFactor: 0.9,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_rounded),
            color: Colors.redAccent,
            onPressed: widget.onDeleteCard,
          ),
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            setState(() {
              _isEditing = true;
            });
          },
        )
    );
  }
}