import 'package:flutter/material.dart';

class Busca extends StatefulWidget {
  @override
  _BuscaState createState() => _BuscaState();
}

class _BuscaState extends State<Busca> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Busca',
          icon: Icon(Icons.search),
        ),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
