import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_and_art/controller/controller_binding.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/services/get_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // home: LoginScreen(),
          initialRoute: GetStorageServices.getUserLoggedIn() != null
              ? Routes.installationScreen
              : Routes.loginScreen,
          getPages: getRoute,
          initialBinding: ControllerBindings(),
        );
      },
    );
  }
}
