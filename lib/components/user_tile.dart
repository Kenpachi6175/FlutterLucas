import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user, {super.key});
  

  @override
  Widget build(BuildContext context) {
    CircleAvatar? ca;
    if (user.avatarUrl.isEmpty) {
      ca = const CircleAvatar(child: Icon(Icons.person));
    } else {
      ca = CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    }
    return ListTile(
      leading: ca,
      title: Text(user.nome),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.orange ,
            onPressed: (){
               Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: user,

              );
            },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Excluir Usuario'),
                    content: const Text('Tem certeza???'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  Provider.of<Users>(context, listen: false).remove(user);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}