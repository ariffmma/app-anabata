import 'package:flutter/material.dart';
import 'package:blogapp/daftar/controller.dart';
import 'package:blogapp/daftar/model/form.dart';
import 'package:blogapp/daftar/Media.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController domicileController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          emailController.text,
          nomorController.text,
          professionController.text,
          ageController.text,
          domicileController.text);

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          //
          _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("Error Occurred!");
        }
      });

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheet
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Media(),
      ));
      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(0),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Ionicons.ios_arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Register Open Talk e-Series 7.3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Full Name"),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: nomorController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Mobile phone";
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(labelText: "Mobile phone"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: professionController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Company/university";
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(labelText: "Company/university"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: ageController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid age";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // isDense: true,
                              hintText: 'dd/MM/yyyy'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9/]")),
                            LengthLimitingTextInputFormatter(10),
                            _DateFormatter(),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: domicileController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Domicile";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Domicile"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: _submitForm,
                          child: Text('Submit Registration'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
