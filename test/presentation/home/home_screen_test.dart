import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:string_calculator/data/repositories/home_repos_impl.dart';
import 'package:string_calculator/domain/core/interfaces/home_repository.dart';
import 'package:string_calculator/presentation/home/controllers/home.controller.dart';
import 'package:string_calculator/presentation/home/home.screen.dart';
void main() {
  late HomeController homeController;
  late HomeRepository homeReposImpl;


  setUp(() {
    // Initialize GetX bindings
    Get.testMode = true;
    homeReposImpl = HomeReposImpl();
    homeController = HomeController(repos: homeReposImpl);
    Get.put<HomeController>(homeController);
    Get.put<HomeRepository>(homeReposImpl);
  });

  tearDown(() {
    // Clean up GetX bindings
    Get.reset();
  });

  testWidgets('HomeScreen UI Test - Initial State', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify initial UI elements
    expect(find.text('Sum of Numbers'), findsOneWidget); // AppBar title
    expect(find.text('Enter numbers separated by commas'), findsOneWidget); // TextField label
    expect(find.text('Calculate Sum'), findsOneWidget); // Button text
  });

  testWidgets('HomeScreen UI Test - Enter Numbers and Calculate Sum', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Enter numbers in the TextField
    await tester.enterText(find.byType(TextField), '1,2,3,4,5');
    await tester.pump(); // Rebuild the widget

    // Tap the button
    await tester.tap(find.text('Calculate Sum'));
    await tester.pump(); // Rebuild the widget

    // Verify the result
    expect(find.text('15'), findsOneWidget); // Result text
    expect(find.text(''), findsOneWidget); // No error text
  });

  testWidgets('HomeScreen UI Test - Enter Negative Numbers and Show Error', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Enter negative numbers in the TextField
    await tester.enterText(find.byType(TextField), '1,-2,3,-4,5');
    await tester.pump(); // Rebuild the widget

    // Tap the button
    await tester.tap(find.text('Calculate Sum'));
    await tester.pump(); // Rebuild the widget

    // Verify the error message
    expect(find.text('negative numbers not allowed -2, -4'), findsOneWidget); // Error text
    expect(find.text(''), findsOneWidget); // No result text
  });

  testWidgets('HomeScreen UI Test - Enter Invalid Input and Show Error', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Enter invalid input in the TextField
    await tester.enterText(find.byType(TextField), '1,abc,3');
    await tester.pump(); // Rebuild the widget

    // Tap the button
    await tester.tap(find.text('Calculate Sum'));
    await tester.pump(); // Rebuild the widget

    // Verify the error message
    expect(find.text('Invalid input'), findsOneWidget); // Error text
    expect(find.text(''), findsOneWidget); // No result text
  });
}