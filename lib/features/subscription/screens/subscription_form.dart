import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/subscription/services/subscription_services.dart';
import 'package:vida/models/subscription.dart';

import 'package:vida/provider/userprovider.dart';
import 'package:vida/widgets/customTextField.dart';
import 'package:vida/widgets/custombutton.dart';

class SubscriptionForm extends StatefulWidget {
  //final SubscriptionModel subscriptionModel;
  static const String routeName = '/add-subscription';
  const SubscriptionForm({
    Key? key,
   // required this.subscriptionModel,
  }) : super(key: key);

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  final TextEditingController descriptionController = TextEditingController();
  String category = 'One(1)-Month';
  List<File> images = [];
  final _subscriptionFormKey = GlobalKey<FormState>();
  final SubcriptionServices subcriptionServices = SubcriptionServices();

  List<String> categories = [
    'One(1)-Month',
    'Two(2)-Month',
    'Three(3)-Month',
  ];
  @override
  void dispose() {
    super.dispose();

    descriptionController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  String idToBeUsed = "";
  String dateToBeUsed = "";

  void addsubscription(String userIdFromProvider, String date) {
    idToBeUsed = "";
    dateToBeUsed = "";
    if (userIdFromProvider.isNotEmpty && date.isNotEmpty) {
      idToBeUsed = userIdFromProvider;
      dateToBeUsed = date;
    } else {
      showSnackBar(context, 'ERROR');
    }
    if (_subscriptionFormKey.currentState!.validate() && images.isNotEmpty) {
      subcriptionServices.addsubscription(
        description: descriptionController.text,
        context: context,
        category: category,
        images: images,
        userId: idToBeUsed,
        orderedAt: dateToBeUsed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();

    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String formattedDate = formatter.format(now);

    var userId = context.watch<UserProvider>().user.id;
   // var subid = widget.subscriptionModel.userId;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Add Subscription',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userId,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Form(
                key: _subscriptionFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      images.isNotEmpty
                          ? CarouselSlider(
                              items: images.map(
                                (i) {
                                  return Builder(
                                    builder: (BuildContext context) =>
                                        Image.file(
                                      i,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                  );
                                },
                              ).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                            )
                          : GestureDetector(
                              onTap: selectImages,
                              child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_open_rounded,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Upload Prescription',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                      SizedBox(
                        height: 40,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: ' Disease Description',
                        maxLines: 7,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        //width: double.infinity,
                        child: DropdownButton(
                          value: category,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: categories.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 180,
                        padding: EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text('ADD'),
                          onPressed: () =>
                              addsubscription(userId, formattedDate),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            minimumSize: const Size(double.infinity, 50),
                            primary: Color(0xFF1B3834),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}



/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/subscription/services/subscription_services.dart';

class SubscriptionForm extends StatefulWidget {
  static const String routeName = '/add-subscription';
  const SubscriptionForm({super.key});

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
    //final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  //final TextEditingController priceController = TextEditingController();
  //final TextEditingController quantityController = TextEditingController();
  //final SubscriptionServices subscriptionServices = SubscriptionServices();
  String category = 'ONE(1) MONTH';
  List<File> images = [];
  final _addSubscriptionFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    //productNameController.dispose();
    descriptionController.dispose();
    //priceController.dispose();
    //quantityController.dispose();
  }

  List<String> subscriptionCategories = [
    'ONE(1) MONTH',
    ' THREE(3) MONTH',
    'SIX(6) MONTH',
    //'OTC'
  ];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  /*void subscribe() {
    if (_addSubscriptionFormKey.currentState!.validate() && images.isNotEmpty) {
      SubcriptionServices.addsubscription(
          context: context,
          //name: productNameController.text,
          description: descriptionController.text,
         // price: double.parse(priceController.text),
         // quantity: double.parse(quantityController.text),
          category: category,
          images: images
          );
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }*/
  
