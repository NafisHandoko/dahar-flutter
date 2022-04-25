import 'package:dahar/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:dahar/services/auth.dart';
import 'package:dahar/screens/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // print("masuk register");
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'REGISTER',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Text('Sign Up For Free',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15, top: 15),
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
                                hintText: 'example@mail.com',
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: color1,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                            child: TextFormField(
                              validator: (value) => value!.length < 6
                                  ? 'Enter password 6+ chars long'
                                  : null,
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                            child: TextFormField(
                              validator: (value) => value != password
                                  ? "confirmation password doesn't match"
                                  : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: borderRadius1,
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'password123',
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: color1,
                                ),
                                suffixIcon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            //width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: borderRadius1,
                                color: color1,
                                boxShadow: [boxshadow1]),
                            child: TextButton(
                              child: const Text(
                                'Create Account',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  // print('hasil: ' + result);
                                  if (result == null) {
                                    setState(() {
                                      error = 'pls supply a valid input';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'or continue with',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius1,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(90, 108, 234, 0.07),
                                      blurRadius: 50,
                                      spreadRadius: 0,
                                      offset: Offset(12, 26),
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Facebook',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius1,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(90, 108, 234, 0.07),
                                      blurRadius: 50,
                                      spreadRadius: 0,
                                      offset: Offset(12, 26),
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  Image.network(
                                    "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Google',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: color1),
                        )),
                  ],
                ),
              ),
            ),
          );
  }
}
