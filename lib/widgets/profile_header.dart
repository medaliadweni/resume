import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final CVData data;

  const ProfileHeader({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileImage(context),
                const SizedBox(width: AppTheme.spacingLarge),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameAndTitle(context),
                      const SizedBox(height: AppTheme.spacingMedium),
                      _buildContactInfo(context),
                      const SizedBox(height: AppTheme.spacingMedium),
                      _buildSocialLinks(context),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _buildProfileImage(context),
                const SizedBox(height: AppTheme.spacingMedium),
                _buildNameAndTitle(context),
                const SizedBox(height: AppTheme.spacingMedium),
                _buildContactInfo(context),
                const SizedBox(height: AppTheme.spacingMedium),
                _buildSocialLinks(context),
              ],
            ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(
          begin: -0.1,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 4,
        ),
      ),
      child: data.photoUrl != null
          ? ClipOval(
              child: Image.asset(
                data.photoUrl!,
                fit: BoxFit.cover,
                width: 120,
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return _buildInitials();
                },
              ),
            )
          : _buildInitials(),
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.elasticOut,
        );
  }

  Widget _buildInitials() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.secondaryGradient,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          data.name.isNotEmpty ? data.name[0] : '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Widget _buildNameAndTitle(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          data.name,
          style: AppTheme.headingLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(
              begin: -0.2,
              end: 0,
              delay: 200.ms,
              duration: 600.ms,
              curve: Curves.easeOutQuad,
            ),
        const SizedBox(height: AppTheme.spacingSmall),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMedium,
            vertical: AppTheme.spacingXSmall,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
                spreadRadius: -5,
              ),
            ],
          ),
          child: Text(
            data.title,
            style: AppTheme.headingSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate().fadeIn(delay: 300.ms).slideX(
              begin: -0.2,
              end: 0,
              delay: 300.ms,
              duration: 600.ms,
              curve: Curves.easeOutQuad,
            ),
      ],
    );
  }
  
  Widget _buildContactInfo(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Wrap(
      spacing: AppTheme.spacing,
      runSpacing: AppTheme.spacingSmall,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        if (data.email.isNotEmpty)
          _buildContactItem(
            context,
            Icons.email_outlined,
            data.email,
            'mailto:${data.email}',
            delay: 400,
          ),
        if (data.phone.isNotEmpty)
          _buildContactItem(
            context,
            Icons.phone_outlined,
            data.phone,
            'tel:${data.phone}',
            delay: 500,
          ),
        if (data.location.isNotEmpty)
          _buildContactItem(
            context,
            Icons.location_on_outlined,
            data.location,
            null,
            delay: 600,
          ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    String? url, {
    required int delay,
  }) {
    final content = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.9),
            size: 18,
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Text(
            text,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          delay: delay.ms,
          duration: 400.ms,
          curve: Curves.easeOutBack,
        );

    if (url != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          child: content,
        ),
      );
    }

    return content;
  }

  Widget _buildSocialLinks(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Wrap(
      spacing: AppTheme.spacingSmall,
      runSpacing: AppTheme.spacingSmall,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        if (data.github?.isNotEmpty ?? false)
          _buildSocialLink(
            FontAwesomeIcons.github,
            'GitHub',
            'https://github.com/${data.github}',
            delay: 700,
          ),
        if (data.linkedin?.isNotEmpty ?? false)
          _buildSocialLink(
            FontAwesomeIcons.linkedin,
            'LinkedIn',
            'https://linkedin.com/in/${data.linkedin}',
            delay: 800,
          ),
      ],
    );
  }

  Widget _buildSocialLink(
    IconData icon,
    String label,
    String url, {
    required int delay,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
                spreadRadius: -5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(0.9),
                size: 16,
              ),
              const SizedBox(width: AppTheme.spacingXSmall),
              Text(
                label,
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: delay.ms).scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              delay: delay.ms,
              duration: 400.ms,
              curve: Curves.easeOutBack,
            ),
      ),
    );
  }
}
