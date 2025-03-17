import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';

class EducationItem extends StatelessWidget {
  final Education education;
  final Duration delay;

  const EducationItem({
    Key? key,
    required this.education,
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) _buildTimelineDot(),
          if (isDesktop) const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: AppTheme.spacingSmall),
                _buildInstitutionInfo(context),
                const SizedBox(height: AppTheme.spacingSmall),
                if (education.description != null) ...[
                  _buildDescription(context),
                  const SizedBox(height: AppTheme.spacingSmall),
                ],
                if (education.achievements != null && education.achievements!.isNotEmpty) ...[
                  _buildAchievements(context),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay).slideY(
          begin: 0.1,
          end: 0,
          delay: delay,
          duration: 600.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildTimelineDot() {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            gradient: AppTheme.secondaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        Container(
          width: 2,
          height: 100, // Adjust based on content
          color: AppTheme.borderColor,
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            education.degree,
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingSmall,
            vertical: 4,
          ),
          decoration: AppTheme.getBadgeDecoration(color: AppTheme.secondaryColor),
          child: Text(
            _formatDateRange(education.startDate, education.endDate),
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstitutionInfo(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: const FaIcon(
            FontAwesomeIcons.school,
            size: 14,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(width: AppTheme.spacingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.institution,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              if (education.location != null)
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.locationDot,
                      size: 12,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      education.location!,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      education.description!,
      style: AppTheme.bodyMedium.copyWith(
        height: 1.6,
        color: AppTheme.textPrimaryColor.withOpacity(0.8),
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements & Activities:',
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXSmall),
        ...education.achievements!.asMap().entries.map((entry) {
          final index = entry.key;
          final achievement = entry.value;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    achievement,
                    style: AppTheme.bodyMedium.copyWith(
                      height: 1.5,
                      color: AppTheme.textPrimaryColor.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: delay.inMilliseconds + 100 * index));
        }).toList(),
      ],
    );
  }

  String _formatDateRange(DateTime startDate, DateTime? endDate) {
    final dateFormat = DateFormat('MMM yyyy');
    final start = dateFormat.format(startDate);
    final end = endDate != null ? dateFormat.format(endDate) : 'Present';
    return '$start - $end';
  }
}
