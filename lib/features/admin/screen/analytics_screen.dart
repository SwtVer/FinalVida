import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:vida/features/admin/models/sales.dart';
import 'package:vida/features/admin/models/sub.dart';
import 'package:vida/features/admin/screen/user_detail.dart';
import 'package:vida/features/admin/services/admin_service.dart';
import 'package:vida/features/admin/widgets/deal_of_the-day.dart';
import 'package:vida/features/admin/widgets/category_earning.dart';
import 'package:vida/features/admin/widgets/pie.dart';
import 'package:vida/features/admin/widgets/sub_type.dart';
import 'package:vida/widgets/loader.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? userCount;
  int? productCount;
  int? orderCount;
  int? subscriptionCount;
  int? oneMonth;
  int? twoMonth;
  int? threeMonth;
  int? totalSales;

  List<Sales>? earnings;
  List<Sub>? sub;

  @override
  void initState() {
    super.initState();
    getCollection();
    getEarnings();
    getSubscription();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  getSubscription() async {
   var collectionData = await adminServices.getSubscription(context);
    oneMonth = collectionData['oneMonth'];
    twoMonth = collectionData['twoMonth'];
    threeMonth = collectionData['threeMonth'];
    setState(() {});
  }

  getCollection() async {
    var collectionData = await adminServices.getCollection(context);
    userCount = collectionData['userCount'];
    productCount = collectionData['productCount'];
    orderCount = collectionData['orderCount'];
    subscriptionCount = collectionData['subscriptionCount'];

    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return earnings == null ||
            totalSales == null ||
            userCount == null ||
            productCount == null ||
            orderCount == null ||
            subscriptionCount == null||
            oneMonth == null ||
            twoMonth == null ||
            threeMonth == null 
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFF1B3834),
              centerTitle: true,
              title: Text(
                'Analytics',
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const DealOfDay(),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetail()));
                    }),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: const Text(
                            'Total Number of Users',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Center(
                                child: Text(
                                  '$userCount',
                                  style: const TextStyle(
                                    fontSize: 85,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: const Text(
                          'Total Number of Products',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                '$productCount',
                                style: const TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: const Text(
                          'Total Number of Orders',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                '$orderCount',
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: const Text(
                          'Total Number of Subscriptions',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                '$subscriptionCount',
                                style: const TextStyle(
                                  fontSize: 85,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\One-Month:$oneMonth',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\Two-Month:$twoMonth',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\Three-Month:$threeMonth',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  
                  PieChartSample2(),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: const Text(
                          'Total Earnings',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                '\NPR.$totalSales',
                                style: const TextStyle(
                                  fontSize: 85,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*Text(
                    '\NPR.$totalSales',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  SizedBox(
                    height: 250,
                    child: CategoryProductsChart(seriesList: [
                      charts.Series(
                        id: 'Sales',
                        data: earnings!,
                        domainFn: (Sales sales, _) => sales.label,
                        measureFn: (Sales sales, _) => sales.earning,
                      ),
                    ]),
                  ),
                  
                  /*SizedBox(
                    height: 250,
                    child: CategoryProducts(seriesList: [
                      charts.Series(
                        id: 'Sub',
                        data: sub!,
                        domainFn: (Sub sales, _) => sales.label,
                        measureFn: (Sub sales, _) => sales.earning,
                        labelAccessorFn: (Sub row, _) =>
                            '${row.label}: ${row.earning}',
                      ),
                    ]),
                  )*/
                ],
              ),
            ));
  }
}
