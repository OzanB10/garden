import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

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

class _DiscoverPageState extends State<DiscoverPage> with TickerProviderStateMixin {
  final PlantService _plantService = PlantService();
  List<PlantEntity> _allPlants = [];
  List<PlantEntity> _filteredPlants = [];
  PlantCategory? _selectedCategory;
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Modern kategori renkleri - gradient'ler
  final Map<PlantCategory, List<Color>> _categoryGradients = {
    PlantCategory.fruits: [const Color(0xFFFFE4B5), const Color(0xFFFFF8DC)],
    PlantCategory.vegetables: [const Color(0xFFE8F5E8), const Color(0xFFF0FFF0)],
    PlantCategory.flowers: [const Color(0xFFFFF0F5), const Color(0xFFFFE4E1)],
    PlantCategory.herbs: [const Color(0xFFE0F2F1), const Color(0xFFE8F5E8)],
    PlantCategory.succulents: [const Color(0xFFE6F3E6), const Color(0xFFF0FFF0)],
    PlantCategory.trees: [const Color(0xFFE8F5E8), const Color(0xFFF5FFFA)],
  };

  @override
  void initState() {
    super.initState();
    _loadPlants();
    _searchController.addListener(_onSearchChanged);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _animationController.dispose();
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
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FFFF),
              Color(0xFFE8F5E8),
              Color(0xFFF0FFF0),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildModernHeader(),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildModernSearchBar(),
                  const SizedBox(height: AppDimensions.spacing24),
                  _buildCategoriesSection(),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildPlantsGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.spacing12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bitkileri Keşfet',
                      style: GoogleFonts.poppins(
                        fontSize: AppDimensions.fontXXLarge,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '🌱 Yeni yeşil dostlarını bul',
                      style: GoogleFonts.poppins(
                        fontSize: AppDimensions.fontLarge,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing20,
              vertical: AppDimensions.spacing4,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.spacing8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                    size: AppDimensions.iconMedium,
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing16),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(
                      fontSize: AppDimensions.fontLarge,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Bitki, familya veya açıklama ara...',
                      hintStyle: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                        fontSize: AppDimensions.fontLarge,
                        fontWeight: FontWeight.w400,
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
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.spacing6),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                      ),
                      child: Icon(
                        Icons.clear_rounded,
                        color: AppColors.textSecondary,
                        size: AppDimensions.iconSmall,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
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
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
        SizedBox(
          height: 50,
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
      return Expanded(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.spacing24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 3,
                ),
                const SizedBox(height: AppDimensions.spacing16),
                Text(
                  'Bitkiler yükleniyor...',
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontMedium,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_filteredPlants.isEmpty) {
      return Expanded(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.spacing32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.spacing20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                  ),
                  child: Text(
                    '🔍',
                    style: GoogleFonts.poppins(fontSize: 48),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing20),
                Text(
                  _searchQuery.isNotEmpty 
                      ? 'Aradığınız bitki bulunamadı'
                      : 'Bu kategoride bitki bulunamadı',
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontLarge,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  'Farklı arama terimleri deneyin',
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontMedium,
                    color: AppColors.textSecondary.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing8,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Text(
              'Bitkiler (${_filteredPlants.length})',
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontHeading,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacing20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: AppDimensions.spacing16,
                mainAxisSpacing: AppDimensions.spacing16,
              ),
              itemCount: _filteredPlants.length,
              itemBuilder: (context, index) {
                final plant = _filteredPlants[index];
                return _buildModernPlantCard(plant, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernPlantCard(PlantEntity plant, int index) {
    final gradientColors = _categoryGradients[plant.category] ?? 
        [const Color(0xFFF5F5F5), const Color(0xFFFFFFFF)];
    
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: GestureDetector(
            onTap: () => _showPlantDetails(plant),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimensions.spacing12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.spacing12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                          ),
                          child: Text(
                            plant.emoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing8),
                        Flexible(
                          child: Text(
                            plant.name,
                            style: GoogleFonts.poppins(
                              fontSize: AppDimensions.fontMedium,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing4),
                        Text(
                          plant.category.displayName,
                          style: GoogleFonts.poppins(
                            fontSize: AppDimensions.fontSmall,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPlantDetails(PlantEntity plant) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.95),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXXLarge),
            topRight: Radius.circular(AppDimensions.radiusXXLarge),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXXLarge),
            topRight: Radius.circular(AppDimensions.radiusXXLarge),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.spacing12),
                  Center(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.textSecondary.withOpacity(0.3),
                            AppColors.textSecondary.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing24),
                  _buildPlantHeader(plant),
                  const SizedBox(height: AppDimensions.spacing24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildModernInfoGrid(plant),
                          const SizedBox(height: AppDimensions.spacing24),
                          _buildDescriptionSection(plant),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantHeader(PlantEntity plant) {
    final gradientColors = _categoryGradients[plant.category] ?? 
        [const Color(0xFFF5F5F5), const Color(0xFFFFFFFF)];
    
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                plant.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacing20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.name,
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontXXLarge,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing12,
                    vertical: AppDimensions.spacing4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                  ),
                  child: Text(
                    plant.category.displayName,
                    style: GoogleFonts.poppins(
                      fontSize: AppDimensions.fontMedium,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInfoGrid(PlantEntity plant) {
    final infoItems = [
      {'icon': '🔬', 'title': 'Familya', 'value': plant.family},
      {'icon': '🌡️', 'title': 'Sıcaklık', 'value': '${plant.idealTemperature}°C'},
      {'icon': '💧', 'title': 'Sulama', 'value': '${plant.wateringIntervalDays} günde bir'},
      {'icon': '🌱', 'title': 'Toprak', 'value': plant.soilType},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: AppDimensions.spacing12,
        mainAxisSpacing: AppDimensions.spacing12,
      ),
      itemCount: infoItems.length,
      itemBuilder: (context, index) {
        final item = infoItems[index];
        return Container(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacing8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.1),
                      AppColors.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Text(
                  item['icon']!,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: AppDimensions.spacing8),
              Text(
                item['title']!,
                style: GoogleFonts.poppins(
                  fontSize: AppDimensions.fontSmall,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                item['value']!,
                style: GoogleFonts.poppins(
                  fontSize: AppDimensions.fontMedium,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDescriptionSection(PlantEntity plant) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background.withOpacity(0.8),
            AppColors.background.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.spacing8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.1),
                            AppColors.primary.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                      ),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.primary,
                        size: AppDimensions.iconMedium,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacing12),
                    Text(
                      'Açıklama',
                      style: GoogleFonts.poppins(
                        fontSize: AppDimensions.fontHeading,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing16),
                Text(
                  plant.description,
                  style: GoogleFonts.poppins(
                    fontSize: AppDimensions.fontLarge,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                    height: 1.8,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: AppDimensions.bottomNavHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cardBackground,
            AppColors.cardBackground.withOpacity(0.95),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusXXLarge),
          topRight: Radius.circular(AppDimensions.radiusXXLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: AppDimensions.blurXLarge,
            offset: AppDimensions.shadowOffsetNegative,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusXXLarge),
          topRight: Radius.circular(AppDimensions.radiusXXLarge),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                      SnackBar(
                        content: const Text('Bahçe sayfası yakında geliyor!'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                        ),
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
                      SnackBar(
                        content: const Text('Profil sayfası yakında geliyor!'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 