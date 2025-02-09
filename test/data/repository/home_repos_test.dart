import 'package:string_calculator/data/repositories/home_repos_impl.dart';
import 'package:string_calculator/domain/core/interfaces/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeReposImpl Tests', () {
    late HomeRepository homeReposImpl;

    setUp(() {
      homeReposImpl = HomeReposImpl();
    });

    test('Empty Input - Should return 0', () {
      expect(homeReposImpl.add(''), 0);
    });

    test('Single Number - Should return the number itself', () {
      expect(homeReposImpl.add('5'), 5);
    });

    test('Multiple Numbers with Comma Delimiter - Should return the sum', () {
      expect(homeReposImpl.add('1,2,3,4,5'), 15);
    });

    test('Multiple Numbers with Newline Delimiter - Should return the sum', () {
      expect(homeReposImpl.add('1\n2\n3\n4\n5'), 15);
    });

    test('Multiple Numbers with Mixed Delimiters - Should return the sum', () {
      expect(homeReposImpl.add('1,2\n3,4\n5'), 15);
    });

    test('Custom Delimiter - Should return the sum', () {
      expect(homeReposImpl.add('//;\n1;2;3;4;5'), 15);
    });

    test('Negative Numbers - Should throw an exception', () {
      expect(
            () => homeReposImpl.add('1,-2,3,-4,5'),
        throwsA(predicate((e) => e.toString().contains('negative numbers not allowed'))),
      );
    });

    test('Invalid Input - Should throw an exception', () {
      expect(
            () => homeReposImpl.add('1,abc,3'),
        throwsA(isA<FormatException>()),
      );
    });

    test('Custom Delimiter with Negative Numbers - Should throw an exception', () {
      expect(
            () => homeReposImpl.add('//;\n1;-2;3;-4;5'),
        throwsA(predicate((e) => e.toString().contains('negative numbers not allowed'))),
      );
    });

    test('Custom Delimiter with Invalid Input - Should throw an exception', () {
      expect(
            () => homeReposImpl.add('//;\n1;abc;3'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}