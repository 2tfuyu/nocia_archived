import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/service/service_email_auth.dart';
import 'package:nocia/infrastructure/service/service_google_auth.dart';
import 'package:nocia/infrastructure/service/service_twitter_auth.dart';
import 'package:nocia/presentation/config/main.dart';
import 'package:nocia/presentation/home/home.dart';
import 'package:nocia/presentation/introduction/intro_screen.dart';
import 'package:nocia/infrastructure/service/firebase_auth.dart';

class NociaDrawer extends StatelessWidget {

  final User user;

  NociaDrawer({this.user});

  @override
  Widget build(BuildContext context) {
    return getDrawer(context, user.name, user.photoUrl);
  }

  Drawer getDrawer(BuildContext context, String displayName, String photoUrl) {
    return Drawer(
        child: ListView(
          children: <Widget> [
            Container(
              color: Colors.white,
              child: UserAccountsDrawerHeader(
                accountName: Text(displayName),
                accountEmail: Text(""),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(58, 66, 86, 1.0)
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(photoUrl ?? "http://freeiconbox.com/icon/256/17004.png")
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('ホーム',style:  TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<UserBloc>(
                  builder: (BuildContext context) => UserBloc(),
                  child: Home(),
                )));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('設定',style:  TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<UserBloc>(
                  builder: (BuildContext context) => UserBloc(),
                  child: Config(user: user),
                ),
                    fullscreenDialog: true)
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('ログアウト',style:  TextStyle(color: Colors.black),),
              onTap: () async{
                await instance().signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));
              },
            ),
          ],
        )
    );
  }
}