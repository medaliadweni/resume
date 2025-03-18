import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
   /**       const SectionTitle(
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
          const SizedBox(height: AppTheme.spacing), **/
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
      padding: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
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
                  letterSpacing: 0.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getProgressColor(skill.level).withOpacity(0.15),
                      _getProgressColor(skill.level).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
                  border: Border.all(
                    color: _getProgressColor(skill.level).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${(skill.level * 100).toInt()}%',
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _getProgressColor(skill.level),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildProgressBar(context, skill.level, index),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms);
  }

  Widget _buildProgressBar(BuildContext context, double level, int index) {
    final Color progressColor = _getProgressColor(level);
    
    return Stack(
      children: [
        // Background
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        // Progress
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          height: 10,
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
          color: Colors.white.withOpacity(0.3),
        ),
      ],
    ).animate().fadeIn(
          delay: (200 + (100 * index)).ms,
          duration: const Duration(milliseconds: 500),
        ).slideX(
          begin: -0.2,
          end: 0,
          delay: (200 + (100 * index)).ms,
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
      'Programming Languages': 'Dart, JavaScript, TypeScript, Python, Java, Kotlin, Swift',
      'Frameworks & Libraries': 'Flutter, React, Angular, Vue.js, NestJS, Express.js',
      'Backend Development': 'REST APIs, GraphQL, Node.js, Django, Spring Boot, Strapi',
      'Mobile Development': 'Cross-platform development (iOS, Android, Web, Desktop) with Flutter',
      'Database Management': 'MySQL, PostgreSQL, MongoDB, Firebase, SQLite, Redis',
      'Version Control & Collaboration': 'Git, GitHub, GitLab, Bitbucket, Jira, Confluence',
      'Cloud Services & Deployment': 'Firebase, Google Cloud, AWS, Azure, Docker, Kubernetes, CI/CD pipelines',
      'API Integration': 'Google Maps API, Stripe API, Social Media APIs, Payment Gateways',
      'Development Tools': 'VS Code, Android Studio, Xcode, Postman, Figma, Adobe XD',
    };
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildSkillCategoryItems(skillCategories),
    );
  }
  
  List<Widget> _buildSkillCategoryItems(Map<String, String> skillCategories) {
    final List<Widget> items = [];
    
    int index = 0;
    for (final entry in skillCategories.entries) {
      items.add(
        _buildSkillCategoryItem(entry.key, entry.value, index),
      );
      index++;
    }
    
    return items;
  }
  
  Widget _buildSkillCategoryItem(String category, String skills, int index) {
    // Use fixed delays that are guaranteed to be positive
    final fixedDelay = 50.ms * (index + 1);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
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
            color: _getCategoryColor(category).withOpacity(0.1),
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getCategoryColor(category).withOpacity(0.15),
                        _getCategoryColor(category).withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                    border: Border.all(
                      color: _getCategoryColor(category).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: FaIcon(
                    _getCategoryIcon(category),
                    size: 16,
                    color: _getCategoryColor(category),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                Expanded(
                  child: Text(
                    category,
                    style: AppTheme.headingSmall.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimaryColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.only(left: AppTheme.spacingMedium),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: _getCategoryColor(category).withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                skills,
                style: AppTheme.bodyMedium.copyWith(
                  height: 1.6,
                  color: AppTheme.textPrimaryColor.withOpacity(0.85),
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    )
    .animate()
    .fadeIn(delay: fixedDelay, duration: 500.ms)
    .slideY(
      begin: 0.1,
      end: 0,
      delay: fixedDelay,
      duration: 500.ms,
      curve: Curves.easeOutQuad,
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Programming Languages':
        return AppTheme.primaryColor;
      case 'Frameworks & Libraries':
        return AppTheme.secondaryColor;
      case 'Backend Development':
        return AppTheme.infoColor;
      case 'Mobile Development':
        return AppTheme.accentColor;
      case 'Database Management':
        return AppTheme.successColor;
      case 'Version Control & Collaboration':
        return AppTheme.warningColor;
      case 'Cloud Services & Deployment':
        return Colors.indigo;
      case 'API Integration':
        return Colors.teal;
      case 'Development Tools':
        return Colors.deepPurple;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Programming Languages':
        return FontAwesomeIcons.code;
      case 'Frameworks & Libraries':
        return FontAwesomeIcons.layerGroup;
      case 'Backend Development':
        return FontAwesomeIcons.server;
      case 'Mobile Development':
        return FontAwesomeIcons.mobileScreen;
      case 'Database Management':
        return FontAwesomeIcons.database;
      case 'Version Control & Collaboration':
        return FontAwesomeIcons.codeBranch;
      case 'Cloud Services & Deployment':
        return FontAwesomeIcons.cloud;
      case 'API Integration':
        return FontAwesomeIcons.plug;
      case 'Development Tools':
        return FontAwesomeIcons.screwdriverWrench;
      default:
        return FontAwesomeIcons.code;
    }
  }
}
