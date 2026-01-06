import 'dart:convert';
import 'dart:typed_data';

import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_remote_datasource_impl.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DogProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Try evicting to see if it works now.
    rootBundle.evict('assets/mock/breeds.json');
    dataSource = DogProfileRemoteDataSourceImpl();
  });

  group('fetchDogBreeds', () {
    test(
      'should return list of breeds when asset load is successful',
      () async {
        // Arrange
        final breedsJson = {
          'breeds': [
            {'id': 1, 'name': 'Labrador'},
            {'id': 2, 'name': 'Poodle'},
          ],
        };
        _mockRootBundle('assets/mock/breeds.json', jsonEncode(breedsJson));

        // Act
        final result = await dataSource.fetchDogBreeds();

        // Assert
        expect(result.length, 2);
        expect(result[0].name, 'Labrador');
        expect(result[1].name, 'Poodle');
      },
    );

    test('should return empty list if JSON is invalid', () async {
      _mockRootBundle('assets/mock/breeds.json', '[]');
      final result = await dataSource.fetchDogBreeds();
      expect(result, isEmpty);
    });
  });

  group('createDogProfile', () {
    test('should return boolean', () async {
      final result = await dataSource.createDogProfile(DogProfile());
      expect(result, isA<bool>());
    });
  });
}

void _mockRootBundle(String path, String content) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler('flutter/assets', (message) async {
        final ByteData? data = const Utf8Codec().encoder
            .convert(content)
            .buffer
            .asByteData();
        return data;
      });
}
