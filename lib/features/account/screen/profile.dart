import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vida/provider/userprovider.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile-details';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop()
          ),
        ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          
          Container(child: Text('Name:${user.name}')),
          //Container(child: Text('Name:${user.token}')),
          Container(child: Text('Name:${user.address}')),
          Container(child: Text('Name:${user.email}')),
          Container(child: Text('Name:${user.phone}')),
          ],
      )),
    );
  }
}
