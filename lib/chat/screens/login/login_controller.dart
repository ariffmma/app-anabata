import 'dart:async';

import 'package:blogapp/chat/data/models/custom_error.dart';
import 'package:blogapp/chat/data/models/user.dart';
import 'package:blogapp/chat/data/repositories/login_repository.dart';
import 'package:blogapp/chat/screens/home/home_view.dart';
import 'package:blogapp/chat/utils/custom_shared_preferences.dart';
import 'package:blogapp/chat/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/Pages/HomePage.dart';

class LoginController extends StateControl {
  LoginRepository _loginRepository = LoginRepository();

  final BuildContext context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  LoginController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    this.usernameController.addListener(this.validateForm);
    this.passwordController.addListener(this.validateForm);
  }

  @override
  void dispose() {
    super.dispose();
    this.usernameController.dispose();
    this.passwordController.dispose();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String username = this.usernameController.value.text;
    String password = this.passwordController.value.text;
    var loginResponse = await _loginRepository.login(username, password);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else if (loginResponse is User) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String username = this.usernameController.value.text;
    String password = this.passwordController.value.text;
    if (username.trim() == "" || password.trim() == "") {
      isFormValid = false;
    } else {
      isFormValid = true;
    }
    _isFormValid = isFormValid;
    notifyListeners();
  }

  showAlertDialog(String message) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Check for errors"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
