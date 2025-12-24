import 'package:dogfy_diet_prueba_tecnica/features/profile/data/datasource/dog_profile_local_datasource.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/data/mapper/dog_profile_mapper.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/dog_profile.dart';
import 'package:hive/hive.dart';

class DogProfileLocalDataSourceImpl implements DogProfileLocalDataSource {
  static final _mapper = DogProfileMapper();
  static const _boxName = 'dog_profile_draft_box';
  static const _key = 'dog_profile_draft';

  Future<Box<String>> _box() async {
    if (Hive.isBoxOpen(_boxName)) return Hive.box<String>(_boxName);
    return Hive.openBox<String>(_boxName);
  }

  @override
  Future<void> clearDogProfileDraft() async {
    final box = await _box();
    await box.delete(_key);
  }

  @override
  Future<DogProfile> loadDogProfileDraft() async {
    final box = await _box();
    final json = box.get(_key);
    if (json == null || json.isEmpty) {
      throw Exception('There is no draft saved');
    }
    return _mapper.toDomain(_mapper.fromJson(json));
  }

  @override
  Future<void> saveDogProfileDraft(DogProfile dogProfile) async {
    final box = await _box();
    final json = _mapper.toJson(_mapper.fromDomain(dogProfile));
    await box.put(_key, json);
  }

  @override
  Future<bool> hasDogProfileDraft() async {
    final box = await _box();
    return box.containsKey(_key) && (box.get(_key)?.isNotEmpty ?? false);
  }
}
