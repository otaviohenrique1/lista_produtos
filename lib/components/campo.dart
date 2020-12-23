import 'package:flutter/material.dart';

class Campo extends StatefulWidget {
  final String label;
  final String mensagem;
  final dynamic onCalback;
  final dynamic valor;

  Campo({Key key, this.label, this.mensagem, this.onCalback, this.valor})
      : super(key: key);

  @override
  _CampoState createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: widget.valor,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        style: TextStyle(fontSize: 20),
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return widget.mensagem;
          }
        },
        onSaved: widget.onCalback,
      ),
    );
  }
}
