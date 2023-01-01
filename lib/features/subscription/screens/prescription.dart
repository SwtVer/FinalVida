import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:vida/features/subscription/screens/subscription%20_option%20.dart';
import 'package:vida/features/subscription/services/subscription_services.dart';
import 'package:vida/models/subscription.dart';
import 'package:vida/models/user.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';
import 'package:vida/widgets/loader.dart';
import 'package:vida/widgets/oneproduct.dart';

class PrescriptionScreen extends StatefulWidget {
  static const String routeName = '/subscription-details';

  final SubscriptionModel subscriptionModel;
  const PrescriptionScreen({
    Key? key,
    required this.subscriptionModel,
  }) : super(key: key);

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  List<SubscriptionModel>? subscriptionModel;
  final SubcriptionServices subcriptionServices = SubcriptionServices();

  @override
  void initState() {
    super.initState();
    fetchMySubscription();
  }

  fetchMySubscription() async {
    subscriptionModel =
        await subcriptionServices.fetchMySubscription(context: context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    fetchMySubscription();
    var date = widget.subscriptionModel.orderedAt;
    var subcategory = widget.subscriptionModel.category;
    
    
    DateTime dt1 = DateTime.parse(date);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF1B3834),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Subscription Detail',
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View Subscription details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                          'Subscription ID:   ${widget.subscriptionModel.id}'),
                      Text(
                          'Orderd At:             ${widget.subscriptionModel.orderedAt}'),
                      Text(
                          'User ID:                 ${widget.subscriptionModel.userId}'),
                      Text('Address:               ${user.address}'),
                      //Text('User Name:          ${user.name}'),
                      if (subcategory == 'One(1)-Month') ...[
                        
                        Text("Delivery On: " +'         '+   
                        DateTime(dt1.year , dt1.month + 1, dt1.day-1).toString())
                            
                            //dt1.add(Duration(months: 1)).toString()
                            
                      ],
                      if (subcategory == 'Two(2)-Month') ...[
                        
                        Text("Delivery On: " +'                  '+   
                        DateTime(dt1.year , dt1.month + 2, dt1.day-1).toString())
                            
                            //dt1.add(Duration(months: 1)).toString()
                            
                      ],
                      if (subcategory == 'Three(3)-Month') ...[
                        
                        Text("Delivery On: " +'                  '+   
                        DateTime(dt1.year , dt1.month + 3, dt1.day-1).toString())
                            
                            //dt1.add(Duration(months: 1)).toString()
                            
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Subscription Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CarouselSlider(
                  items: widget.subscriptionModel.images.map(
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
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Text(
                    widget.subscriptionModel.category,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                /*const SizedBox(height: 10),
                const Text(
                  'Purchase Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //for (int i = 0; i < widget.subscriptionModel.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.subscriptionModel.images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.subscriptionModel.category,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                          
                             
                          
                        ],
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ));
  }
}
