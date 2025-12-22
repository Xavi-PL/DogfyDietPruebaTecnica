import 'package:dogfy_diet_prueba_tecnica/features/profile/data/model/breed_dto.dart';
import 'package:dogfy_diet_prueba_tecnica/features/profile/domain/model/breed.dart';

class BreedMapper {
  BreedMapper();

  Breed toBreed(BreedDto breedDto) {
    return Breed(id: breedDto.id, name: breedDto.name);
  }

  BreedDto toBreedDto(Breed breed) {
    return BreedDto(id: breed.id, name: breed.name);
  }
}
