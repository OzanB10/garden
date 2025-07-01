import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/services/plant_service.dart';
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
  final PlantService _plantService = PlantService();
  List<PlantEntity> _allPlants = [];
  List<PlantEntity> _filteredPlants = [];
  PlantCategory? _selectedCategory;
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  // Kategori renkleri
  final Map<PlantCategory, Color> _categoryColors = {
    PlantCategory.fruits: const Color(0xFFFFF3E0),
    PlantCategory.vegetables: const Color(0xFFE8F5E8),
    PlantCategory.flowers: const Color(0xFFFFF0F5),
    PlantCategory.herbs: const Color(0xFFE0F2F1),
    PlantCategory.succulents: const Color(0xFFE6F3E6),
    PlantCategory.trees: const Color(0xFFE8F5E8),
  };

  @override
  void initState() {
    super.initState();
    _loadPlants();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterPlants();
    });
  }

  Future<void> _loadPlants() async {
    try {
      final plants = await _plantService.getAllPlants();
      setState(() {
        _allPlants = plants;
        _filteredPlants = plants;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bitkiler yüklenirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _filterPlants() {
    List<PlantEntity> filtered = _allPlants;
    
    // Kategori filtresi
    if (_selectedCategory != null) {
      filtered = filtered.where((plant) => plant.category == _selectedCategory).toList();
    }
    
    // Arama filtresi
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((plant) => 
        plant.name.toLowerCase().contains(_searchQuery) ||
        plant.family.toLowerCase().contains(_searchQuery) ||
        plant.description.toLowerCase().contains(_searchQuery)
      ).toList();
    }
    
    setState(() {
      _filteredPlants = filtered;
    });
  }

  void _onCategorySelected(PlantCategory? category) {
    setState(() {
      _selectedCategory = category;
      _filterPlants();
    });
  }

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
              controller: _searchController,
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
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
              },
              child: Icon(
                Icons.clear_rounded,
                color: AppColors.textSecondary,
                size: AppDimensions.iconMedium,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [null, ...PlantCategory.values];
    
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
                title: category?.displayName ?? 'Tümü',
                emoji: category?.emoji ?? '🌿',
                isSelected: _selectedCategory == category,
                onTap: () => _onCategorySelected(category),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlantsGrid() {
    if (_isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_filteredPlants.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🔍',
                style: GoogleFonts.poppins(fontSize: 48),
              ),
              const SizedBox(height: AppDimensions.spacing16),
              Text(
                _searchQuery.isNotEmpty 
                    ? 'Aradığınız bitki bulunamadı'
                    : 'Bu kategoride bitki bulunamadı',
                style: GoogleFonts.poppins(
                  fontSize: AppDimensions.fontLarge,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bitkiler (${_filteredPlants.length})',
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
              itemCount: _filteredPlants.length,
              itemBuilder: (context, index) {
                final plant = _filteredPlants[index];
                return GestureDetector(
                  onTap: () => _showPlantDetails(plant),
                  child: PlantCardWidget(
                    plantName: plant.name,
                    emoji: plant.emoji,
                    backgroundColor: _categoryColors[plant.category] ?? const Color(0xFFF5F5F5),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPlantDetails(PlantEntity plant) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXXLarge),
            topRight: Radius.circular(AppDimensions.radiusXXLarge),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spacing12),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacing24),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _categoryColors[plant.category] ?? const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                    ),
                    child: Center(
                      child: Text(
                        plant.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: GoogleFonts.poppins(
                            fontSize: AppDimensions.fontXXLarge,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          plant.category.displayName,
                          style: GoogleFonts.poppins(
                            fontSize: AppDimensions.fontLarge,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacing24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard('🔬 Familya', plant.family),
                      const SizedBox(height: AppDimensions.spacing12),
                      _buildInfoCard('🌡️ İdeal Sıcaklık', '${plant.idealTemperature}°C'),
                      const SizedBox(height: AppDimensions.spacing12),
                      _buildInfoCard('💧 Sulama Aralığı', '${plant.wateringIntervalDays} günde bir'),
                      const SizedBox(height: AppDimensions.spacing12),
                      _buildInfoCard('🌱 Toprak Türü', plant.soilType),
                      const SizedBox(height: AppDimensions.spacing16),
                      Text(
                        'Açıklama',
                        style: GoogleFonts.poppins(
                          fontSize: AppDimensions.fontHeading,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacing12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimensions.spacing16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                        ),
                        child: Text(
                          plant.description,
                          style: GoogleFonts.poppins(
                            fontSize: AppDimensions.fontLarge,
                            color: AppColors.textPrimary,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontMedium,
              color: AppColors.textSecondary,
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