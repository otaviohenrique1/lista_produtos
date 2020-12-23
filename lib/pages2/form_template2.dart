import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormTemplate2 extends StatefulWidget {
  Map initialData = {};
  var onCallback;
  String tituloAppBar;

  FormTemplate2({Key key, this.initialData, this.tituloAppBar, this.onCallback})
      : super(key: key);

  @override
  _FormTemplate2State createState() => _FormTemplate2State();
}

class _FormTemplate2State extends State<FormTemplate2> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    _formData['id'] = _formData['id'] == '' ? '' : widget.initialData['id'];
    _formData['nome'] =
        _formData['nome'] == '' ? '' : widget.initialData['nome'];
    _formData['quantidade'] =
        _formData['quantidade'] == '' ? '' : widget.initialData['quantidade'];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tituloAppBar),
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
                          widget.onCallback();
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
}
