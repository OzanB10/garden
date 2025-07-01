enum PlantCategory {
  fruits('Meyveler', '🍎'),
  vegetables('Sebzeler', '🥕'),
  flowers('Çiçekler', '🌸'),
  herbs('Otlar', '🌿'),
  succulents('Sukulentler', '🌵'),
  trees('Ağaçlar', '🌳');

  const PlantCategory(this.displayName, this.emoji);

  final String displayName;
  final String emoji;
}

enum PlantType {
  educational('Eğitici'),
  planted('Ekilen');

  const PlantType(this.displayName);

  final String displayName;
}

class PlantEntity {
  final String id;
  final String name;
  final String emoji;
  final PlantCategory category;
  final PlantType type;
  final String family;
  final String soilType;
  final String idealTemperature;
  final int wateringIntervalDays;
  final String description;
  final String? imageUrl;
  final DateTime? lastWatered;
  final DateTime? nextWateringDate;
  final bool isFavorite;

  const PlantEntity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    required this.type,
    required this.family,
    required this.soilType,
    required this.idealTemperature,
    required this.wateringIntervalDays,
    required this.description,
    this.imageUrl,
    this.lastWatered,
    this.nextWateringDate,
    this.isFavorite = false,
  });

  String get careInstructions {
    return 'Familya: $family\n'
        'Toprak Türü: $soilType\n'
        'İdeal Sıcaklık: $idealTemperature°C\n'
        'Sulama Aralığı: $wateringIntervalDays günde bir\n\n'
        'Açıklama: $description';
  }

  PlantEntity copyWith({
    String? id,
    String? name,
    String? emoji,
    PlantCategory? category,
    PlantType? type,
    String? family,
    String? soilType,
    String? idealTemperature,
    int? wateringIntervalDays,
    String? description,
    String? imageUrl,
    DateTime? lastWatered,
    DateTime? nextWateringDate,
    bool? isFavorite,
  }) {
    return PlantEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      category: category ?? this.category,
      type: type ?? this.type,
      family: family ?? this.family,
      soilType: soilType ?? this.soilType,
      idealTemperature: idealTemperature ?? this.idealTemperature,
      wateringIntervalDays: wateringIntervalDays ?? this.wateringIntervalDays,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      lastWatered: lastWatered ?? this.lastWatered,
      nextWateringDate: nextWateringDate ?? this.nextWateringDate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
} 