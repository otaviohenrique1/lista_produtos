import 'package:flutter/material.dart';
import 'package:lista_produtos/utils/connection.dart';
import 'package:lista_produtos/components/campo.dart';

// ignore: must_be_immutable
class FormPage2 extends StatefulWidget {
  var onSaved;

  FormPage2({Key key, this.onSaved}) : super(key: key);

  @override
  _FormPage2State createState() => _FormPage2State();
}

class _FormPage2State extends State<FormPage2> {
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
                Campo(
                  label: 'Teste 1',
                  mensagem: 'Campo vazio',
                  onCalback: (value) {
                    print('Teste 1');
                  },
                ),
                Campo(
                  label: 'Teste 2',
                  mensagem: 'Campo vazio',
                  onCalback: (value) {
                    print('Teste 1');
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    style: TextStyle(fontSize: 20),
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
                    style: TextStyle(fontSize: 20),
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
                      child: Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.all(15),
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
                      child: Text(
                        'Limpar',
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.all(15),
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
