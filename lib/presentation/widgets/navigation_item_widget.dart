import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class NavigationItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const NavigationItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? AppColors.primary : AppColors.navInactive,
          size: AppDimensions.iconLarge,
        ),
        const SizedBox(height: AppDimensions.spacing4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontSmall,
            fontWeight: FontWeight.w500,
            color: isActive ? AppColors.primary : AppColors.navInactive,
          ),
        ),
      ],
    );
  }
} 