import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/cv_data.dart';
import '../theme/app_theme.dart';

class CertificatesSection extends StatelessWidget {
  final List<Certificate> certificates;

  const CertificatesSection({
    Key? key,
    required this.certificates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: certificates.asMap().entries.map((entry) {
        final index = entry.key;
        final certificate = entry.value;
        return _buildCertificateItem(context, certificate, index);
      }).toList(),
    );
  }

  Widget _buildCertificateItem(BuildContext context, Certificate certificate, int index) {
    return Container(
      margin:  const EdgeInsets.only(bottom: AppTheme.spacing),
      child: InkWell(
        onTap: certificate.url != null ? () {} : null, // Handle URL opening
        borderRadius: BorderRadius.circular(AppTheme.spacing),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.spacing),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCertificateIcon(context, certificate, index),
              const SizedBox(width: AppTheme.spacingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      certificate.name,
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      certificate.issuer,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    if (certificate.date != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.calendar,
                            size: 12,
                            color: AppTheme.textSecondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(certificate.date!),
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (certificate.url != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowUpRightFromSquare,
                      size: 14,
                      color: AppTheme.primaryColor,
                    ),
                    onPressed: () {
                      // Handle URL opening
                    },
                    tooltip: 'View Certificate',
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                    iconSize: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
        ).slideX(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildCertificateIcon(BuildContext context, Certificate certificate, int index) {
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
    ];
    
    final color = colors[index % colors.length];
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.spacing),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.certificate,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }
}
