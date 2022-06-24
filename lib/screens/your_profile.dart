import 'dart:developer';
import 'dart:io';

import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/dahar_user.dart';
import 'package:dahar/screens/menu_toko.dart';
import 'package:dahar/services/databases/user_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/services/auth.dart';
import 'package:image_picker/image_picker.dart';
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
        resizeToAvoidBottomInset: false,
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
    // log('logging user in your_profile');
    // log("${daharuser.length > 0 ? daharuser.first.email : ''}");
    // log('${daharuser.email}');
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
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      XFile? image = await picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 60,
                          preferredCameraDevice: CameraDevice.front);
                      if (image != null) {
                        UserDatabase(uid: daharuser.id).updateUserFoto(
                            daharuser.fotoRef ?? '', File(image.path));
                      }
                    },
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
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => EditDialog(
                              id_user: daharuser.id,
                            ));
                  },
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
                onPressed: () {
                  // UserDatabase(uid: daharuser.id).deleteUser();
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => DeleteUserDialog());
                },
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

class EditDialog extends StatefulWidget {
  final id_user;
  const EditDialog({Key? key, this.id_user}) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String newName = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Text('Ubah Nama',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      content: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(90, 108, 234, 0.07),
              blurRadius: 50,
              spreadRadius: 0,
              offset: Offset(12, 26),
            ),
          ],
        ),
        child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius1,
                borderSide: BorderSide(color: Colors.white),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'John Doe',
              labelText: 'Nama Baru',
              // prefixIcon: Icon(
              //   Icons.person,
              //   color: color1,
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (val) {
              setState(() {
                newName = val;
              });
            }),
      ),
      actions: <Widget>[
        // TextButton(
        //   child: Text('CANCEL'),
        //   onPressed: Navigator.of(context).pop,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: borderRadius2,
                // color: color1,
                border: Border.all(color: color1, width: 2),
                // boxShadow: [boxshadow1]
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: color1),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  border: Border.all(color: color1, width: 2),
                  boxShadow: [boxshadow1]),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Navigator.of(context).pop(_stars);
                  await UserDatabase(uid: widget.id_user)
                      .updateUserNama(newName);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class DeleteUserDialog extends StatefulWidget {
  final id_produk, oldGambarRef;
  const DeleteUserDialog({Key? key, this.id_produk, this.oldGambarRef})
      : super(key: key);

  @override
  State<DeleteUserDialog> createState() => _DeleteUserDialogState();
}

class _DeleteUserDialogState extends State<DeleteUserDialog> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Text('Ubah Data Produk',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      content: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(90, 108, 234, 0.07),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: Offset(12, 26))
                ]),
                child: TextFormField(
                  validator: (value) =>
                      // value != null ? (value.isEmpty ? 'Enter an email' : null):null,
                      value!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius1,
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'example@gmail.com',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.mail,
                      color: color1,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(90, 108, 234, 0.07),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: Offset(12, 26))
                ]),
                child: TextFormField(
                  validator: (value) =>
                      value!.length < 6 ? 'Enter password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius1,
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'password123',
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: color1,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        // TextButton(
        //   child: Text('CANCEL'),
        //   onPressed: Navigator.of(context).pop,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: borderRadius2,
                // color: color1,
                border: Border.all(color: color1, width: 2),
                // boxShadow: [boxshadow1]
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: color1),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: borderRadius2,
                // color: color1,
                border: Border.all(color: color1, width: 2),
                // boxShadow: [boxshadow1]
              ),
              child: TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = "couldn't login with those credentials";
                          loading = false;
                        });
                      } else {
                        await UserDatabase(uid: result.uid).deleteUser();
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName('/'),
                        );
                      }
                    }
                  }),
            ),
          ],
        )
      ],
    );
  }
}
