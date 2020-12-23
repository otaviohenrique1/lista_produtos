import 'package:flutter/material.dart';
import 'package:lista_produtos/utils/connection.dart';

// ignore: must_be_immutable
class FormEditPage1 extends StatefulWidget {
  Map initialData = {};
  var onChange;

  FormEditPage1({Key key, this.initialData, this.onChange}) : super(key: key);

  @override
  _FormEditPage1State createState() => _FormEditPage1State();
}

class _FormEditPage1State extends State<FormEditPage1> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

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
}
