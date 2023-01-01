import 'package:vida/doctorappointment/docdetail.dart';
import 'package:vida/doctorappointment/models/doctorcard.dart';
import 'package:vida/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'models/doctor.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: topDoctors.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/doctor_details',
                arguments:Doctor(
                  docName: topDoctors[index].docName,
                  docYearofexperience: topDoctors[index].docYearofexperience,
                  docPicture: topDoctors[index].docPicture,
                  docSpeciality: topDoctors[index].docSpeciality,
                  docdescription: topDoctors[index].docdescription,
                ) );
                //MaterialPageRoute(
                // builder: (BuildContext context) => DoctorDetailPage()),
                //);
              },
              child: DoctorCard(
                doctor: topDoctors[index],
              ));
        }));
  }
}
