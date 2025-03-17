import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';
import 'section_title.dart';
import 'skill_item.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;
  
  const SkillsSection({
    Key? key,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group skills by category
    final Map<SkillCategory, List<Skill>> groupedSkills = {};
    
    for (final skill in skills) {
      if (!groupedSkills.containsKey(skill.category)) {
        groupedSkills[skill.category] = [];
      }
      groupedSkills[skill.category]!.add(skill);
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       /**   const SectionTitle(
            title: 'Skills',
            icon: Icons.code,
            color: AppTheme.accentColor,
          ),
          const SizedBox(height: AppTheme.spacing),
          // Display skills by category
          ...groupedSkills.entries.map((entry) {
            final category = entry.key;
            final categorySkills = entry.value;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.displayName,
                  style: AppTheme.headingSmall.copyWith(
                    color: Theme.of(context).textTheme.titleMedium?.color,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                _buildSkillList(context, categorySkills),
                const SizedBox(height: AppTheme.spacing),
              ],
            );
          }).toList(),

          // Alternative layout - bullet points as in the image
          const SectionTitle(
            title: 'Skills (Alternative Layout)',
            icon: Icons.list,
            color: AppTheme.accentColor,
          ),
          const SizedBox(height: AppTheme.spacing),
        **/

          _buildBulletPointSkills(context),
        ],
      ),
    );
  }
  
  Widget _buildSkillList(BuildContext context, List<Skill> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        return _buildSkillItem(context, skill, index);
      }).toList(),
    );
  }
  
  Widget _buildSkillItem(BuildContext context, Skill skill, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: AppTheme.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.infoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildProgressBar(context, skill.level, index),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index));
  }

  Widget _buildProgressBar(BuildContext context, double level, int index) {
    final Color progressColor = _getProgressColor(level);
    
    return Stack(
      children: [
        // Background
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
          ),
        ),
        // Progress
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          height: 8,
          width: MediaQuery.of(context).size.width * level * 0.6, // Adjust multiplier based on parent width
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                progressColor.withOpacity(0.7),
                progressColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
            boxShadow: [
              BoxShadow(
                color: progressColor.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(), // This will make it pulse
        ).shimmer(
          duration: 2000.ms,
          color: Colors.white.withOpacity(0.2),
        ),
      ],
    ).animate().fadeIn(
          delay: Duration(milliseconds: 200 + (100 * index)),
          duration: const Duration(milliseconds: 500),
        ).slideX(
          begin: -0.2,
          end: 0,
          delay: Duration(milliseconds: 200 + (100 * index)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
        );
  }

  Color _getProgressColor(double level) {
    if (level >= 0.8) {
      return AppTheme.successColor;
    } else if (level >= 0.6) {
      return AppTheme.infoColor;
    } else if (level >= 0.4) {
      return AppTheme.warningColor;
    } else {
      return AppTheme.accentColor;
    }
  }
  
  Widget _buildBulletPointSkills(BuildContext context) {
    // This is the alternative layout shown in the image
    final skillCategories = {
      'Programming Languages': 'Dart, JavaScript',
      'Frameworks & Libraries': 'Flutter, NestJS',
      'Backend Development': 'REST APIs, Strapi, GraphQL',
      'Mobile Development': 'Cross-platform development (iOS, Android, Web, Desktop) with Flutter',
      'Database Management': 'MySQL, PostgreSQL, MongoDB, Firebase',
      'Version Control & Collaboration': 'Git, GitHub, GitLab, Bitbucket',
      'Cloud Services & Deployment': 'Firebase, Google Cloud, AWS, Docker, CI/CD pipelines',
      'API Integration': 'Google Maps API, Stripe API',
      'Development Tools': 'VS Code, Postman, Jira, Trello, Xcode, Android Studio',
    };
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillCategories.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: '${entry.key}: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: entry.value,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ).animate().fadeIn().slideY(
          begin: 0.2,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutQuad,
        );
  }
}
