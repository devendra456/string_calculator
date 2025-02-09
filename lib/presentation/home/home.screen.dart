import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sum of Numbers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter numbers separated by commas',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: controller.onTextChange,
              minLines: 1,
              maxLines: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.onButtonPressed,
              child: Text('Calculate Sum'),
            ),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                "${controller.result.value ?? ''}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
            Obx(() {
              return Text(
                controller.error.value,
                style: TextStyle(color: Colors.red),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
