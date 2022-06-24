import 'package:dahar/services/databases/toko_database.dart';
import 'package:dahar/services/databases/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dahar/models/auth_user.dart';
import 'package:geolocator/geolocator.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase User obj
  AuthUser? _userFromFirebaseUser(User? user) {
    return user != null ? AuthUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AuthUser?> get user {
    return _auth
        .authStateChanges()
        // .map((User? user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email n password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email n password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      bool servicestatus = false;
      bool haspermission = false;
      late LocationPermission permission;
      late Position position;
      servicestatus = await Geolocator.isLocationServiceEnabled();
      if (servicestatus) {
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            print('Location permissions are denied');
          } else if (permission == LocationPermission.deniedForever) {
            print("'Location permissions are permanently denied");
          } else {
            haspermission = true;
          }
        } else {
          haspermission = true;
        }

        if (haspermission) {
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
        }
      } else {
        print("GPS Service is not enabled, turn on GPS location");
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await UserDatabase(uid: user!.uid).updateUser(
          email.split('@')[0],
          email,
          'https://firebasestorage.googleapis.com/v0/b/dahar-flutter.appspot.com/o/images%2Fdefault_user_photo.png?alt=media&token=0f46f1f2-e3c8-486b-9cb5-381f7dab155e',
          'images/default_user_photo.png');
      await TokoDatabase(uid: user.uid).updateToko(
          "Toko ${email.split('@')[0]}",
          'belum diset',
          position.latitude,
          position.longitude,
          'https://firebasestorage.googleapis.com/v0/b/dahar-flutter.appspot.com/o/images%2Fdefault_toko_photo.png?alt=media&token=725972f0-2808-4050-9f09-6adf98bf4962',
          'images/default_toko_photo.png');
      // await DatabaseService(uid: user.uid).addProduk(
      //     'Sate Kambing',
      //     7000,
      //     'sate enak',
      //     'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      //     4.0);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  deleteAuthUser() {
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();
    // user.delete();
    User? userToDelete = _auth.currentUser;
    if (userToDelete != null) {
      userToDelete.delete();
    }
  }
}
