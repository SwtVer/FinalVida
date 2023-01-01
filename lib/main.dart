import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:vida/features/auth/screens/auth_screen.dart'
//import 'package:vida/doctorappointment/appointment.dart';
//import 'package:vida/doctorappointment/appointmentform.dart';
//import 'package:vida/doctorappointment/docdetail.dart';
import 'package:vida/features/admin/screen/admin_screen.dart';
import 'package:vida/features/auth/services/auth_service.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/router.dart';
//import 'package:khalti_flutter/khalti_flutter.dart';




import 'package:vida/home/login.dart';
import 'package:vida/widgets/bottom_bar.dart';

//import 'khalti_payment_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  final AuthService authService = AuthService();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const Admin()
          : const LogInScreen(),

      /*appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      
     
      onGenerateRoute: (settings) => generateRoute(settings),*/
    );
  }
}
