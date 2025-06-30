import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/plant_data.dart';
import '../../domain/entities/plant_entity.dart';
import '../widgets/category_chip_widget.dart';
import '../widgets/navigation_item_widget.dart';
import '../widgets/plant_card_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'Tümü';
  
  final categories = [
    {'title': 'Tümü', 'emoji': '🌿'},
    {'title': 'Meyveler', 'emoji': '🍎'},
    {'title': 'Sebzeler', 'emoji': '🥕'},
    {'title': 'Çiçekler', 'emoji': '🌸'},
    {'title': 'Otlar', 'emoji': '🌱'},
    {'title': 'Sukulentler', 'emoji': '🌵'},
    {'title': 'Ağaçlar', 'emoji': '🌳'},
  ];

  final plants = [
    {'name': 'Gül', 'emoji': '🌹', 'category': 'Çiçekler', 'color': const Color(0xFFFFF0F5)},
    {'name': 'Domates', 'emoji': '🍅', 'category': 'Sebzeler', 'color': const Color(0xFFE8F5E8)},
    {'name': 'Fesleğen', 'emoji': '🌿', 'category': 'Otlar', 'color': const Color(0xFFE0F2F1)},
    {'name': 'Elma Ağacı', 'emoji': '🍎', 'category': 'Meyveler', 'color': const Color(0xFFFFF3E0)},
    {'name': 'Lavanta', 'emoji': '💜', 'category': 'Otlar', 'color': const Color(0xFFE0F2F1)},
    {'name': 'Kaktüs', 'emoji': '🌵', 'category': 'Sukulentler', 'color': const Color(0xFFE6F3E6)},
    {'name': 'Nane', 'emoji': '🌱', 'category': 'Otlar', 'color': const Color(0xFFE0F2F1)},
    {'name': 'Çilek', 'emoji': '🍓', 'category': 'Meyveler', 'color': const Color(0xFFFFF3E0)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppDimensions.spacing16),
              _buildSearchBar(),
              const SizedBox(height: AppDimensions.spacing18),
              _buildCategoriesSection(),
              const SizedBox(height: AppDimensions.spacing16),
              _buildPlantsGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.spacing8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary,
                  size: AppDimensions.iconMedium,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacing16),
            Text(
              'Bitkileri Keşfet 🌱',
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontHeader,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing4),
        Padding(
          padding: const EdgeInsets.only(left: 56.0),
          child: Text(
            'Yeni yeşil dostlarını bul ve öğren!',
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontLarge,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
            size: AppDimensions.iconMedium,
          ),
          const SizedBox(width: AppDimensions.spacing12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Bitki ara...',
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.textSecondary,
                  fontSize: AppDimensions.fontLarge,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategoriler',
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontHeading,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing12),
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryChipWidget(
                title: category['title'] as String,
                emoji: category['emoji'] as String,
                isSelected: selectedCategory == category['title'],
                onTap: () {
                  setState(() {
                    selectedCategory = category['title'] as String;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlantsGrid() {
    final filteredPlants = selectedCategory == 'Tümü' 
        ? plants 
        : plants.where((plant) => plant['category'] == selectedCategory).toList();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bitkiler (${filteredPlants.length})',
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontHeading,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: AppDimensions.spacing12,
                mainAxisSpacing: AppDimensions.spacing12,
              ),
              itemCount: filteredPlants.length,
              itemBuilder: (context, index) {
                final plant = filteredPlants[index];
                return PlantCardWidget(
                  plantName: plant['name'] as String,
                  emoji: plant['emoji'] as String,
                  backgroundColor: plant['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: AppDimensions.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusXXLarge),
          topRight: Radius.circular(AppDimensions.radiusXXLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppDimensions.blurXLarge,
            offset: AppDimensions.shadowOffsetNegative,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationItemWidget(
              icon: Icons.home_rounded,
              label: AppStrings.navHome,
              isActive: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            NavigationItemWidget(
              icon: Icons.search_rounded,
              label: AppStrings.navDiscover,
              isActive: true,
              onTap: () {
                // Zaten keşfet sayfasındayız
              },
            ),
            NavigationItemWidget(
              icon: Icons.camera_alt_rounded,
              label: AppStrings.navGarden,
              isActive: false,
              onTap: () {
                // Garden sayfası henüz oluşturulmadı
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bahçe sayfası yakında geliyor!'),
                  ),
                );
              },
            ),
            NavigationItemWidget(
              icon: Icons.person_rounded,
              label: AppStrings.navProfile,
              isActive: false,
              onTap: () {
                // Profile sayfası henüz oluşturulmadı
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profil sayfası yakında geliyor!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 