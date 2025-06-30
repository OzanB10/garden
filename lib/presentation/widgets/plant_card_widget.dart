import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class PlantCardWidget extends StatelessWidget {
  final String plantName;
  final String emoji;
  final Color backgroundColor;

  const PlantCardWidget({
    super.key,
    required this.plantName,
    required this.emoji,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.plantCardWidth,
      margin: const EdgeInsets.only(right: AppDimensions.spacing16),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: AppDimensions.blurLarge,
            offset: AppDimensions.shadowOffsetMedium,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPlantImage(),
          const SizedBox(height: AppDimensions.spacing14),
          _buildPlantName(),
        ],
      ),
    );
  }

  Widget _buildPlantImage() {
    return Container(
      width: AppDimensions.plantImageSize,
      height: AppDimensions.plantImageSize,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: AppDimensions.iconEmoji),
        ),
      ),
    );
  }

  Widget _buildPlantName() {
    return Text(
      plantName,
      style: GoogleFonts.poppins(
        fontSize: AppDimensions.fontXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }
} 