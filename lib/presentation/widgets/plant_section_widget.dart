 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../domain/entities/plant_entity.dart';
import 'plant_card_widget.dart';

class PlantSectionWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<PlantEntity> plants;
  final VoidCallback? onViewAllTap;

  const PlantSectionWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.plants,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        if (subtitle != null) ...[
          const SizedBox(height: AppDimensions.spacing6),
          _buildSubtitle(),
        ],
        const SizedBox(height: AppDimensions.spacing18),
        _buildPlantsList(),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontHeading,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (onViewAllTap != null)
          GestureDetector(
            onTap: onViewAllTap,
            child: Text(
              'Hepsini Gör',
              style: GoogleFonts.poppins(
                fontSize: AppDimensions.fontLarge,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle!,
      style: GoogleFonts.poppins(
        fontSize: AppDimensions.fontLarge,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildPlantsList() {
    return SizedBox(
      height: AppDimensions.plantCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return PlantCardWidget(
            plantName: plant.name,
            emoji: plant.emoji,
            backgroundColor: _getPlantCardColor(plant.category),
          );
        },
      ),
    );
  }

  Color _getPlantCardColor(PlantCategory category) {
    switch (category) {
      case PlantCategory.fruits:
        return AppColors.plantCard4; // Orange tones
      case PlantCategory.vegetables:
        return AppColors.plantCard2; // Green tones
      case PlantCategory.flowers:
        return AppColors.plantCard3; // Pink tones
      case PlantCategory.herbs:
        return AppColors.plantCard2; // Green tones
      case PlantCategory.succulents:
        return AppColors.plantCard1; // Teal tones
      case PlantCategory.trees:
        return const Color(0xFFEDF2F7); // Gray tones
    }
  }
}