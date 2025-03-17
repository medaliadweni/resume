import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class InterestsSection extends StatelessWidget {
  final List<String> interests;

  const InterestsSection({
    Key? key,
    required this.interests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppTheme.spacingSmall,
      runSpacing: AppTheme.spacingSmall,
      children: interests.asMap().entries.map((entry) {
        final index = entry.key;
        final interest = entry.value;
        return _buildInterestChip(context, interest, index);
      }).toList(),
    );
  }

  Widget _buildInterestChip(BuildContext context, String interest, int index) {
    final iconData = _getIconForInterest(interest);
    final color = _getColorForIndex(index);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // Optional interaction
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  iconData,
                  size: 14,
                  color: color,
                ),
                const SizedBox(width: 6),
                Text(
                  interest,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
        ).scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
        );
  }

  IconData _getIconForInterest(String interest) {
    final lowercaseInterest = interest.toLowerCase();
    
    if (lowercaseInterest.contains('travel') || lowercaseInterest.contains('touring')) {
      return FontAwesomeIcons.plane;
    } else if (lowercaseInterest.contains('read') || lowercaseInterest.contains('book')) {
      return FontAwesomeIcons.book;
    } else if (lowercaseInterest.contains('music') || lowercaseInterest.contains('singing')) {
      return FontAwesomeIcons.music;
    } else if (lowercaseInterest.contains('cook') || lowercaseInterest.contains('food')) {
      return FontAwesomeIcons.utensils;
    } else if (lowercaseInterest.contains('sport') || lowercaseInterest.contains('fitness') || 
              lowercaseInterest.contains('gym') || lowercaseInterest.contains('workout')) {
      return FontAwesomeIcons.dumbbell;
    } else if (lowercaseInterest.contains('photo') || lowercaseInterest.contains('camera')) {
      return FontAwesomeIcons.camera;
    } else if (lowercaseInterest.contains('paint') || lowercaseInterest.contains('art')) {
      return FontAwesomeIcons.paintbrush;
    } else if (lowercaseInterest.contains('code') || lowercaseInterest.contains('program')) {
      return FontAwesomeIcons.code;
    } else if (lowercaseInterest.contains('game') || lowercaseInterest.contains('gaming')) {
      return FontAwesomeIcons.gamepad;
    } else if (lowercaseInterest.contains('hik') || lowercaseInterest.contains('mountain')) {
      return FontAwesomeIcons.mountain;
    } else if (lowercaseInterest.contains('swim') || lowercaseInterest.contains('water')) {
      return FontAwesomeIcons.personSwimming;
    } else if (lowercaseInterest.contains('cycle') || lowercaseInterest.contains('bike')) {
      return FontAwesomeIcons.bicycle;
    } else if (lowercaseInterest.contains('chess') || lowercaseInterest.contains('strategy')) {
      return FontAwesomeIcons.chess;
    } else if (lowercaseInterest.contains('film') || lowercaseInterest.contains('movie')) {
      return FontAwesomeIcons.film;
    } else if (lowercaseInterest.contains('write') || lowercaseInterest.contains('blog')) {
      return FontAwesomeIcons.pencil;
    } else {
      // Default icon for other interests
      return FontAwesomeIcons.star;
    }
  }

  Color _getColorForIndex(int index) {
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
      AppTheme.successColor,
      AppTheme.warningColor,
    ];
    
    return colors[index % colors.length];
  }
}
