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
        family: 'Asparagaceae',
        soilType: 'İyi drenajlı, gevşek',
        idealTemperature: '18-35',
        wateringIntervalDays: 25,
        description: 'Bakımı en kolay ev bitkilerinden biridir. Düşük ışığa ve az sulamaya toleranslıdır.',
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
        family: 'Araceae',
        soilType: 'İyi drenajlı, kaktüs toprağı',
        idealTemperature: '18-26',
        wateringIntervalDays: 20,
        description: 'Zamioculcas zamiifolia, az bakım gerektiren ve kuraklığa dayanıklı bir ev bitkisidir.',
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
        family: 'Araceae',
        soilType: 'Nemli, humuslu toprak',
        idealTemperature: '18-24',
        wateringIntervalDays: 4,
        description: 'Spathiphyllum, beyaz çiçekleri ve koyu yeşil yaprakları ile tanınan popüler bir ev bitkisidir.',
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
        family: 'Cactaceae',
        soilType: 'Kaktüs toprağı, çok iyi drenajlı',
        idealTemperature: '20-30',
        wateringIntervalDays: 14,
        description: 'Çok az su gerektiren, güneşi seven kaktüs türü. Çok renkli çiçekler açabilir.',
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
        family: 'Rosaceae',
        soilType: 'İyi drenajlı, tınlı',
        idealTemperature: '15-25',
        wateringIntervalDays: 5,
        description: 'Güzelliği ve kokusuyla bilinen popüler bir süs bitkisidir. Çok sayıda renk ve türü vardır.',
      ),
      PlantEntity(
        id: 'edu2',
        name: 'Domates',
        emoji: '🍅',
        category: PlantCategory.vegetables,
        type: PlantType.educational,
        family: 'Solanaceae',
        soilType: 'Tınlı, besin açısından zengin',
        idealTemperature: '21-29',
        wateringIntervalDays: 3,
        description: 'Botanik olarak meyve sayılan domates, mutfaklarda genellikle sebze olarak kullanılır.',
      ),
      PlantEntity(
        id: 'edu3',
        name: 'Fesleğen',
        emoji: '🌿',
        category: PlantCategory.herbs,
        type: PlantType.educational,
        family: 'Lamiaceae',
        soilType: 'Zengin, nemli, iyi drenajlı',
        idealTemperature: '20-30',
        wateringIntervalDays: 3,
        description: 'İtalyan mutfağının vazgeçilmezi olan fesleğen, sıcak havaları ve bol güneşi sever.',
      ),
      PlantEntity(
        id: 'edu4',
        name: 'Lavanta',
        emoji: '💜',
        category: PlantCategory.herbs,
        type: PlantType.educational,
        family: 'Lamiaceae',
        soilType: 'Kuru, iyi drenajlı, kumlu',
        idealTemperature: '20-30',
        wateringIntervalDays: 10,
        description: 'Hoş kokusu ve mor çiçekleriyle bilinen lavanta, kuraklığa dayanıklı aromatik bir bitkidir.',
      ),
      PlantEntity(
        id: 'edu5',
        name: 'Elma Ağacı',
        emoji: '🍎',
        category: PlantCategory.fruits,
        type: PlantType.educational,
        family: 'Rosaceae',
        soilType: 'İyi drenajlı, tınlı',
        idealTemperature: '18-24',
        wateringIntervalDays: 10,
        description: 'Dünya genelinde en çok tüketilen meyvelerden biridir. Çok sayıda çeşidi bulunur.',
      ),
      PlantEntity(
        id: 'edu6',
        name: 'Nane',
        emoji: '🌱',
        category: PlantCategory.herbs,
        type: PlantType.educational,
        family: 'Lamiaceae',
        soilType: 'Nemli, zengin toprak',
        idealTemperature: '15-25',
        wateringIntervalDays: 2,
        description: 'Ferahlatan kokusu ve tadıyla bilinen nane, hem mutfakta hem de tıbbi amaçlarla kullanılır.',
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