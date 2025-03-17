import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';

class ProjectItem extends StatelessWidget {
  final Project project;
  final Duration delay;

  const ProjectItem({
    Key? key,
    required this.project,
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing),
      decoration: AppTheme.cardDecoration,
      child: InkWell(
        onTap: project.url != null ? () => _launchProjectUrl(project.url!) : null,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project image if available
            if (project.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.borderRadius),
                  topRight: Radius.circular(AppTheme.borderRadius),
                ),
                child: Image.asset(
                  project.imageUrl!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: AppTheme.headingSmall.copyWith(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Text(
                    project.description,
                    style: AppTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Wrap(
                    spacing: AppTheme.spacingSmall,
                    runSpacing: AppTheme.spacingSmall,
                    children: project.technologies.map((tech) => Chip(
                      label: Text(
                        tech,
                        style: AppTheme.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      side: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )).toList(),
                  ),
                  if (project.url != null) ...[
                    const SizedBox(height: AppTheme.spacingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _launchProjectUrl(project.url!),
                          icon: const Icon(Icons.link, size: 16),
                          label: const Text('View Project'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingSmall,
                              vertical: AppTheme.spacingSmall / 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay).slideY(
          begin: 0.2,
          end: 0,
          delay: delay,
          duration: 600.ms,
          curve: Curves.easeOutQuad,
        );
  }

  void _launchProjectUrl(String url) {
    // In a real app, you'd use url_launcher to open the URL
    debugPrint('Opening URL: $url');
  }
}
