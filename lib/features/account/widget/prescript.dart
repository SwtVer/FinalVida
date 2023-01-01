import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/subscription/screens/prescription.dart';
import 'package:vida/features/subscription/services/subscription_services.dart';
import 'package:vida/models/subscription.dart';
import 'package:vida/widgets/loader.dart';
import 'package:vida/widgets/oneproduct.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  List<SubscriptionModel>? orders;
  final SubcriptionServices subcriptionServices = SubcriptionServices();
  @override
  void initState() {
    super.initState();
    fetchMySubscription();
  }

  void fetchMySubscription() async {
    orders = await subcriptionServices.fetchMySubscription(context: context);
    setState(() {});
  }

  void deleteProduct(SubscriptionModel product, int index) {
    subcriptionServices.deleteSubscription(
        context: context,
        product: product,
        onSuccess: () {
          orders!.removeAt(index);
          showSnackBar(context, 'Your subscription has been deleted!');
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    fetchMySubscription();
    return orders == null
        ? const Loader()
        : Column(
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
                child: GridView.builder(
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
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
                          height: 139,
                          child: GestureDetector(
                            child: SingleProduct(
                              image: productData.images[0],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PrescriptionScreen.routeName,
                                arguments: orders![index],
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: Text(
                              productData.category,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            )),
                            IconButton(
                              onPressed: () => showAlertDialog(
                                  context), //deleteProduct(productData, index),
                              icon: const Icon(Icons.delete_outline_outlined),
                            ),
                          ],
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
              ),
            ],
          );
  }
}
