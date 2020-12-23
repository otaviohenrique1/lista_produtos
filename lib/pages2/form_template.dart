import 'package:flutter/material.dart';
import 'package:lista_produtos/components/botao.dart';
import 'package:lista_produtos/components/campo.dart';

// ignore: must_be_immutable
class FormTemplate extends StatefulWidget {
  @override
  _FormTemplateState createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
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
}
