//import 'package:esewa_client/esewa_client.dart';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/Esewa/screen/esewa.dart';

import 'package:vida/features/address/service/addressservice.dart';
import 'package:vida/features/esewaa/esewaa.dart';
import 'package:vida/features/esewaa/test2.dart';
import 'package:vida/features/khalti/khalti.dart';
import 'package:vida/models/productmodel.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';
import 'package:vida/widgets/custombutton.dart';
import 'package:vida/widgets/login_form.dart';
import 'package:esewa_pnp/esewa_pnp.dart';

class AddressScreen extends StatefulWidget {
  
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}



class _AddressScreenState extends State<AddressScreen> {
  ESewaPnp? _esewaPnp;
  final ESewaConfiguration _configuration = ESewaConfiguration(
    clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );
  String category = 'COD';
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  List<String> categories = [
    'COD',
    'Esewa',
  ];
  List<File> images = [];

  String addressToBeUsed = "";
  //List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  @override
  void initState() {
    super.initState();
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }
  /*void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }*/

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

 /* void onGooglePayResult() {
    //final user = Provider.of<UserProvider>(context,listen: false).user.address;
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    /*addressServices.placeOrder(
      context: context,
      address: user,
      totalSum: double.parse(widget.totalAmount),
    );*/
  }*/
  //String idToBeUsed = "";

  void payPressed(String addressFromProvider) {
    //final user = Provider.of<UserProvider>(context, listen: false).user.address;
    addressToBeUsed = "";
    //idToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount),
        category: category,
        images: images);

    print(addressToBeUsed);
  }

  void navigatePay(sum) {
    Navigator.pushNamed(
      context,
      Payment.routeName,
      arguments: sum.toString(),
    );
    //addressServices.placeOrder(
    //context: context,
    //address: addressToBeUsed,
    //totalSum: double.parse(widget.totalAmount),
    //);
  }

  void placeorder() {
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount),
        category: category,
        images: images);
  }

  void navigateToPay(int sum) {
    Navigator.pushNamed(
      context,
      EsewaEpay.routeName,
      //arguments: sum.toString(),
    );
  }

  void navigateToKhalti(int sum) {
    Navigator.pushNamed(
      context,
      EsewaEpay.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    var userId = context.watch<UserProvider>().user.id;
    var address = context.watch<UserProvider>().user.address;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*ESewaPaymentButton(
                _esewaPnp!,
                amount: sum.toDouble(),
                callBackURL: "https://example.com",
                productId: "abc123",
                productName: "Flutter SDK Example",
                onSuccess: (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.message.toString())));
                  placeorder();
                },
                onFailure: (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message.toString())));
                },
                color: Colors.green,
              ),*/
              /*Container(
                height: 50,
                width: 200,
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(' Payments'),
                  onPressed: () => navigatePay(
                      sum), //navigateToKhalti(sum),//Payment(), //navigateToKhalti(sum),//KhaltiPaymentPage(), //navigateToKhalti(sum),// _payViaEsewa(),//khaltiScreen(context),
                  //payPressed(address),
                  // onLongPress: () => navigateToKhalti(), //onGooglePayResult(),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(double.infinity, 50),
                    primary: Color(0xFF1B3834),
                  ),
                ),
              ),*/
              Container(
                height: 50,
                width: 180,
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Place order'),
                  onPressed: () => payPressed(address), //onGooglePayResult(),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(double.infinity, 50),
                    primary: Color(0xFF1B3834),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF1B3834),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  userId,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
                if (address.isNotEmpty)
                  Column(
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
                            address,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      
                      
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
              'Upload Prescription Needed Only For Homeopathy And Allopathy  Medicines',
              style:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor),
            ),
            SizedBox(
              height: 10,
            ),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      height: 20,
                    ),
                   
                      const Text(
                        'Add New Delivery Address',
                        style: TextStyle(
                          fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor
                        ),
                      ),
                    LogInForm(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    LogInForm(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    LogInForm(
                        controller: pincodeController, hintText: 'Pincode'),
                    const SizedBox(height: 10),
                    LogInForm(
                      controller: cityController,
                      hintText: 'Town/City',
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
                    ESewaPaymentButton(
                      _esewaPnp!,
                      amount: sum.toDouble(),
                      callBackURL: "https://example.com",
                      productId: "abc123",
                      productName: "Flutter SDK Example",
                      onSuccess: (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.message.toString())));
                        placeorder();
                      },
                      onFailure: (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message.toString())));
                      },
                      labelBuilder: (double? amount, Widget? esewaLogo) {
                        return Text("Pay now with Esewa Rs.$amount");
                      },
                    ),
                    const Text('For testing purpose: '
                        'eSewa ID: 9806800001/9806800002/9806800003/9806800004/9806800005'
                        'Password: Nepal@123')

                    /*ApplePayButton(
                      width: double.infinity,
                      style: ApplePayButtonStyle.whiteOutline,
                      type: ApplePayButtonType.buy,
                      paymentConfigurationAsset: 'applepay.json',
                      onPaymentResult: onApplePayResult,
                      paymentItems: paymentItems,
                      margin: const EdgeInsets.only(top: 15),
                      height: 50,
                      onPressed: () => payPressed(address),
                    ),
                    const SizedBox(height: 10),
                    GooglePayButton(
                      onPressed: () => payPressed(address),
                      paymentConfigurationAsset: 'gpay.json',
                      onPaymentResult: onGooglePayResult,
                      paymentItems: paymentItems,
                      height: 50,
                      //style: GooglePayButtonStyle.black,
                      type: GooglePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15),
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )*/
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
  /* _payViaEsewa() async {
    // change credentials during production
    EsewaClient _esewaClient = EsewaClient.configure(
      clientId: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
      secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
      environment: EsewaEnvironment.TEST,
    );

    /*
    * Enter your own callback url to receive response callback from esewa to your client server
    * */
    EsewaPayment payment = EsewaPayment(
        productId: "test_id",
        amount: "100",
        name: "Test Product",
        callbackUrl:
        "http://google.com/");

    _esewaClient.startPayment(
        esewaPayment: payment,
        onSuccess: (data) {
          showSnackBar(context, 'success');
        },
        onFailure: (data) {
          showSnackBar(context, 'success');
          //print("failure");
        },
        onCancelled: (data) {
          showSnackBar(context, 'success');
          //print("cancelled");
        });
  }*/
}
