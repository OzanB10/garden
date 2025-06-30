import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class AlertCardWidget extends StatelessWidget {
  const AlertCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.alertGradient,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(
          color: AppColors.alertIcon.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildAlertIcon(),
          const SizedBox(width: AppDimensions.spacing16),
          _buildAlertContent(),
        ],
      ),
    );
  }

  Widget _buildAlertIcon() {
    return Container(
      width: AppDimensions.alertIconSize,
      height: AppDimensions.alertIconSize,
      decoration: BoxDecoration(
        color: AppColors.alertIcon.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      child: const Icon(
        Icons.favorite_border_rounded,
        color: AppColors.alertIcon,
        size: AppDimensions.iconMedium,
      ),
    );
  }

  Widget _buildAlertContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.alertTitle,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontXXLarge,
              fontWeight: FontWeight.w600,
              color: AppColors.alertText,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            AppStrings.alertMessage,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontLarge,
              color: AppColors.alertTextSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
} 