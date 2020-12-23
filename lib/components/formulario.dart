import 'package:flutter/material.dart';
import 'package:lista_produtos/components/botao.dart';
import 'package:lista_produtos/components/campo.dart';

class Formulario extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final dynamic formData;
  final dynamic onFunction;
  final dynamic valorNome;
  final dynamic valorQuantidade;

  Formulario({
    Key key,
    this.formKey,
    this.formData,
    this.valorNome,
    this.valorQuantidade,
    this.onFunction,
  }) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    var mensagemCampoVazio = 'Campo vazio';
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Campo(
            label: 'Nome',
            mensagem: mensagemCampoVazio,
            onCalback: (value) {
              widget.formData['nome'] = value;
            },
            valor: (widget.valorNome == null) ? '' : widget.valorNome,
          ),
          Campo(
            label: 'Quantidade',
            mensagem: mensagemCampoVazio,
            onCalback: (value) {
              widget.formData['quantidade'] = value;
            },
            valor:
                (widget.valorQuantidade == null) ? '' : widget.valorQuantidade,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Botao(
                texto: 'Salvar',
                onCalback: () {
                  if (widget.formKey.currentState.validate()) {
                    widget.formKey.currentState.save();
                    // ignore: unnecessary_statements
                    widget.onFunction;
                    widget.formKey.currentState.reset();
                    Navigator.pop(context);
                  }
                },
              ),
              Botao(
                texto: 'Limpar',
                onCalback: () {
                  widget.formKey.currentState.reset();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
