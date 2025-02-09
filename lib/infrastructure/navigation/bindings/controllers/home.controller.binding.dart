import 'package:get/get.dart';
import 'package:string_calculator/domain/core/interfaces/home_repository.dart';

import '../../../../presentation/home/controllers/home.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    final HomeRepository repos = Get.find<HomeRepository>();
    Get.lazyPut<HomeController>(
      () => HomeController(repos: repos),
    );
  }
}
