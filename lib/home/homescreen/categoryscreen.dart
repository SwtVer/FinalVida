import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/features/product_detail/screens/productdetailScreen.dart';
//import 'package:vida/home/homescreen/productdatailscreen.dart';
import 'package:vida/home/services_api/homeservices.dart';
import 'package:vida/models/productmodel.dart';
import 'package:vida/widgets/loader.dart';
import 'package:vida/widgets/oneproduct.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF1B3834),
          centerTitle: true,
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: productList == null
          ? const Loader()
          : Column(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  'Shop More ${widget.category} Products',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 170,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    //childAspectRatio: 1.9,
                    //mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailScreen.routeName,
                    arguments: product,
                  );
                },
                child:
                        Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: 
                               Image.network(
                                product.images[0],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 30,
                            top: 5,
                            right: 15,
                          ),
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ));
                  },
                ),
              ),
            ]),
    );

    /* Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,vertical: 10
                ),
                alignment:Alignment.topLeft ,
                child: Text('keep shopping for ${widget.category}',
                style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),),
              )*/
  }
}
