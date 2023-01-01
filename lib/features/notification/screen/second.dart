import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/theme.dart';

class Second extends StatefulWidget {
  final String? payload;
   const Second({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/logo.png',
                width: 50,
                height: 45,
                //color: Colors.black,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    //child: Icon(Icons.notifications_outlined),
                  ),
                  /*Icon(
                      Icons.search,
                    ),*/
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              widget. payload ?? '',
              style: titleText,
            ),
          ],
        ),
      )
    );
  }
}
/*class MyWidget extends StatelessWidget {
  final String? payload;
  const MyWidget({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
               payload ?? '',
            ),
          ],
        ),
      )
    );
  }
}*/
