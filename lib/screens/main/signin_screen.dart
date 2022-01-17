// ignore_for_file: unused_field, unused_local_variable, prefer_const_constructors, unused_import, prefer_final_fields, avoid_print

import 'dart:convert';

import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: true,
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.7,
                child: Image.asset(
                  "assets/logo1.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
                width: size.width * 0.65,
                child: Image.asset(
                  "assets/footprint_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Column(children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.8,
                  child: TextFormField(
                    // maxLength: 4,
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),
                      counterText: "",
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      hintText: "Username",
                    ),
                    controller: _usernameController,
                    onChanged: (value) {
                      _usernameController.value = TextEditingValue(
                          text: value, //.toUpperCase(),
                          selection: _usernameController.selection);
                    },
                    cursorColor: kPrimaryColor,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) {
                      email = val;
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    autofocus: true,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(color: Colors.red),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      hintText: 'Password',
                    ),
                    controller: _passwordController,
                    cursorColor: kPrimaryColor,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      password = val;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 5),
                      primary: kPrimaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29.0),
                      ),
                    ),
                    onPressed: () {
                      /*
                        if (isLoading) {
                          return;
                        }

                         */
                      if (_formKey.currentState!.validate()) {
                        login(
                            _usernameController.text, _passwordController.text);
                        setState(() {
                          isLoading = true;
                        });
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ])
            ]),
          )),
        ));
  }

  login(username, password) async {
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var headers = {"Authorization": basicAuth};

      var response = await http.post(Uri.parse(validateUser), headers: headers);

      setState(() {
        isLoading = false;
      });

      print(response.body);
       if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);

      if (json["ResponseStatus"] == "SUCCESS") {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainScreen(
                username: username,
                password: password,
              );
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid credentials !!")));
      }

      //  groupCode: json['group_code'],

         }
      /*  else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !!")));
        } */
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong !!")));
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
