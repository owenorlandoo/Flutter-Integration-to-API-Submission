// import 'package:flutter/material.dart';
// import 'package:mvvm/view/pages/pages.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Integration to API Submission',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const MainMenu(),
//       home: ShippingCalculator(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mvvm/view/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:mvvm/viewmodel/shipping_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ShippingViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shipping Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ShippingCalculatorPage(),
      ),
    );
  }
}
