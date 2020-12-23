import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lista_produtos/utils/connection.dart';
import 'package:lista_produtos/pages/form_edit_page.dart';

// ignore: must_be_immutable
class ListaProdutos extends StatefulWidget {
  List produtos;
  var onChange;

  ListaProdutos({Key key, this.produtos, this.onChange}) : super(key: key);

  @override
  _ListaProdutosState createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  @override
  Widget build(BuildContext context) {
    List _produtos = widget.produtos;

    return Expanded(
      child: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableBehindActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_produtos[index]['nome']),
                subtitle: Text(_produtos[index]['quantidade']),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormEditPage(
                        initialData: _produtos[index],
                        onChange: () {
                          widget.onChange();
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Remover',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Excluir produto',
                        ),
                        content: Text(
                          'Deseja excluir o produto ?',
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Sim'),
                            onPressed: () {
                              SqliteDB.connect().then((database) {
                                return database.rawDelete(
                                    'DELETE FROM produtos WHERE id=?',
                                    [_produtos[index]['id']]);
                              }).then((data) {
                                widget.onChange();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Não'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
