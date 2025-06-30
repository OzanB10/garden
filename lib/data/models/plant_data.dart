import '../../domain/entities/plant_entity.dart';

class PlantData {
  static List<PlantEntity> getMyPlants() {
    return [
      PlantEntity(
        id: '1',
        name: 'Yılan Bitkisi',
        emoji: '🐍',
        category: PlantCategory.succulents,
        type: PlantType.planted,
        lastWatered: DateTime.now().subtract(const Duration(days: 3)),
        nextWateringDate: DateTime.now().add(const Duration(days: 4)),
        isFavorite: true,
      ),
      PlantEntity(
        id: '2',
        name: 'ZZ Plant',
        emoji: '🌿',
        category: PlantCategory.succulents,
        type: PlantType.planted,

        lastWatered: DateTime.now().subtract(const Duration(days: 5)),
        nextWateringDate: DateTime.now(),
        isFavorite: false,
      ),
      PlantEntity(
        id: '3',
        name: 'Barış Çiçeği',
        emoji: '🕊️',
        category: PlantCategory.flowers,
        type: PlantType.planted,
        lastWatered: DateTime.now().subtract(const Duration(days: 2)),
        nextWateringDate: DateTime.now().add(const Duration(days: 2)),
        isFavorite: true,
      ),
      PlantEntity(
        id: '4',
        name: 'Kaktüsüm',
        emoji: '🌵',
        category: PlantCategory.succulents,
        type: PlantType.planted,
        lastWatered: DateTime.now().subtract(const Duration(days: 7)),
        nextWateringDate: DateTime.now().add(const Duration(days: 7)),
        isFavorite: false,
      ),
    ];
  }

  static List<PlantEntity> getEducationalPlants() {
    return [
      PlantEntity(
        id: 'edu1',
        name: 'Gül',
        emoji: '🌹',
        category: PlantCategory.flowers,
        type: PlantType.educational,
        careInstructions: 'Günde 6-8 saat güneş ışığı, haftada 2-3 kez sulama',
      ),
      PlantEntity(
        id: 'edu2',
        name: 'Domates',
        emoji: '🍅',
        category: PlantCategory.vegetables,
        type: PlantType.educational,
        careInstructions: 'Bol güneş, düzenli sulama ve destek çubuğu gerekli',
      ),
      PlantEntity(
        id: 'edu3',
        name: 'Fesleğen',
        emoji: '🌿',
        category: PlantCategory.herbs,
        type: PlantType.educational,
        careInstructions: 'Sıcak ve güneşli ortam, toprak nem oranına dikkat',
      ),
      PlantEntity(
        id: 'edu4',
        name: 'Lavanta',
        emoji: '💜',
        category: PlantCategory.herbs,
        type: PlantType.educational,
        careInstructions: 'Az su, bol güneş, iyi drenajs gerekli',
      ),
      PlantEntity(
        id: 'edu5',
        name: 'Elma Ağacı',
        emoji: '🍎',
        category: PlantCategory.fruits,
        type: PlantType.educational,
        careInstructions: 'Düzenli sulama, budama ve güneş ışığı gerekli',
      ),
      PlantEntity(
        id: 'edu6',
        name: 'Nane',
        emoji: '🌱',
        category: PlantCategory.herbs,
        type: PlantType.educational,
        careInstructions: 'Nemli toprak, yarı gölge, düzenli hasat',
      ),
    ];
  }

  static List<PlantEntity> getPlantsByCategory(PlantCategory category) {
    final allEducational = getEducationalPlants();
    return allEducational.where((plant) => plant.category == category).toList();
  }

  static List<PlantCategory> getAllCategories() {
    return PlantCategory.values;
  }
} 