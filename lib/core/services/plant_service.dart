import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/plant_entity.dart';

class PlantService {
  Future<List<Map<String, dynamic>>> loadPlantsFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/json/plants.json');
      final Map<String, dynamic> data = json.decode(response);
      return List<Map<String, dynamic>>.from(data['plants']);
    } catch (e) {
      print('Error loading plants: $e');
      return [];
    }
  }

  PlantCategory getCategoryById(int categoryId) {
    switch (categoryId) {
      case 1:
        return PlantCategory.fruits;
      case 2:
        return PlantCategory.vegetables;
      case 3:
        return PlantCategory.flowers;
      case 4:
        return PlantCategory.herbs;
      case 5:
        return PlantCategory.succulents;
      case 6:
        return PlantCategory.trees;
      default:
        return PlantCategory.flowers;
    }
  }

  String getEmojiForPlant(String name, PlantCategory category) {
    // Bazı bitkiler için özel emoji atamaları
    final Map<String, String> specialEmojis = {
      'Çilek': '🍓',
      'Limon': '🍋',
      'Domates': '🍅',
      'Elma': '🍎',
      'Muz': '🍌',
      'Salatalık': '🥒',
      'Havuç': '🥕',
      'Biber': '🌶️',
      'Patates': '🥔',
      'Ispanak': '🥬',
      'Gül': '🌹',
      'Lale': '🌷',
      'Orkide': '🪷',
      'Menekşe': '💜',
      'Papatya': '🌼',
      'Nane': '🌿',
      'Biberiye': '🌿',
      'Fesleğen': '🌿',
      'Kekik': '🌿',
      'Maydanoz': '🌿',
      'Aloe Vera': '🌵',
      'Echeveria': '🌵',
      'Yılan Bitkisi (Paşa Kılıcı)': '🐍',
      'Sedum (Damkoruğu)': '🌿',
      'Haworthia': '🌵',
      'Zeytin Ağacı': '🫒',
      'Çam Ağacı': '🌲',
      'Meşe Ağacı': '🌳',
      'Akçaağaç': '🍁',
      'İncir Ağacı': '🌳',
    };

    // Özel emoji varsa onu kullan, yoksa kategori emojisini kullan
    return specialEmojis[name] ?? category.emoji;
  }

  Future<List<PlantEntity>> getAllPlants() async {
    final plantMaps = await loadPlantsFromJson();
    
    return plantMaps.map((plantMap) {
      final PlantCategory category = getCategoryById(plantMap['category_id']);
      final String emoji = getEmojiForPlant(plantMap['name'], category);
      
      return PlantEntity(
        id: plantMap['id'].toString(),
        name: plantMap['name'],
        emoji: emoji,
        category: category,
        type: PlantType.educational,
        family: plantMap['family'],
        soilType: plantMap['soil_type'],
        idealTemperature: plantMap['ideal_temperature_celsius'].toString(),
        wateringIntervalDays: plantMap['watering_interval_days'],
        description: plantMap['description'],
        imageUrl: plantMap['image_url'],
      );
    }).toList();
  }

  Future<List<PlantEntity>> getPlantsByCategory(PlantCategory? category) async {
    final allPlants = await getAllPlants();
    
    if (category == null) {
      return allPlants;
    }
    
    return allPlants.where((plant) => plant.category == category).toList();
  }

  Future<PlantEntity?> getPlantById(String id) async {
    final allPlants = await getAllPlants();
    
    try {
      return allPlants.firstWhere((plant) => plant.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<PlantEntity>> searchPlants(String query) async {
    if (query.isEmpty) {
      return getAllPlants();
    }
    
    final allPlants = await getAllPlants();
    final lowerQuery = query.toLowerCase();
    
    return allPlants.where((plant) {
      return plant.name.toLowerCase().contains(lowerQuery) ||
             plant.family.toLowerCase().contains(lowerQuery) ||
             plant.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }
} 