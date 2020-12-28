import 'package:flutter/material.dart';
import 'package:lista_produtos/utils/connection.dart';
import 'package:lista_produtos/components/campo.dart';
import 'package:lista_produtos/components/botao.dart';
// import 'package:lista_produtos/components/formulario.dart';

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

  /*
  // Backup 04

  @override
  Widget build(BuildContext context) {
    String mensagemValidacao = 'Campo vazio';
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
        ),
      ),
    );
  }
  */

  /*
  // Backup 03

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Formulario(
            formKey: _formKey,
            formData: _formData,
            onFunction: _insertData(),
          ),
        ),
      ),
    );
  }
  */

  /*
  // Backup 02

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
                  label: 'Nome',
                  mensagem: 'Campo vazio',
                  onCalback: (value) {
                    _formData['nome'] = value;
                  },
                ),
                Campo(
                  label: 'Quantidade',
                  mensagem: 'Campo vazio',
                  onCalback: (value) {
                    _formData['quantidade'] = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Botao(
                      texto: 'Salvar',
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
                      onCalback: () {
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
  */

  /*
  // Backup 01
  
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
  */
}
