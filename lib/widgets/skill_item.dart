import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        skillColor = Colors.blue;
        skillIcon = Icons.code;
        break;
      case SkillCategory.language:
        skillColor = Colors.green;
        skillIcon = Icons.language;
        break;
      case SkillCategory.soft:
        skillColor = Colors.purple;
        skillIcon = Icons.psychology;
        break;
      case SkillCategory.tool:
        skillColor = Colors.orange;
        skillIcon = Icons.build;
        break;
      case SkillCategory.framework:
        skillColor = Colors.teal;
        skillIcon = Icons.widgets;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSmall,
        vertical: AppTheme.spacingSmall / 2,
      ),
      decoration: BoxDecoration(
        color: skillColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        border: Border.all(
          color: skillColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            skillIcon,
            size: 14,
            color: skillColor,
          ),
          const SizedBox(width: 6),
          Text(
            skill.name,
            style: AppTheme.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(width: 6),
          _buildLevelIndicator(skill.level, skillColor),
        ],
      ),
    ).animate().fadeIn(delay: delay).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          delay: delay,
          duration: 400.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildLevelIndicator(double level, Color color) {
    final int filledDots = (level * 4).round().clamp(0, 4);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < filledDots ? color : color.withOpacity(0.2),
          ),
        );
      }),
    );
  }
}
