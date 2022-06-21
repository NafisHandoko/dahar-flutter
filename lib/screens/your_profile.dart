import 'dart:developer';

import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/dahar_user.dart';
import 'package:dahar/screens/menu_toko.dart';
import 'package:dahar/services/databases/user_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/services/auth.dart';
import 'package:provider/provider.dart';

class YourProfile extends StatefulWidget {
  YourProfile({Key? key}) : super(key: key);

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);
    return StreamProvider<DaharUser>.value(
      initialData: DaharUser(),
      value: UserDatabase(uid: user?.uid).user2,
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: BackAppBar(
              title: 'Your Profile',
            )),
        body: ProfileBuilder(auth: _auth),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}

class ProfileBuilder extends StatelessWidget {
  const ProfileBuilder({
    Key? key,
    required AuthService auth,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    final daharuser = Provider.of<DaharUser>(context);
    log('logging user in your_profile');
    // log("${daharuser.length > 0 ? daharuser.first.email : ''}");
    log('${daharuser.email}');
    // return Container();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      color: Colors.white,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            Stack(children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(bottom: 10),
                // margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("${daharuser.foto}"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    color: color1),
              ),
              Positioned(
                  bottom: 10,
                  right: 0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorBlueEdit,
                          boxShadow: [boxshadow2]),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ))
            ]),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "${daharuser.nama}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorBlueEdit,
                        boxShadow: [boxshadow2]),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'rika221',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorGrey),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "${daharuser.email}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorGrey),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  boxShadow: [boxshadow1]),
              child: TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/menu_toko');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuToko(
                              id_toko: daharuser.id,
                            )),
                  );
                },
                child: Text(
                  'Menu Toko',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  color: colorGrey,
                  boxShadow: [boxshadow1]),
              child: TextButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  color: colorRedDelete,
                  boxShadow: [boxshadow1]),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
