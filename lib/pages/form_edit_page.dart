import 'package:flutter/material.dart';
import 'package:lista_produtos/utils/connection.dart';
import 'package:lista_produtos/components/botao.dart';
import 'package:lista_produtos/components/campo.dart';
// import 'package:lista_produtos/components/formulario.dart';

// ignore: must_be_immutable
class FormEditPage extends StatefulWidget {
  Map initialData = {};
  var onChange;

  FormEditPage({Key key, this.initialData, this.onChange}) : super(key: key);

  @override
  _FormEditPageState createState() => _FormEditPageState();
}

class _FormEditPageState extends State<FormEditPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    _formData['id'] = widget.initialData['id'];
    _formData['nome'] = widget.initialData['nome'];
    _formData['quantidade'] = widget.initialData['quantidade'];

    String mensagemValidacao = 'Campo vazio';
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
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
                    valor: widget.initialData['nome'],
                  ),
                  Campo(
                    label: 'Quantidade',
                    mensagem: mensagemValidacao,
                    onCalback: (value) {
                      _formData['quantidade'] = value;
                    },
                    valor: widget.initialData['quantidade'],
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
                            _updateData();
                            Navigator.pop(context);
                          }
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

  _updateData() async {
    var data = [
      _formData['nome'],
      _formData['quantidade'],
      _formData['id'],
    ];

    var database = await SqliteDB.connect();
    await database.rawUpdate(
        'UPDATE produtos SET nome=?, quantidade=? WHERE id=?', data);

    widget.onChange();
  }

  /*
  @override
  Widget build(BuildContext context) {
    _formData['id'] = widget.initialData['id'];
    _formData['nome'] = widget.initialData['nome'];
    _formData['quantidade'] = widget.initialData['quantidade'];

    String mensagemValidacao = 'Campo vazio';
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
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
                  valor: widget.initialData['nome'],
                ),
                Campo(
                  label: 'Quantidade',
                  mensagem: mensagemValidacao,
                  onCalback: (value) {
                    _formData['quantidade'] = value;
                  },
                  valor: widget.initialData['quantidade'],
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
                          _updateData();
                          Navigator.pop(context);
                        }
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
    _formData['id'] = widget.initialData['id'];
    _formData['nome'] = widget.initialData['nome'];
    _formData['quantidade'] = widget.initialData['quantidade'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Formulario(
            formKey: _formKey,
            formData: _formData,
            valorNome: widget.initialData['nome'],
            valorQuantidade: widget.initialData['quantidade'],
            onFunction: _updateData(),
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
    _formData['id'] = widget.initialData['id'];
    _formData['nome'] = widget.initialData['nome'];
    _formData['quantidade'] = widget.initialData['quantidade'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
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
                  valor: widget.initialData['nome'],
                ),
                Campo(
                  label: 'Quantidade',
                  mensagem: 'Campo vazio',
                  onCalback: (value) {
                    _formData['quantidade'] = value;
                  },
                  valor: widget.initialData['quantidade'],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Botao(
                      texto: 'Salvar',
                      onCalback: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _updateData();
                          _formKey.currentState.reset();
                          Navigator.pop(context);
                        }
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
    _formData['id'] = widget.initialData['id'];
    _formData['nome'] = widget.initialData['nome'];
    _formData['quantidade'] = widget.initialData['quantidade'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
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
                    initialValue: widget.initialData['nome'],
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
                    initialValue: widget.initialData['quantidade'],
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
                          _updateData();
                          _formKey.currentState.reset();
                          Navigator.pop(context);
                        }
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
