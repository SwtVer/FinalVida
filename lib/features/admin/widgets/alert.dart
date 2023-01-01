import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vida/models/productmodel.dart';

showAlertDialog(
 
  BuildContext context,
  

  ) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Delete"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Are you sure you want to delete?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
