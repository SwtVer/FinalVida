import 'package:flutter/material.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/admin/services/admin_service.dart';
import 'package:vida/features/order_detail/oder_detail_screen.dart';
import 'package:vida/models/order.dart';
import 'package:vida/widgets/loader.dart';
import 'package:vida/widgets/oneproduct.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }
  void deleteProduct(Order product, int index) {
        AdminServices.deleteOrder(
        context: context,
        product: product,
        onSuccess: () {
          
          orders!.removeAt(index);
          showSnackBar(context, ' Order has been deleted!');
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor:  Color(0xFF1B3834),
            centerTitle: true,
            title:const  Text(
              'Orders'
            ),
          ),
            body: GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              showAlertDialog(
                  BuildContext context,
                ) {
                  // set up the buttons
                  Widget cancelButton = TextButton(
                    child: Text("Delete"),
                    onPressed: () {
                      deleteProduct(orderData, index);
                      Navigator.of(context).pop();
                    },
                  );
                  Widget continueButton = TextButton(
                    child: Text("Cancel"),
                    onPressed: () {Navigator.of(context).pop();},
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("AlertDialog"),
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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orderData,
                        );
                      },
                      child: SizedBox(
                        height: 120,
                        child: SingleProduct(
                          image: orderData.products[0].images[0],
                        ),
                      ),
                    ),
                  ),
                   Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            
                               Expanded(
                                  child: Text(
                                orderData.products[0].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              )),
                            
                            IconButton(
                              onPressed: () => showAlertDialog(context),
                              icon: const Icon(Icons.delete_outline_outlined),
                            ),
                          ],
                        ),
                      ),

                ],
              );
            },
          ));
  }
}
