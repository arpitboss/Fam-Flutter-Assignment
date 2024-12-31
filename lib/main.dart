import 'package:fam_flutter_assignment/utils/constants/app_colors.dart';
import 'package:fam_flutter_assignment/utils/dependencies/init.dart';
import 'package:fam_flutter_assignment/views/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contextual Cards Functionality',
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        cardTheme: CardTheme(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: const FamScreen(),
    );
  }
}
