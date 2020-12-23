import 'package:flutter/material.dart';

class Botao extends StatefulWidget {
  final String texto;
  final dynamic onCalback;
  final dynamic cor;

  Botao({Key key, this.onCalback, this.texto, this.cor}) : super(key: key);

  @override
  _BotaoState createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        widget.texto,
        style: TextStyle(fontSize: 20),
      ),
      padding: EdgeInsets.all(15),
      color: widget.cor,
      textColor: Colors.white,
      onPressed: widget.onCalback,
    );
  }
}
