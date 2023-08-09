import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/user_provider.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'klimbb demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppConstants.primaryColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
