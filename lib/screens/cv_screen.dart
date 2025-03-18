import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';
import '../widgets/experience_item.dart';
import '../widgets/education_item.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_title.dart';
import '../widgets/skills_section.dart';

class CVScreen extends StatelessWidget {
  final CVData data;

  const CVScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundColor,
              AppTheme.backgroundColor.withOpacity(0.85),
              AppTheme.primaryColor.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppTheme.spacing),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ProfileHeader(data: data),
                      const SizedBox(height: AppTheme.spacingLarge),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing),
                sliver: isDesktop
                    ? _buildDesktopLayout(context, data)
                    : _buildMobileLayout(context, data),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingLarge),
                  child: _buildFooter(context),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to top or other action
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        ),
        child: const Icon(Icons.arrow_upward),
      ).animate().scale(
        begin: const Offset(0, 0),
        end: const Offset(1, 1),
        delay: 800.ms,
        duration: 400.ms,
        curve: Curves.elasticOut,
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, CVData data) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'About Me',
            icon: FontAwesomeIcons.userLarge,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: AppTheme.spacing),
          Text(
            data.summary,
            style: AppTheme.bodyLarge.copyWith(
              height: 1.7,
              color: AppTheme.textPrimaryColor.withOpacity(0.85),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          Wrap(
            spacing: AppTheme.spacingSmall,
            runSpacing: AppTheme.spacingSmall,
            children: [
              _buildSummaryTag(context, 'Full-Stack Developer', FontAwesomeIcons.code),
              _buildSummaryTag(context, 'Flutter Expert', FontAwesomeIcons.mobileScreen),
              _buildSummaryTag(context, 'Mobile & Web', FontAwesomeIcons.display),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(
          begin: 0.2,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildSummaryTag(BuildContext context, String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSmall,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accentColor.withOpacity(0.15),
            AppTheme.accentColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 14,
            color: AppTheme.accentColor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.accentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms).scale(
      begin: const Offset(0.9, 0.9),
      end: const Offset(1, 1),
      delay: 700.ms,
      duration: 300.ms,
      curve: Curves.easeOut,
    );
  }

  Widget _buildDesktopLayout(BuildContext context, CVData data) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column (2/3 width)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummarySection(context, data),
                const SizedBox(height: AppTheme.spacingLarge),
                _buildExperienceSection(context, data),
                const SizedBox(height: AppTheme.spacingLarge),
                _buildEducationSection(context, data),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacingLarge),
          // Right column (1/3 width)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSkillsSection(context, data),
                const SizedBox(height: AppTheme.spacingLarge),
                _buildCertificatesSection(context, data),
                const SizedBox(height: AppTheme.spacingLarge),
                _buildInterestsSection(context, data),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, CVData data) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummarySection(context, data),
          const SizedBox(height: AppTheme.spacingLarge),
          _buildSkillsSection(context, data),
          const SizedBox(height: AppTheme.spacingLarge),
          _buildExperienceSection(context, data),
          const SizedBox(height: AppTheme.spacingLarge),
          _buildEducationSection(context, data),
          const SizedBox(height: AppTheme.spacingLarge),
          _buildCertificatesSection(context, data),
          const SizedBox(height: AppTheme.spacingLarge),
          _buildInterestsSection(context, data),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context, CVData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -5,
              ),
            ],
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Experience',
                icon: FontAwesomeIcons.briefcase,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: AppTheme.spacing),
              ...List.generate(
                data.experiences.length,
                (index) => ExperienceItem(
                  experience: data.experiences[index],
                  delay: Duration(milliseconds: 100 * index),
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildEducationSection(BuildContext context, CVData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -5,
              ),
            ],
            border: Border.all(
              color: AppTheme.secondaryColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Education',
                icon: FontAwesomeIcons.graduationCap,
                color: AppTheme.secondaryColor,
              ),
              const SizedBox(height: AppTheme.spacing),
              ...List.generate(
                data.education.length,
                (index) => EducationItem(
                  education: data.education[index],
                  delay: Duration(milliseconds: 100 * index),
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildSkillsSection(BuildContext context, CVData data) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: AppTheme.infoColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Skills',
            icon: FontAwesomeIcons.lightbulb,
            color: AppTheme.infoColor,
          ),
          const SizedBox(height: AppTheme.spacing),
          SkillsSection(skills: data.skills),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildCertificatesSection(BuildContext context, CVData data) {
    if (data.certificates == null || data.certificates!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: AppTheme.successColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Certificates',
            icon: FontAwesomeIcons.certificate,
            color: AppTheme.successColor,
          ),
          const SizedBox(height: AppTheme.spacing),
          ...data.certificates!.asMap().entries.map((entry) {
            final index = entry.key;
            final certificate = entry.value;
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
                      color: AppTheme.successColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.successColor.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSmall),
                  Expanded(
                    child: Text(
                      certificate.name,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textPrimaryColor.withOpacity(0.9),
                      ),
                    ).animate().fadeIn(
                      delay: Duration(milliseconds: 100 * index + 500),
                      duration: 400.ms,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildInterestsSection(BuildContext context, CVData data) {
    if (data.interests == null || data.interests!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: AppTheme.warningColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Interests',
            icon: FontAwesomeIcons.heart,
            color: AppTheme.warningColor,
          ),
          const SizedBox(height: AppTheme.spacing),
          Wrap(
            spacing: AppTheme.spacingSmall,
            runSpacing: AppTheme.spacingSmall,
            children: data.interests!.asMap().entries.map((entry) {
              final index = entry.key;
              final interest = entry.value;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.warningColor.withOpacity(0.15),
                      AppTheme.warningColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
                  border: Border.all(
                    color: AppTheme.warningColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  interest,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.warningColor.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).animate().fadeIn(
                delay: Duration(milliseconds: 100 * index + 600),
                duration: 400.ms,
              ).scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1, 1),
                delay: Duration(milliseconds: 100 * index + 600),
                duration: 300.ms,
                curve: Curves.easeOut,
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: AppTheme.borderColor,
          thickness: 1,
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' 2023 Mohamed Ali Adweni',
              style: GoogleFonts.poppins(
                textStyle: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            Text(
              'Made with Flutter',
              style: GoogleFonts.poppins(
                textStyle: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 700.ms);
  }
}
