import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/alert_card_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/navigation_item_widget.dart';
import '../widgets/plant_card_widget.dart';
import '../widgets/task_card_widget.dart';
import '../widgets/tip_card_widget.dart';
import '../widgets/weather_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spacing24),
              const HeaderWidget(),
              const SizedBox(height: AppDimensions.spacing28),
              const WeatherCardWidget(),
              const SizedBox(height: AppDimensions.spacing32),
              _buildMyPlantsSection(),
              const SizedBox(height: AppDimensions.spacing28),
              _buildTodayTasksSection(),
              const SizedBox(height: AppDimensions.spacing26),
              const AlertCardWidget(),
              const SizedBox(height: AppDimensions.spacing32),
              const TipCardWidget(),
              const SizedBox(height: AppDimensions.spacing100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildMyPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.plantsTitle,
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontHeading,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              AppStrings.plantsCount,
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontLarge,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing18),
        SizedBox(
          height: AppDimensions.plantCardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              final plants = _getPlantsList();
              final plant = plants[index];
              return PlantCardWidget(
                plantName: plant['name']!,
                healthStatus: plant['health']!,
                emoji: plant['image']!,
                backgroundColor: plant['color'] as Color,
              );
            },
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getPlantsList() {
    return [
      {
        'name': AppStrings.snakePlant,
        'health': AppStrings.newLeaf,
        'image': '🐍',
        'color': AppColors.plantCard1,
      },
      {
        'name': AppStrings.zzPlant,
        'health': AppStrings.needsWater,
        'image': '🌿',
        'color': AppColors.plantCard2,
      },
      {
        'name': AppStrings.peaceLily,
        'health': AppStrings.lovingSun,
        'image': '🕊️',
        'color': AppColors.plantCard3,
      },
      {
        'name': AppStrings.cactus,
        'health': AppStrings.growthMode,
        'image': '🌵',
        'color': AppColors.plantCard4,
      },
    ];
  }

  Widget _buildTodayTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.tasksTitle,
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontHeading,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const Text(
              AppStrings.tasksEmoji,
              style: TextStyle(fontSize: AppDimensions.spacing20),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing6),
        Text(
          AppStrings.tasksSubtitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontLarge,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing18),
        _buildTasksList(),
      ],
    );
  }

  Widget _buildTasksList() {
    final tasks = _getTasksList();
    return Column(
      children: tasks.map((task) {
        final index = tasks.indexOf(task);
        return Column(
          children: [
            TaskCardWidget(
              title: task['title']!,
              subtitle: task['subtitle']!,
              icon: task['icon'] as IconData,
              isCompleted: task['isCompleted'] as bool,
            ),
            if (index < tasks.length - 1)
              const SizedBox(height: AppDimensions.spacing14),
          ],
        );
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _getTasksList() {
    return [
      {
        'title': AppStrings.waterTask,
        'subtitle': AppStrings.waterTaskDescription,
        'icon': Icons.water_drop_rounded,
        'isCompleted': false,
      },
      {
        'title': AppStrings.cleanTask,
        'subtitle': AppStrings.cleanTaskDescription,
        'icon': Icons.cleaning_services_rounded,
        'isCompleted': true,
      },
      {
        'title': AppStrings.fertilizeTask,
        'subtitle': AppStrings.fertilizeTaskDescription,
        'icon': Icons.eco_rounded,
        'isCompleted': false,
      },
    ];
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
              isActive: true,
            ),
            NavigationItemWidget(
              icon: Icons.search_rounded,
              label: AppStrings.navDiscover,
              isActive: false,
            ),
            NavigationItemWidget(
              icon: Icons.camera_alt_rounded,
              label: AppStrings.navGarden,
              isActive: false,
            ),
            NavigationItemWidget(
              icon: Icons.person_rounded,
              label: AppStrings.navProfile,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
} 