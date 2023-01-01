import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vida/features/admin/services/admin_service.dart';
import 'package:vida/features/subscription/screens/prescription.dart';
import 'package:vida/models/subscription.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/widgets/loader.dart';
import 'package:vida/widgets/oneproduct.dart';

class UserSubscription extends StatefulWidget {
  const UserSubscription({super.key});

  @override
  State<UserSubscription> createState() => _UserSubscriptionState();
}

class _UserSubscriptionState extends State<UserSubscription> {
  List<SubscriptionModel>? subscription;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    subscription = await adminServices.fetchAllSubscription(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return subscription == null
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFF1B3834),
              centerTitle: true,
              title: const Text('Subscriptions'),
            ),
            body: GridView.builder(
              itemCount: subscription!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final subscriptionData = subscription![index];
                
                return Column(
                  children: [
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PrescriptionScreen.routeName,
                            arguments: subscriptionData,
                          );
                        },
                        child: SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: subscriptionData.images[0],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                subscriptionData.category,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              )),
                              
                            ],
                          ),
                         
                                  /* Padding(
                                     padding: const EdgeInsets.only(right:100),
                                     child: SizedBox(
                                      height: 35,
                                       child: Text(
                                'User:${user.name}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                                     ),
                                   )*/
                          /*SizedBox(
                              height: 14,
                              child: Text('Quantity:${productData.quantity}')),*/
                        ],
                      ),
                    ),
                  ],
                );
              },
            ));
  }
}
