import 'package:campus_flow/controllers/fees_controller.dart';
import 'package:campus_flow/controllers/library_controller.dart';
import 'package:campus_flow/controllers/student_controller.dart';
import 'package:campus_flow/views/Splash_screen.dart';
import 'package:campus_flow/views/admin/admin_dashborad.dart';
import 'package:campus_flow/views/staff/staff_dashboard.dart';
import 'package:campus_flow/views/student/student_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'controllers/auth_controllers.dart';
import 'views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDk8cyp62bNxUI_XdfbFTpyDgI5SRDQgt4",
      appId: "1:831790945336:android:0b114318862b2e154182cd",
      messagingSenderId: "",
      projectId: "role-based-auth-ce940",
      storageBucket: "role-based-auth-ce940.firebasestorage.app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AuthControllers()),
        ChangeNotifierProvider(create: (_) => StudentController()),
        ChangeNotifierProvider(create: (_) => LibraryController()),
        ChangeNotifierProvider(create: (_) => FeesController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            elevation: 4,
          ),
        ),
        initialRoute: '/splash',
        routes: {
         '/splash':(context)=>const SplashScreen(),
         '/login':(context)=>const LoginScreen(),
         '/admin_dashboard':(context)=>const AdminDashboard(),
         '/staff_dashboard':(context)=>const StaffDashboard(),
         '/student_dashboard':(context)=>const StudentDashboard()}

       
      ),
    );
  }
}
