import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';

class SkillItem extends StatelessWidget {
  final Skill skill;
  final Duration delay;

  const SkillItem({
    Key? key,
    required this.skill,
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color skillColor;
    IconData skillIcon;
    
    // Assign different colors based on skill category
    switch (skill.category) {
      case SkillCategory.technical:
        skillColor = AppTheme.primaryColor;
        skillIcon = FontAwesomeIcons.code;
        break;
      case SkillCategory.language:
        skillColor = AppTheme.successColor;
        skillIcon = FontAwesomeIcons.language;
        break;
      case SkillCategory.soft:
        skillColor = AppTheme.secondaryColor;
        skillIcon = FontAwesomeIcons.brain;
        break;
      case SkillCategory.tool:
        skillColor = AppTheme.warningColor;
        skillIcon = FontAwesomeIcons.screwdriverWrench;
        break;
      case SkillCategory.framework:
        skillColor = AppTheme.infoColor;
        skillIcon = FontAwesomeIcons.layerGroup;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            skillColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        border: Border.all(
          color: skillColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  skillColor.withOpacity(0.15),
                  skillColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              border: Border.all(
                color: skillColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: FaIcon(
              skillIcon,
              size: 12,
              color: skillColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            skill.name,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimaryColor,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 10),
          _buildLevelIndicator(skill.level, skillColor),
        ],
      ),
    ).animate().fadeIn(delay: delay).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          delay: delay,
          duration: 400.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildLevelIndicator(double level, Color color) {
    final int filledDots = (level * 5).round().clamp(0, 5);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(right: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < filledDots ? color : color.withOpacity(0.15),
            boxShadow: index < filledDots ? [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ] : null,
          ),
        );
      }),
    );
  }
}
