import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
      margin: const EdgeInsets.only(bottom: AppTheme.spacing),
      child: InkWell(
        onTap: certificate.url != null 
            ? () async {
                final uri = Uri.parse(certificate.url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              } 
            : null,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
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
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 5),
                spreadRadius: -3,
              ),
            ],
            border: Border.all(
              color: _getCertificateColor(index).withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCertificateIcon(context, certificate, index),
              const SizedBox(width: AppTheme.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      certificate.name,
                      style: AppTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                        letterSpacing: 0.2,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXSmall),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingSmall,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getCertificateColor(index).withOpacity(0.15),
                                _getCertificateColor(index).withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusXLarge),
                            border: Border.all(
                              color: _getCertificateColor(index).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            certificate.issuer,
                            style: AppTheme.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: _getCertificateColor(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (certificate.date != null) ...[
                      const SizedBox(height: AppTheme.spacingSmall),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.calendar,
                              size: 10,
                              color: AppTheme.textSecondaryColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingSmall),
                          Text(
                            _formatDate(certificate.date!),
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondaryColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (certificate.description != null) ...[
                      const SizedBox(height: AppTheme.spacingSmall),
                      Text(
                        certificate.description!,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textSecondaryColor.withOpacity(0.9),
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (certificate.url != null)
                Container(
                  margin: const EdgeInsets.only(left: AppTheme.spacingSmall),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getCertificateColor(index).withOpacity(0.15),
                        _getCertificateColor(index).withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
                    border: Border.all(
                      color: _getCertificateColor(index).withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getCertificateColor(index).withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                        spreadRadius: -1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.arrowUpRightFromSquare,
                      size: 14,
                      color: _getCertificateColor(index),
                    ),
                    onPressed: () async {
                      final uri = Uri.parse(certificate.url!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    tooltip: 'View Certificate',
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
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
          delay: Duration(milliseconds: 100 * index + 100),
          duration: const Duration(milliseconds: 500),
        ).slideX(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 100 * index + 100),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildCertificateIcon(BuildContext context, Certificate certificate, int index) {
    final color = _getCertificateColor(index);
    
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.9),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Center(
        child: FaIcon(
          _getCertificateIcon(certificate),
          size: 22,
          color: Colors.white,
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .scaleXY(
       begin: 1.0,
       end: 1.05,
       duration: const Duration(seconds: 2),
       curve: Curves.easeInOut,
     );
  }

  Color _getCertificateColor(int index) {
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
  
  IconData _getCertificateIcon(Certificate certificate) {
    // Try to determine the icon based on certificate name or issuer
    final name = certificate.name.toLowerCase();
    final issuer = certificate.issuer.toLowerCase();
    
    if (name.contains('flutter') || issuer.contains('flutter')) {
      return FontAwesomeIcons.mobileScreen;
    } else if (name.contains('web') || issuer.contains('web')) {
      return FontAwesomeIcons.globe;
    } else if (name.contains('cloud') || issuer.contains('cloud') || 
               name.contains('aws') || issuer.contains('aws') ||
               name.contains('azure') || issuer.contains('azure')) {
      return FontAwesomeIcons.cloud;
    } else if (name.contains('data') || issuer.contains('data') ||
               name.contains('sql') || issuer.contains('sql')) {
      return FontAwesomeIcons.database;
    } else if (name.contains('security') || issuer.contains('security')) {
      return FontAwesomeIcons.shieldHalved;
    } else if (name.contains('agile') || issuer.contains('agile') ||
               name.contains('scrum') || issuer.contains('scrum')) {
      return FontAwesomeIcons.userGroup;
    } else {
      return FontAwesomeIcons.certificate;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
