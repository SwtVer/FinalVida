import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:vida/features/product_detail/services/productdetail_services.dart';
import 'package:vida/models/productmodel.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/widgets/bottom_bar.dart';
import 'package:vida/widgets/stars.dart';

class ProductDetail extends StatefulWidget {
  static const String routeName = '/admin-product-details';
  final Product product;
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductDetailServices productDetailServices =
   ProductDetailServices();
    double avgRating = 0;
    double myRating = 0;
   @override
    void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==//userid is matvhed with the rating given id
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }
  /*void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }*/
  void addToCart() {
    productDetailServices.addToCart(
      context: context,
      product: widget.product,
    );
    Navigator.pushNamed(
      context,
      BottomBar.routeName,
       
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: addToCart,
                icon: const Icon(
                  Icons.shopping_cart_checkout_rounded,
                  size: 40,
                )),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1B3834), shape: StadiumBorder()),
              ),
            )
          ],
        ),
      )),*/
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Product Details',
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.id!),
                IconButton(icon: Icon(Icons.share), onPressed: () {}),
              ],
            ),
          ),
          /*Padding(
              padding:const  EdgeInsets.symmetric(
                vertical: 20,
                horizontal:10 ),
                
                ),*/
          CarouselSlider(
            items: widget.product.images.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 300,
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(widget.product.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Price: ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'NPR${widget.product.price}',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stars(rating:avgRating,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description),
          ),
          /*Container(
            color: Colors.black12,
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Rate The Product',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RatingBar.builder(
            initialRating: myRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color.fromRGBO(255, 153, 0, 1),
            ),
            onRatingUpdate: (rating) {
              productDetailServices.rateProduct(
               context: context,
              product: widget.product,
              rating: rating,
               );
            },
          )*/
          /* Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                
                text: 'Buy Now',
                onTap: () {},
                color:const Color.fromARGB(255, 27, 56, 52)
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                
                text: 'Add to Cart',
                onTap: (){},//addToCart,
               color:const Color.fromARGB(255, 27, 56, 52),
              ),
            ),*/
        ],
      )),

      /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
               Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                  height: 45,
                  //color: Colors.black,
                ),
              ),
              Container(
                
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      //child: Icon(Icons.notifications_outlined),
                    ),
                    /*Icon(
                      Icons.search,
                    ),*/
                  ],
                ),*/
    );
  }
}