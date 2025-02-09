import 'package:get/get.dart';
import 'package:string_calculator/data/repositories/home_repos_impl.dart';
import 'package:string_calculator/domain/core/interfaces/home_repository.dart';

Future<void> setup() async {
  // Registering HomeRepository.
  Get.lazyPut<HomeRepository>(() => HomeReposImpl());
}
