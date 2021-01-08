import 'package:flutter/material.dart';
import 'package:lista_produtos/utils/connection.dart';
import 'package:lista_produtos/components/campo.dart';
import 'package:lista_produtos/components/botao.dart';

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
    String mensagemValidacao = 'Campo vazio';
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Campo(
                    label: 'Nome',
                    mensagem: mensagemValidacao,
                    onCalback: (value) {
                      _formData['nome'] = value;
                    },
                  ),
                  Campo(
                    label: 'Quantidade',
                    mensagem: mensagemValidacao,
                    onCalback: (value) {
                      _formData['quantidade'] = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Botao(
                        texto: 'Salvar',
                        cor: Colors.blue,
                        onCalback: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _insertData();
                            _formKey.currentState.reset();
                            Navigator.pop(context);
                          }
                        },
                      ),
                      Botao(
                        texto: 'Limpar',
                        cor: Colors.red,
                        onCalback: () {
                          _formKey.currentState.reset();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
