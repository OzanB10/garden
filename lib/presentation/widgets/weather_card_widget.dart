import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class WeatherCardWidget extends StatelessWidget {
  const WeatherCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.weatherGradient,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXLarge),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFED8936).withOpacity(0.15),
            blurRadius: AppDimensions.blurXLarge,
            offset: AppDimensions.shadowOffsetLarge,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeatherTitle(),
          const SizedBox(height: AppDimensions.spacing8),
          _buildTemperature(),
          _buildWeatherSubtitle(),
        ],
      ),
    );
  }

  Widget _buildWeatherTitle() {
    return Text(
      AppStrings.weatherTitle,
      style: GoogleFonts.poppins(
        fontSize: AppDimensions.fontXXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.weatherText,
      ),
    );
  }

  Widget _buildTemperature() {
    return Text(
      AppStrings.weatherTemperature,
      style: GoogleFonts.poppins(
        fontSize: AppDimensions.fontTemperature,
        fontWeight: FontWeight.w800,
        color: AppColors.weatherText,
      ),
    );
  }

  Widget _buildWeatherSubtitle() {
    return Text(
      AppStrings.weatherSubtitle,
      style: GoogleFonts.poppins(
        fontSize: AppDimensions.fontMedium,
        color: AppColors.weatherTextSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
} 