import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/services/auth.dart';

class YourProfile extends StatefulWidget {
  YourProfile({Key? key}) : super(key: key);

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Your Profile',
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 10),
                      // margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1628258475456-0224b1e4225a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rika Dwi Rijayanti',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'rika221@gmail.com',
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
                        Navigator.pushNamed(context, '/menu_toko');
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
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
