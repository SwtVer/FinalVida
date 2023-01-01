import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/admin/screen/add_product.dart';
import 'package:vida/features/admin/services/admin_service.dart';
import 'package:vida/features/admin/widgets/alert.dart';
import 'package:vida/features/admin/widgets/product_detail.dart';
import 'package:vida/features/product_detail/screens/productdetailScreen.dart';
import 'package:vida/features/search/screen/searchscreen.dart';
import 'package:vida/models/productmodel.dart';
import 'package:vida/widgets/loader.dart';
import 'package:vida/widgets/oneproduct.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

var refreshKey = GlobalKey<RefreshIndicatorState>();

Random random = new Random();
int limit = random.nextInt(10);

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetail.routeName,
      arguments: products,
    );
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          showSnackBar(context, ' Product has been deleted!');
          setState(() {});
        });
  }

  void navigatetoAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    fetchAllProducts();
    return products == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xFF1B3834),
                centerTitle: true,
                leading: Text("Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    )),
                /*new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),*/
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: EdgeInsets.symmetric(vertical: 30),
                        // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Material(
                          borderRadius: BorderRadius.circular(29.5),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 6,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 23,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(top: 10),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(29.5),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(29.5),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              hintText: 'Search ',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),*/
                  ],
                ),
              ),
            ),
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
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
                      height: 120,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: products,
                          );
                        },
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              )),
                              IconButton(
                                  icon:
                                      const Icon(Icons.delete_outline_outlined),
                                  onPressed: () => showAlertDialog(context)
                                  //deleteProduct(productData, index),

                                  ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: SizedBox(
                                height: 18,
                                child:
                                    Text('Quantity:${productData.quantity}')),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF1B3834),
              child: const Icon(
                Icons.add,
              ),
              onPressed: navigatetoAddProduct,
              tooltip: 'Add product',
            ));
  }
}
