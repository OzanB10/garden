import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class TipCardWidget extends StatelessWidget {
  const TipCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.tipGradient,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXLarge),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: AppDimensions.blurXLarge,
            offset: AppDimensions.shadowOffsetXLarge,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTipHeader(),
          const SizedBox(height: AppDimensions.spacing8),
          _buildTipContent(),
        ],
      ),
    );
  }

  Widget _buildTipHeader() {
    return Row(
      children: [
        const Text(
          AppStrings.tipIcon,
          style: TextStyle(fontSize: AppDimensions.iconMedium),
        ),
        const SizedBox(width: AppDimensions.spacing8),
        Text(
          AppStrings.tipTitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontTitle,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTipContent() {
    return Text(
      AppStrings.tipContent,
      style: GoogleFonts.poppins(
        fontSize: AppDimensions.fontLarge,
        color: Colors.white.withOpacity(0.9),
        height: 1.5,
      ),
    );
  }
} 