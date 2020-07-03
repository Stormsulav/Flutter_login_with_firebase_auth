import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  // constructor banako or authenticate ko toggleView lai taneko yeta /define gareko
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false; // for loading widget

  // text field state
  String email ='';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 2.0,
        title: Text("Sign in to Storm Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical:100.0, horizontal: 40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) =>
                  val.isEmpty ? 'Enter an email' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) =>
                  val.length < 6 ? 'Enter password of at least 6+ character' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
              
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                  },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[500],
                child: Text("Sign in",
                 style: TextStyle(
                   color: Colors.white
                 ),
                 ),
                 onPressed: () async {
                   setState(() {
                     loading = true;
                   });
                   if (_formKey.currentState.validate()){
                     dynamic result = await _auth.signInWithEmailandPassword(email, password);
                     if(result == null){
                       setState(() {
                         error = "Cannot sign in with that account";
                         loading = false;
                       });
                     }
                   }
                 },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red, fontSize:14.0
                ),
              ),
              ],
          ),
          )
        ),
    );
  }
}