import 'package:string_calculator/domain/core/interfaces/home_repository.dart';

class HomeReposImpl implements HomeRepository {
  @override
  int add(String numbers) {

    // If numbers is empty returning 0.
    if (numbers.isEmpty) return 0;

    // Checking number delimiter.
    RegExp delimiter = RegExp(r',|\n');
    if (numbers.startsWith('//')) {
      final match = RegExp(r'^//(.+)\n(.*)').firstMatch(numbers);
      if (match != null) {
        delimiter = RegExp(match.group(1)!);
        numbers = match.group(2)!;
      }
    }
    final numArray = numbers.split(delimiter).map(int.parse).toList();

    //check and throw exception if negative numbers found.
    final negatives = numArray.where((number) => number < 0).toList();
    if (negatives.isNotEmpty) {
      throw "negative numbers not allowed ${negatives.join(', ')}";
    }

    //return sum of integer numbers
    return numArray.reduce((sum, number) => sum + number);
  }
}
