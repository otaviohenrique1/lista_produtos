import 'package:flutter/material.dart';
import 'package:lista_produtos/utils/connection.dart';

// ignore: must_be_immutable
class FormPage extends StatefulWidget {
  var onSaved;

  FormPage({Key key, this.onSaved}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo vazio';
                      }
                    },
                    onSaved: (value) {
                      _formData['nome'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo vazio';
                      }
                    },
                    onSaved: (value) {
                      _formData['quantidade'] = value;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('Salvar'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _insertData();
                          _formKey.currentState.reset();
                          Navigator.pop(context);
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('Limpar'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        _formKey.currentState.reset();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _insertData() async {
    var data = [
      _formData['nome'],
      _formData['quantidade'],
    ];

    var database = await SqliteDB.connect();
    database.transaction((txn) async {
      // ignore: unused_local_variable
      int id = await txn.rawInsert(
          'INSERT INTO produtos (nome, quantidade) VALUES (?,?)', data);
      widget.onSaved();
    });
  }
}
