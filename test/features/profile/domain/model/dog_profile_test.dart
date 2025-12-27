import 'package:flutter_test/flutter_test.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/owner.dart';

void main() {
  group('DogProfile', () {
    test('copyWith should return a new instance with updated values', () {
      final breed = Breed(id: 1, name: 'Labrador');
      final owner = Owner(name: 'John Doe', email: 'john@example.com');
      final profile = DogProfile(
        breed: breed,
        name: 'Buddy',
        sex: DogSex.male,
        sterilized: true,
        birthMonth: 1,
        birthYear: 2020,
        size: DogSize.medium,
        weight: '20',
        activity: DogActivity.high,
        hasIllness: false,
        gastronomy: DogGastronomy.gourmet,
        owner: owner,
      );

      final updatedProfile = profile.copyWith(name: 'Max', weight: '25');

      expect(updatedProfile.name, 'Max');
      expect(updatedProfile.weight, '25');
      // Verify other fields remain unchanged
      expect(updatedProfile.breed, breed);
      expect(updatedProfile.sex, DogSex.male);
      expect(updatedProfile.sterilized, true);
      expect(updatedProfile.birthMonth, 1);
      expect(updatedProfile.birthYear, 2020);
      expect(updatedProfile.size, DogSize.medium);
      expect(updatedProfile.activity, DogActivity.high);
      expect(updatedProfile.hasIllness, false);
      expect(updatedProfile.gastronomy, DogGastronomy.gourmet);
      expect(updatedProfile.owner, owner);
    });

    test('copyWith should return same values if no arguments provided', () {
      final breed = Breed(id: 1, name: 'Labrador');
      final profile = DogProfile(breed: breed, name: 'Buddy');

      final updatedProfile = profile.copyWith();

      expect(updatedProfile.breed, breed);
      expect(updatedProfile.name, 'Buddy');
    });
  });
}
