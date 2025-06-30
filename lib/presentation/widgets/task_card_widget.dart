import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isCompleted;

  const TaskCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.taskCompleted : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: isCompleted 
              ? AppColors.primary.withOpacity(0.3) 
              : AppColors.taskBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: AppDimensions.blurMedium,
            offset: AppDimensions.shadowOffset,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTaskIcon(),
          const SizedBox(width: AppDimensions.spacing16),
          _buildTaskContent(),
        ],
      ),
    );
  }

  Widget _buildTaskIcon() {
    return Container(
      width: AppDimensions.taskIconSize,
      height: AppDimensions.taskIconSize,
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.primary : AppColors.taskIcon,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall + 1),
      ),
      child: Icon(
        isCompleted ? Icons.check_circle_rounded : icon,
        color: isCompleted ? Colors.white : AppColors.textSecondary,
        size: AppDimensions.iconMedium,
      ),
    );
  }

  Widget _buildTaskContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontXXLarge,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontMedium,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
} 