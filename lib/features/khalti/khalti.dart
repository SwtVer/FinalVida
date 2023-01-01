/*import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiPaymentPage extends StatefulWidget {
  const KhaltiPaymentPage({Key? key}) : super(key: key);

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();

  getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalti Payment Integration'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            // For Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Enter Amount to pay",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            // For Button
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.red)),
                height: 50,
                color: const Color(0xFF56328c),
                child: const Text(
                  'Pay With Khalti',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  KhaltiScope.of(context).pay(
                    config: PaymentConfig(
                      amount: getAmt(),
                      productIdentity: 'dells-sssssg5-g5510-2021',
                      productName: 'Product Name',
                    ),
                    preferences: [
                      PaymentPreference.khalti,
                    ],
                    onSuccess: (su) {
                      const successsnackBar = SnackBar(
                        content: Text('Payment Successful'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(successsnackBar);
                    },
                    onFailure: (fa) {
                      const failedsnackBar = SnackBar(
                        content: Text('Payment Failed'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(failedsnackBar);
                    },
                    onCancel: () {
                      const cancelsnackBar = SnackBar(
                        content: Text('Payment Cancelled'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(cancelsnackBar);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/widgets/bottom_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

khaltiScreen(BuildContext context){
  FlutterKhalti _flutterKhalti=FlutterKhalti.configure(
    publicKey: "test_public_key_c0d46175613447ff8a45047ed868b3a4", 
    urlSchemeIOS: "Integrating Khalti");
    KhaltiProduct product=KhaltiProduct(
      id: "Integrating Khalti to my flutter app",
      amount: 100000,
      name: "Payment for item",
    );
    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data)async {
         try {
          //showSnackBar(context, 'Your payment has been done!');
            Fluttertoast.showToast(msg: "Success",timeInSecForIosWeb:25 );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomBar()));
          }catch (e) {
            Fluttertoast.showToast(msg: e.toString(),timeInSecForIosWeb:25 );
          }
      },
      onFaliure: (error){
        Fluttertoast.showToast(msg: "Error",timeInSecForIosWeb:25 );
      }
    );
}*/