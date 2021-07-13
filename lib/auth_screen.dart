import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turns/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  int numOfPlayers;
  AuthScreen({this.numOfPlayers});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int numOfPlayers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numOfPlayers = widget.numOfPlayers;
  }

  var _isLoading = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  void _submitAuthForm(String email, String password, String userName,
      bool isLogin, BuildContext ctx, int numOfPlayers) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': userName,
          'email': email,
        });
      }
    } on PlatformException catch (e) {
      var message = 'An error occurred, please check your credentials';
      if (e.message != null) {
        message = e.message;
      }
      showInSnackBar(message);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      showInSnackBar(e.message);
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
