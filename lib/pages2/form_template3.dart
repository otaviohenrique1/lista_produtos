import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormTemplate extends StatefulWidget {
  var data;
  var onCallback;
  FormTemplate({Key key, this.data, this.onCallback}) : super(key: key);

  @override
  _FormTemplateState createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: TextFormField(
            initialValue:
                (widget.data == null || widget.data) ? '' : widget.data,
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
            initialValue:
                (widget.data == null || widget.data) ? '' : widget.data,
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
    );
  }
}
