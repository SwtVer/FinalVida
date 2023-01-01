import 'package:vida/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
//import 'package:vida/doctorappointment/docdetail';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:searchfield/searchfield.dart';

import 'doctorslist.dart';
import 'homescreennavbar.dart';

class Appointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppointmentState();
}

class AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return doctors();
  }

  Widget doctors() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              const HomeScreenNavbar(),
              SizedBox(
                height: 24,
              ),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    "Book Your Doctor's Appointment",
                    style: titleText,
                  ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                   Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            maxLines: 1,
                            autofocus: false,
                            style: TextStyle(
                                color: Color(0xff107163), fontSize: 20),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search..',
                            ),
                            cursorColor: kBlackColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            //color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              color: kPrimaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                    
                  ),
                  SizedBox(
                   height: 24,
                  ),
                  Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text('Doctors',
                    style: textButton)
                  ],  
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  const DoctorsList()


            ]
            
                ),
                  
        ),
          ),
        ),
        
        
        
        
        
        /*appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          centerTitle: true,
          leading: Icon(
            Icons.arrow_back_outlined,
            color: kPrimaryColor,
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    "Book Your Doctor's Appointment",
                    style: titleText,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x14000000),
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            maxLines: 1,
                            autofocus: false,
                            style: TextStyle(
                                color: Color(0xff107163), fontSize: 20),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search..',
                            ),
                            cursorColor: kBlackColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: ListView(
                      children: [
                        docs(
                          "images/dr_1.png",
                          "Dr. ABC",
                          "Generel Physician",
                          "",
                        ),
                        docs(
                          "images/dr_1.png",
                          "Dr. XYZ",
                          "Opthalmologist",
                          "",
                        ),
                        docs(
                          "images/dr_1.png",
                          "Dr. PQR",
                          "GastroIntestine Surgeon",
                          "",
                        ),
                        docs("images/dr_1.png", "Dr. IJK", "Cardiologist", ""),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  Widget docs(String img, String name, String speciality, String distance) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/docdetail.dart', arguments: docs(
            img, name, speciality, distance)

            );

        //Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailPage()) );
      },
      child: Container(
        height: 90,
        // width: size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Image.asset(img),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: subTitle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          speciality,
                          style: subTitle,
                        ),
                        /*Container(
                          margin: EdgeInsets.only(top: 3, left: size.width * 0.25),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  speciality,
                                  style:subTitle,
                                ),
                              ),
                              Container(
                                child: Text(
                                  speciality,
                                  style:subTitle,
                                ),
                              )
                            ],
                          ),
                        )*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}














/*class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
           
          backgroundColor:Colors.white,
          leading: IconButton( 
    onPressed: (){
        
    },
    icon: Icon(Icons.arrow_back_outlined, color: kPrimaryColor,
          )
      )
      )*/
        
  