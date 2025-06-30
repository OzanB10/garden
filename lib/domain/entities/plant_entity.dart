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
  final String? careInstructions;
  final DateTime? lastWatered;
  final DateTime? nextWateringDate;
  final bool isFavorite;
  final String? imageUrl;

  const PlantEntity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    required this.type,
    this.careInstructions,
    this.lastWatered,
    this.nextWateringDate,
    this.isFavorite = false,
    this.imageUrl,
  });

  PlantEntity copyWith({
    String? id,
    String? name,
    String? emoji,
    PlantCategory? category,
    PlantType? type,
    String? careInstructions,
    DateTime? lastWatered,
    DateTime? nextWateringDate,
    bool? isFavorite,
    String? imageUrl,
  }) {
    return PlantEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      category: category ?? this.category,
      type: type ?? this.type,
      careInstructions: careInstructions ?? this.careInstructions,
      lastWatered: lastWatered ?? this.lastWatered,
      nextWateringDate: nextWateringDate ?? this.nextWateringDate,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
} 