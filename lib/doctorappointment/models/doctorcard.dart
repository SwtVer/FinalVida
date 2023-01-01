//import 'package:appointment/models/doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/doctorappointment/models/doctor.dart';

import 'package:vida/theme.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key, this.doctor}) : super(key: key);
  final Doctor? doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        color: Colors.grey[100],
        height: 80,
        width: MediaQuery.of(context).size.width - 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/${doctor!.docPicture}'),
                  )),
            ),
            SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor!.docName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: subTitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${doctor!.docSpeciality}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: subTitle,
                      ),
                      Text(
                        'Year of Experience:${doctor!.docYearofexperience}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:  TextStyle(fontSize: 15, color: kSecondaryColor, fontWeight:FontWeight.w500,),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 136,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${doctor!.docdescription}',
                              style: TextStyle(fontSize: 15, color: kSecondaryColor, fontWeight:FontWeight.w500,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
