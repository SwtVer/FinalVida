import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/address/screen/address_screen.dart';
import 'package:vida/features/cart/widget/cart_product.dart';
import 'package:vida/features/cart/widget/cart_subtotal.dart';
import 'package:vida/home/homescreen/address_box.dart';
import 'package:vida/home/homescreen/home.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/widgets/addressboxother.dart';
import 'package:vida/widgets/bottom_bar.dart';
import 'package:vida/widgets/custombutton.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  /*void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }*/

  void navigateToAddress(int sum) {
    print('sum$sum');
    int s = sum;
    print(s);
    if (sum != 0) {
      Navigator.pushNamed(
        context,
        AddressScreen.routeName,
        arguments: sum.toString(),
      );
    }
    else{
      showSnackBar(context, 'Empty Cart and Totalamount');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            text: 'Proceed to Buy (${user.cart.length} items)',
            onTap: () => navigateToAddress(sum),
            color: const Color(0xFF1B3834),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(
                  context,
                  BottomBar.routeName,
                )),
        title: Text(
          'Cart',
        ),
      ),
      /* PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
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
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBoxCart(),
            const CartSubtotal(),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
