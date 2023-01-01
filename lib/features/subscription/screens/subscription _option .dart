import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vida/constants/globalVariable.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/features/notification/screen/notification_api.dart';
import 'package:vida/features/notification/screen/notification_service.dart';
import 'package:vida/features/notification/screen/second.dart';
import 'package:vida/features/subscription/screens/subscription_form.dart';
import 'package:vida/features/subscription/services/subscription_services.dart';
import 'package:vida/home/homescreen/home.dart';
import 'package:vida/models/subscription.dart';
import 'package:vida/provider/subscriptionprovider.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';
import 'package:vida/widgets/bottom_bar.dart';
import 'package:vida/widgets/custombutton.dart';

class Subscription extends StatefulWidget {
  static const String routeName = '/subscription-form';
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<SubscriptionModel>? subscriptionModel;
  final SubcriptionServices subcriptionServices = SubcriptionServices();

  late final NotificationsServices notificationsServices =
      NotificationsServices();
  /*@override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotifications();
  }*/

  @override
  void initState() {
    NotificationApi.init(initScheduled: true);
    listenNotifications();
    fetchMySubscription();
    super.initState();
  }

  void alert() {
    Text('notification done');
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Second(
                payload: payload,
              ) /* MyWidget(payload: payload)*/
          ));
    }
  }

  fetchMySubscription() async {
    subscriptionModel =
        await subcriptionServices.fetchMySubscription(context: context);

    setState(() {});
  }

  var days = 0;

  @override
  Widget build(BuildContext context) {
    var buttonText = 'Schedule Notification';
    //var subuserId = context.watch<SubscriptionProvider>().user.userId;
    var userId = context.watch<UserProvider>().user.id;

    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF1B3834),
          centerTitle: true,
          title: Text(
            'Subscription',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushNamed(
                    context,
                    BottomBar.routeName,
                  ))),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            /* Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userId,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),*/

            Text(
              'Want your medicines to be delivered on your doorstep so that you do not miss your daily miss your daily dose of vital medicines?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Check our Subscriptions plan!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              //height:100
              child: GridView.builder(
                  itemCount: GlobalVariables.subscriptionPlans.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        SubscriptionForm.routeName,
                        //arguments:subscriptionModel,
                      ),

                      /*Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new SubscriptionForm())),*/
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            height: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset(
                              GlobalVariables.subscriptionPlans[index]
                                  ['image']!,
                              fit: BoxFit.fill,
                              height: 200,
                              width: 200,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            GlobalVariables.subscriptionPlans[index]['title']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('Only one Subscription is allowed!'),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cash on Delivery only!'),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('Schedule Notification for Check Up Reminder!'),
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  style: TextStyle(
                      color: Color(
                    0xFF1B3834,
                  )),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      days = int.parse(value);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.notifications_active_rounded,
                      color: Colors.white,
                    ),
                    label: Text(buttonText),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xFF1B3834),
                    ),
                    onPressed: () {
                      
                      NotificationApi.showScheduleNotification(
                          title: 'Check-Up notification',
                          body: 'Time To Visit Doctor For Regular Checkup',
                          payload: 'This is a reminder for regular checkup',
                          scheduledDate: DateTime.now()
                              .add(Duration(seconds: days //days:29
                                  )));
                      showSnackBar(context,
                          'Notification Scheduled in ${days} seconds!');
                    },
                  ),

                  /*NotificationApi.showNotification(
                        title: 'Check-Up notification',
                        body: 'yes',
                        payload: 'vida'),
                      ),*/
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    label: Text('Cancel   Notification'),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xFF1B3834),
                    ),
                    onPressed: () {
                      NotificationApi.cancel(0);
                      showSnackBar(context, 'Notification Scheduled Cancel !');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
