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
          if (isDesktop) const SizedBox(width: AppTheme.spacingMedium),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                border: Border.all(
                  color: AppTheme.secondaryColor.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: AppTheme.spacingMedium),
                  _buildInstitutionInfo(context),
                  const SizedBox(height: AppTheme.spacingMedium),
                  if (education.description != null) ...[
                    _buildDescription(context),
                    const SizedBox(height: AppTheme.spacingMedium),
                  ],
                  if (education.achievements != null && education.achievements!.isNotEmpty) ...[
                    _buildAchievements(context),
                  ],
                ],
              ),
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
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.secondaryColor,
                AppTheme.secondaryColor.withOpacity(0.7),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondaryColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: -2,
              ),
            ],
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
          ),
        ),
        Container(
          width: 2,
          height: 150, // Adjust based on content
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.secondaryColor.withOpacity(0.5),
                AppTheme.secondaryColor.withOpacity(0.1),
              ],
            ),
          ),
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
              letterSpacing: 0.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingSmall,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.secondaryColor.withOpacity(0.15),
                AppTheme.secondaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
            border: Border.all(
              color: AppTheme.secondaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade100,
                Colors.grey.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: const FaIcon(
            FontAwesomeIcons.school,
            size: 16,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(width: AppTheme.spacingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.institution,
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              if (education.location != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.locationDot,
                        size: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        education.location!,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.grey.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Text(
        education.description!,
        style: AppTheme.bodyMedium.copyWith(
          height: 1.7,
          color: AppTheme.textPrimaryColor.withOpacity(0.8),
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingSmall,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.infoColor.withOpacity(0.15),
                AppTheme.infoColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
            border: Border.all(
              color: AppTheme.infoColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            'Achievements & Activities',
            style: AppTheme.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.infoColor,
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        ...education.achievements!.asMap().entries.map((entry) {
          final index = entry.key;
          final achievement = entry.value;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.infoColor,
                        AppTheme.infoColor.withOpacity(0.7),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.infoColor.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    achievement,
                    style: AppTheme.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppTheme.textPrimaryColor.withOpacity(0.85),
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: delay.inMilliseconds + 100 * index))
           .slideX(
             begin: 0.05,
             end: 0,
             delay: Duration(milliseconds: delay.inMilliseconds + 100 * index),
             duration: 400.ms,
             curve: Curves.easeOutQuad,
           );
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
