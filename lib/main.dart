import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_calculator/infrastructure/dal/services/di.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  //getting the initial route.
  var initialRoute = await Routes.initialRoute;
  // setting up di.
  await setup();
  // app started.
  runApp(MyApp(initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
  }
}
