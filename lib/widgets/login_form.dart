import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:vida/theme.dart';

class LogInForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  //final int maxLines;
  const LogInForm({Key? key, 
  required this.controller, 
  required this.hintText,
  //required this.maxLines=1,
  })
      : super(key: key);
  //bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: controller,
          //obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hintText,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter your $hintText';
            }
            return null;
          },
        )
        //maxLines: maxLines,
        );
  }
}

addValidator() {
  validator:
  (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  };
}
/*suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },*/