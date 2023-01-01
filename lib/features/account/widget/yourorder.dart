import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/account/services/account_service.dart';
import 'package:vida/features/order_detail/oder_detail_screen.dart';
import 'package:vida/models/order.dart';
import 'package:vida/widgets/oneproduct.dart';

class YourOrder extends StatefulWidget {
  static const String routeName = '/your-order';
  const YourOrder({super.key});

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  void deleteProduct(Order product, int index) {
    AccountServices.deleteSubscription(
        context: context,
        product: product,
        onSuccess: () {
          orders!.removeAt(index);
          showSnackBar(context, 'Your order has been deleted!');
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    fetchOrders();
    return orders == null
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xFF1B3834),
                centerTitle: true,
                title: const Text('Your Orders')),
            body: /* Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        'Your Subscription',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                   
                  ],
                ),
                // display orders
                Container(
                  height: 250,
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 0,
                  ),
                  child:*/
                GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = orders![index];
                showAlertDialog(
                  BuildContext context,
                ) {
                  // set up the buttons
                  Widget cancelButton = TextButton(
                    child: Text("Delete"),
                    onPressed: () {
                      deleteProduct(productData, index);
                      Navigator.of(context).pop();
                    },
                  );
                  Widget continueButton = TextButton(
                    child: Text("Cancel"),
                    onPressed: () {Navigator.of(context).pop();},
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Delete?"),
                    content: Text("Are you sure you want to delete?"),
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
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: GestureDetector(
                        child: SingleProduct(
                          image: productData.products[0].images[0],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailScreen.routeName,
                            arguments: orders![index],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Text(
                            productData.products[0].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          )),
                          IconButton(
                            onPressed: () =>showAlertDialog(context),//deleteProduct(productData, index),
                            icon: const Icon(Icons.delete_outline_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            /* ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      final productData = orders![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                           context,
                          PrescriptionScreen.routeName,
                          arguments: orders![index]
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 140,
                              child: SingleProduct(
                                image: productData.images[0],
                              ),
                            ),
                           
                            
                            
                        
                      
                            
                          ],
                        ),
                      );
                    },
                  ),*/
          );
  }
}
