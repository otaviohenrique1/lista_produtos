import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/connection.dart';
import './form_page.dart';
import './lista_produtos.dart';
import './teste_lista.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database _database;
  List _produtos = [];

  // ignore: must_call_super
  void initState() {
    getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Busca',
                icon: Icon(Icons.search),
              ),
              style: TextStyle(fontSize: 20),
            ),
          ),
          // RaisedButton(
          //   child: Text('Teste 1'),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => TesteLista(),
          //         ));
          //   },
          // ),
          ListaProdutos(
              produtos: _produtos,
              onChange: () {
                getProdutos();
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormPage(
                  onSaved: () {
                    getProdutos();
                  },
                ),
              ));
        },
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
      ),
    );
  }

  getProdutos() {
    SqliteDB.connect().then((database) {
      _database = database;
      _database.rawQuery('SELECT * FROM produtos').then((data) {
        setState(() {
          _produtos = data;
        });
      });
    });
  }
}
