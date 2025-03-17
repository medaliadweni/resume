import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppTheme.darkGradient,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingLarge),
        child: isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    ).animate().fadeIn().slideY(
          begin: -0.2,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOutQuad,
        );
  }
  
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(),
        const SizedBox(width: AppTheme.spacingLarge),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameAndTitle(context),
              const SizedBox(height: AppTheme.spacingLarge),
              _buildContactInfo(context),
              const SizedBox(height: AppTheme.spacingLarge),
              _buildSocialLinks(context),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(),
        const SizedBox(height: AppTheme.spacingLarge),
        _buildNameAndTitle(context),
        const SizedBox(height: AppTheme.spacingLarge),
        _buildContactInfo(context),
        const SizedBox(height: AppTheme.spacingLarge),
        _buildSocialLinks(context),
      ],
    );
  }
  
  Widget _buildProfileImage() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        image: data.photoUrl != null
            ? DecorationImage(
                image: AssetImage(data.photoUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: data.photoUrl == null
          ? Center(
              child: Text(
                data.name.isNotEmpty ? data.name[0] : '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.elasticOut,
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
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
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
            horizontal: AppTheme.spacingSmall,
            vertical: AppTheme.spacingXSmall,
          ),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
            border: Border.all(
              color: AppTheme.accentColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            data.title,
            style: AppTheme.headingSmall.copyWith(
              color: Colors.white.withOpacity(0.9),
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
        _buildContactItem(
          context,
          Icons.email_outlined,
          data.email,
          'mailto:${data.email}',
        ),
        _buildContactItem(
          context,
          Icons.phone_outlined,
          data.phone,
          'tel:${data.phone}',
        ),
        _buildContactItem(
          context,
          Icons.location_on_outlined,
          data.location,
          null,
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }
  
  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    String? url,
  ) {
    return InkWell(
      onTap: url != null ? () => _launchUrl(url) : null,
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing,
          vertical: AppTheme.spacingSmall,
        ),
        decoration: AppTheme.glassCardDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSocialLinks(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Wrap(
      spacing: AppTheme.spacingSmall,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: data.socialLinks.map((link) {
        return Container(
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => _launchUrl(link.url),
            icon: Icon(
              _getSocialIcon(link.platform),
              color: Colors.white,
            ),
            tooltip: link.platform,
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            padding: EdgeInsets.zero,
            iconSize: 22,
          ),
        );
      }).toList(),
    ).animate().fadeIn(delay: 500.ms);
  }
  
  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'github':
        return FontAwesomeIcons.github;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'medium':
        return FontAwesomeIcons.medium;
      case 'dribbble':
        return FontAwesomeIcons.dribbble;
      case 'behance':
        return FontAwesomeIcons.behance;
      default:
        return FontAwesomeIcons.link;
    }
  }
  
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
