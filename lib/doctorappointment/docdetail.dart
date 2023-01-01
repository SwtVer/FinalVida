import 'dart:ui';

import 'package:vida/doctorappointment/models/doctor.dart';
import 'package:vida/theme.dart';
import 'package:vida/doctorappointment/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DoctorDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Doctor;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'images/${args.docPicture}',
                    ))),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  args.docName,
                  style: titleText,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    ' Speciality:${args.docSpeciality}                     '' Year of Experience:${args.docYearofexperience}',
                    style: Theme.of(context).textTheme.headline5    ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${args.docName}  ''${args.docdescription}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/appointmentform');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kPrimaryColor),
                    child: Text(
                      'Make an appointment',
                      style: textButton.copyWith(color: kWhiteColor),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
