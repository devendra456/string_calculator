import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:string_calculator/data/repositories/home_repos_impl.dart';
import 'package:string_calculator/domain/core/interfaces/home_repository.dart';
import 'package:string_calculator/infrastructure/navigation/routes.dart';
import 'package:string_calculator/main.dart';
import 'package:string_calculator/presentation/home/controllers/home.controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreen Integration Test', () {
    late HomeController homeController;
    late HomeRepository homeReposImpl;
    late String initialRoute;

    setUp(() async {
      // Initialize GetX bindings
      Get.testMode = true;
      initialRoute = await Routes.initialRoute;
      homeReposImpl = HomeReposImpl();
      homeController = HomeController(repos: homeReposImpl);
      Get.put<HomeController>(homeController);
      Get.put<HomeRepository>(homeReposImpl);
    });

    tearDown(() {
      // Clean up GetX bindings
      Get.reset();
    });

    testWidgets('Enter Numbers and Calculate Sum', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(MyApp(initialRoute));

      // Wait for the HomeScreen to load
      await tester.pumpAndSettle();

      // Enter numbers in the TextField
      await tester.enterText(find.byType(TextField), '1,2,3,4,5');
      await tester.pump(); // Rebuild the widget

      // Tap the "Calculate Sum" button
      await tester.tap(find.text('Calculate Sum'));
      await tester.pumpAndSettle(); // Wait for the result to update

      // Verify the result
      expect(find.text('15'), findsOneWidget); // Result text
      expect(find.text(''), findsOneWidget); // No error text
    });

    testWidgets('Enter Negative Numbers and Show Error',
        (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(MyApp(initialRoute));

      // Wait for the HomeScreen to load
      await tester.pumpAndSettle();

      // Enter negative numbers in the TextField
      await tester.enterText(find.byType(TextField), '1,-2,3,-4,5');
      await tester.pump(); // Rebuild the widget

      // Tap the "Calculate Sum" button
      await tester.tap(find.text('Calculate Sum'));
      await tester.pumpAndSettle(); // Wait for the error to update

      // Verify the error message
      expect(find.text('negative numbers not allowed -2, -4'),
          findsOneWidget); // Error text
      expect(find.text(''), findsOneWidget); // No result text
    });

    testWidgets('Enter Invalid Input and Show Error',
        (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(MyApp(initialRoute));

      // Wait for the HomeScreen to load
      await tester.pumpAndSettle();

      // Enter invalid input in the TextField
      await tester.enterText(find.byType(TextField), '1,abc,3');
      await tester.pump(); // Rebuild the widget

      // Tap the "Calculate Sum" button
      await tester.tap(find.text('Calculate Sum'));
      await tester.pumpAndSettle(); // Wait for the error to update

      // Verify the error message
      expect(find.text('Invalid input'), findsOneWidget); // Error text
      expect(find.text(''), findsOneWidget); // No result text
    });
  });
}
