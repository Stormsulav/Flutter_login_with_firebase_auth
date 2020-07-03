import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  // widgwt mai pass garnu parcha not in State
  // constructor banako or authenticate ko toggleView lai taneko yeta /define gareko
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false; // 

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
        title: Text("Register in Storm Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email",
                prefixIcon: Icon(Icons.email),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  ),
                validator: (val) =>
                  val.length < 6 ? 'Enter password of at least 6+ character' : null,
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
                child: Text("Register",
                 style: TextStyle(
                   color: Colors.white
                 ),
                 ),
                 onPressed: () async {
                   setState(() {
                     loading = true;
                   });
                   if (_formKey.currentState.validate()){
                     dynamic result = await _auth.registerWithEmailandPassword(email, password);
                     if(result == null){
                       setState(() {
                         error = " Please insert a valid email";
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