import 'dart:async';

import 'package:blogapp/chat/data/models/custom_error.dart';
import 'package:blogapp/chat/data/models/user.dart';
import 'package:blogapp/chat/data/repositories/register_repository.dart';
import 'package:blogapp/chat/screens/home/home_view.dart';
import 'package:blogapp/chat/utils/custom_shared_preferences.dart';
import 'package:blogapp/chat/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterController extends StateControl {
  final BuildContext context;

  RegisterRepository _registerRepository = RegisterRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController domicileController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  RegisterController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    this.nameController.addListener(this.validateForm);
    this.usernameController.addListener(this.validateForm);
    this.passwordController.addListener(this.validateForm);
    this.companyController.addListener(this.validateForm);
    this.emailController.addListener(this.validateForm);
    this.phoneController.addListener(this.validateForm);
    this.ageController.addListener(this.validateForm);
    this.domicileController.addListener(this.validateForm);
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String name = this.nameController.value.text;
    String username = this.usernameController.value.text;
    String password = this.passwordController.value.text;
    String company = this.companyController.value.text;
    String email = this.emailController.value.text;
    String phone = this.phoneController.value.text;
    String age = this.ageController.value.text;
    String domicile = this.domicileController.value.text;
    if (name.trim() == "" ||
        username.trim() == "" ||
        password.trim() == "" ||
        company.trim() == "" ||
        email.trim() == "" ||
        phone.trim() == "" ||
        age.trim() == "" ||
        domicile.trim() == "") {
      isFormValid = false;
    } else {
      isFormValid = true;
    }
    _isFormValid = isFormValid;
    notifyListeners();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String name = this.nameController.value.text;
    String username = this.usernameController.value.text;
    String password = this.passwordController.value.text;
    String company = this.companyController.value.text;
    String email = this.emailController.value.text;
    String phone = this.phoneController.value.text;
    String age = this.ageController.value.text;
    String domicile = this.domicileController.value.text;
    var loginResponse = await _registerRepository.register(
        name, username, password, company, email, phone, age, domicile);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else if (loginResponse is User) {
      await CustomSharedPreferences.setString('user', loginResponse.toString());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (_) => false);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  showAlertDialog(String message) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    companyController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
    domicileController.dispose();
  }
}
