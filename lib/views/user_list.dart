import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class UserList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     final  Users users = Provider.of(context );

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuario'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM

              );   
            },
          ),
        ],
      ),
          body: ListView.builder(
            itemCount: users.count,
            itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
            ),
          );
    
     
     
  }
}