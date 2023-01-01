import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vida/features/address/service/addressservice.dart';
import 'package:vida/features/esewaa/test2.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/widgets/bottom_bar.dart';
 
class Payment extends StatefulWidget {
  static const String routeName = '/payment';
  final String totalAmount;
  const Payment({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String addressToBeUsed = "";
  //List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  ESewaPnp? _esewaPnp;
  final ESewaConfiguration _configuration = ESewaConfiguration(
    clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );


  @override
  void initState() {
    super.initState();
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  double _amount = 0;
 
  
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
     int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primaryColor: Color.fromRGBO(65, 161, 36, 1),
      ),
      home: Scaffold(
        appBar:AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(
      context,
      BottomBar.routeName,
      
    )
        ),
        title: Text(
          'Esewa Payment',
        ),
      ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            <Widget>[
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
                            sum.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                   
              TextField(
                keyboardType: TextInputType.number,
                
             
               
                onChanged: (value) {
                  setState(() {
                    _amount = double.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Enter amount",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              /*Text(
                "Default",
                style: TextStyle(color: Colors.black45),
              ),*/
              ESewaPaymentButton(
                _esewaPnp!,
                amount: _amount,
                callBackURL: "https://example.com",
                productId: "abc123",
                productName: "Flutter SDK Example",
                onSuccess: (result) {
                  /*addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
      category: category,
    );*/          
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.message.toString())));
                },
                onFailure: (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message.toString())));
                },
              ),
              const Text('For testing purpose: '
              'eSewa ID: 9806800001/9806800002/9806800003/9806800004/9806800005'     'Password: Nepal@123')
             /* SizedBox(
                height: 84,
              ),
              Text(
                "With White or Custom color background",
                style: TextStyle(color: Colors.black45),
              ),
              ESewaPaymentButton(
                _esewaPnp!,
                amount: _amount,
                callBackURL: "https://example.com",
                productId: "abc123",
                productName: "Flutter SDK Example",
                onSuccess: (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.message.toString())));
                },
                onFailure: (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message.toString())));
                },
                color: Colors.green,
              ),
              SizedBox(
                height: 84,
              ),
              Text(
                "Label Builder",
                style: TextStyle(color: Colors.black45),
              ),
              ESewaPaymentButton(_esewaPnp!,
                  color: Colors.amber,
                  amount: _amount,
                  callBackURL: "https://example.com",
                  productId: "abc123",
                  productName: "Flutter SDK Example", onSuccess: (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.message.toString())));
              }, onFailure: (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message.toString())));
              }, labelBuilder: (double? amount, Widget? esewaLogo) {
                return Text("Pay Rs.$amount");
              }),*/
            ],
          ),
        ),
      ),
    );
  }
}