import 'package:get/get.dart';

import '../../../domain/core/interfaces/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repos;
  final Rx<int?> result = Rx(null);
  String _inputText = '';
  RxString error = RxString('');

  HomeController({required this.repos});

  // On text change
  void onTextChange(String value) {
    _inputText = value;
  }

  // On button pressed calling.
  void onButtonPressed() {
    try {
      result.value = repos.add(_inputText);
      error.value = '';
    } on FormatException {
      result.value = null;
      error.value = "Invalid input";
    } catch (e) {
      result.value = null;
      error.value = e.toString();
    }
  }
}
