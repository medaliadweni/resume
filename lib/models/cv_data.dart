import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert;
  
  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }
}

enum SkillCategory {
  technical,
  language,
  soft,
  tool,
  framework;
  
  String get displayName {
    switch (this) {
      case SkillCategory.technical:
        return 'Technical Skills';
      case SkillCategory.language:
        return 'Languages';
      case SkillCategory.soft:
        return 'Soft Skills';
      case SkillCategory.tool:
        return 'Tools';
      case SkillCategory.framework:
        return 'Frameworks';
    }
  }
}

class CVData {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String? photoUrl;
  final String summary;
  final List<SocialLink> socialLinks;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Skill> skills;
  final List<Project>? projects;
  final List<String>? languages;
  final List<String>? interests;
  final List<Certificate>? certificates;

  const CVData({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    this.photoUrl,
    required this.summary,
    this.socialLinks = const [],
    this.experiences = const [],
    this.education = const [],
    this.skills = const [],
    this.projects,
    this.languages,
    this.interests,
    this.certificates,
  });

  // Sample data for preview
  static CVData get sample => CVData(
    name: 'Mohamed Ali Adweni',
    title: 'Full-Stack Developer | Flutter & NestJS',
    email: 'mouhamedaliadoinii@gmail.com',
    phone: '01577 3627875',
    location: 'Bamberg, Germany',
    photoUrl: 'assets/images/profile.jpeg',
    summary: 'Highly skilled Full-Stack Developer specializing in Flutter and NestJS. Creates responsive, high-performance applications across mobile, web, and backend platforms. Delivers clean, optimized code with expertise in UI implementation and API development. Experienced in deploying applications to Google Play Store and App Store.',
    socialLinks: [
      const SocialLink(
        platform: 'LinkedIn',
        url: 'https://linkedin.com/in/mohamed-ali-adweni',
        icon: 'assets/icons/linkedin.svg',
      ),
      const SocialLink(
        platform: 'GitHub',
        url: 'https://github.com/adwenidev',
        icon: 'assets/icons/github.svg',
      ),
    ],
    experiences: [
      Experience(
        title: 'Full Stack Developer',
        company: 'ZETABOX',
        location: 'Sfax, Tunisia',
        startDate: DateTime(2023, 7, 1),
        endDate: null, // Present
        description: 'Full-time',
        achievements: [
          'Develop cross-platform applications (mobile, web, and desktop) using Flutter',
          'Design and integrate REST APIs with NestJS',
          'Translate Figma designs into responsive and pixel-perfect user interfaces',
          'Implement location-based features using Google Maps API',
          'Managed complete app deployment process for Google Play Store and App Store, including version updates and compliance requirements',
        ],
      ),
      Experience(
        title: 'Full Stack Developer - Internship',
        company: 'ZETABOX',
        location: 'Sfax, Tunisia',
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2023, 6, 30),
        description: 'Internship',
        achievements: [
          'Built a cross-platform appointment scheduling app using Flutter and Strapi',
          'Integrated real-time tracking, reminders, and Google Maps for client meetings',
          'Enhanced user profile functionalities and added valuable features to improve usability',
        ],
      ),
      Experience(
        title: 'Web Developer - Internship',
        company: 'DataSphere',
        location: 'Sfax, Tunisia',
        startDate: DateTime(2022, 1, 1),
        endDate: DateTime(2022, 2, 28),
        description: 'Internship',
        achievements: [
          'Developed web applications using Node.js and React.js',
          'Collaborated with the team to create dynamic and responsive web features',
        ],
      ),
      Experience(
        title: 'Python/Odoo Developer - Internship',
        company: 'Digidom',
        location: 'Sfax, Tunisia',
        startDate: DateTime(2021, 7, 1),
        endDate: DateTime(2021, 9, 30),
        description: 'Internship',
        achievements: [
          'Customized Odoo modules, including Sales, Subscriptions, Accounts, Contacts, CRM, and Website',
          'Designed and customized Odoo email templates and created new ones',
          'Developed Odoo views (Tree, Form, Kanban, Graph, Search)',
          'Developed and tailored Qweb PDF reports for various use cases',
          'Migrated Odoo modules to newer versions',
        ],
      ),
    ],
    education: [
      Education(
        degree: 'Bachelor\'s Degree in Mobile Application and Web Development',
        institution: 'Higher Institute of Technology Studies of Sfax',
        location: 'Sfax, Tunisia',
        startDate: DateTime(2020, 9, 1),
        endDate: DateTime(2023, 6, 30),
        gpa: null,
        achievements: [
          'Specialized in mobile and web application development',
          'Completed capstone project: Cross-platform appointment scheduling app',
        ],
        description: 'Bachelor\'s Degree in Mobile Application and Web Development',
      ),
      Education(
        degree: 'Baccalaureate, Computer Technology',
        institution: 'High school 18 january sfax',
        location: 'Sfax, Tunisia',
        startDate: DateTime(2018, 9, 1),
        endDate: DateTime(2019, 6, 30),
        gpa: null,
        achievements: [
          'Focused on computer science fundamentals and programming',
        ],
        description: 'Baccalaureate, Computer Technology',
      ),
    ],
    skills: [
      Skill(
        name: 'Flutter',
        category: SkillCategory.framework,
        level: 5,
        icon: 'assets/icons/flutter.svg',
      ),
      Skill(
        name: 'NestJS',
        category: SkillCategory.framework,
        level: 4,
        icon: 'assets/icons/nestjs.svg',
      ),
      Skill(
        name: 'Dart',
        category: SkillCategory.language,
        level: 5,
        icon: 'assets/icons/dart.svg',
      ),
      Skill(
        name: 'JavaScript',
        category: SkillCategory.language,
        level: 4,
        icon: 'assets/icons/javascript.svg',
      ),
      Skill(
        name: 'TypeScript',
        category: SkillCategory.language,
        level: 4,
        icon: 'assets/icons/typescript.svg',
      ),
      Skill(
        name: 'REST APIs',
        category: SkillCategory.technical,
        level: 4,
        icon: 'assets/icons/api.svg',
      ),
      Skill(
        name: 'Strapi',
        category: SkillCategory.framework,
        level: 3,
        icon: 'assets/icons/strapi.svg',
      ),
      Skill(
        name: 'GraphQL',
        category: SkillCategory.technical,
        level: 3,
        icon: 'assets/icons/graphql.svg',
      ),
      Skill(
        name: 'Firebase',
        category: SkillCategory.tool,
        level: 4,
        icon: 'assets/icons/firebase.svg',
      ),
      Skill(
        name: 'Google Maps API',
        category: SkillCategory.tool,
        level: 4,
        icon: 'assets/icons/google-maps.svg',
      ),
      Skill(
        name: 'Git',
        category: SkillCategory.tool,
        level: 4,
        icon: 'assets/icons/git.svg',
      ),
      Skill(
        name: 'Figma',
        category: SkillCategory.tool,
        level: 3,
        icon: 'assets/icons/figma.svg',
      ),
    ],
    languages: [
      'Arabic (Native)',
      'English (Fluent)',
      'French (Fluent)',
      'German (Basic)',
    ],
    interests: [
      'Travel',
      'Sports',
      'Fitness',
    ],
    projects: [
      Project(
        title: 'Appointment Scheduling App',
        description: 'A cross-platform application for scheduling and managing appointments with real-time tracking and reminders.',
        technologies: ['Flutter', 'Strapi', 'Google Maps API', 'Firebase'],
        url: 'https://github.com/adwenidev/appointment-app',
        imageUrl: 'assets/images/appointment-app.jpg',
      ),
      Project(
        title: 'E-commerce Mobile App',
        description: 'A feature-rich e-commerce application with product catalog, cart management, and secure payment processing.',
        technologies: ['Flutter', 'NestJS', 'Stripe API', 'Firebase'],
        url: 'https://github.com/adwenidev/ecommerce-app',
        imageUrl: 'assets/images/ecommerce-app.jpg',
      ),
    ],
  );
}

class Experience {
  final String title;
  final String company;
  final String location;
  final DateTime startDate;
  final DateTime? endDate; // null means "Present"
  final String description;
  final List<String> achievements;

  const Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.description,
    this.achievements = const [],
  });

  String get duration {
    final DateFormat formatter = DateFormat('MMM yyyy');
    final String start = formatter.format(startDate);
    final String end = endDate != null ? formatter.format(endDate!) : 'Present';
    return '$start - $end';
  }

  String get durationWithYears {
    final now = DateTime.now();
    final end = endDate ?? now;
    
    int years = end.year - startDate.year;
    int months = end.month - startDate.month;
    
    if (months < 0) {
      years--;
      months += 12;
    }
    
    String result = '';
    if (years > 0) {
      result += '$years ${years == 1 ? 'year' : 'years'}';
      if (months > 0) result += ', ';
    }
    if (months > 0 || years == 0) {
      result += '$months ${months == 1 ? 'month' : 'months'}';
    }
    
    return result;
  }
}

class Education {
  final String degree;
  final String institution;
  final String? location;
  final DateTime startDate;
  final DateTime? endDate;
  final String? gpa;
  final List<String>? achievements;
  final String? description;

  const Education({
    required this.degree,
    required this.institution,
    this.location,
    required this.startDate,
    this.endDate,
    this.gpa,
    this.achievements,
    this.description,
  });

  String get duration {
    final DateFormat formatter = DateFormat('MMM yyyy');
    final String start = formatter.format(startDate);
    final String end = endDate != null ? formatter.format(endDate!) : 'Present';
    return '$start - $end';
  }

  String get formattedDate {
    final DateFormat yearFormatter = DateFormat('yyyy');
    return '${yearFormatter.format(startDate)} - ${yearFormatter.format(endDate!)}';
  }
}

class Skill {
  final String name;
  final SkillCategory category;
  final double level;
  final String? icon;

  const Skill({
    required this.name,
    required this.category,
    required this.level,
    this.icon,
  });
}

class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? url;
  final String? imageUrl;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.url,
    this.imageUrl,
  });
}

class Certificate {
  final String name;
  final String issuer;
  final DateTime? date;
  final String? url;
  final String? description;

  const Certificate({
    required this.name,
    required this.issuer,
    this.date,
    this.url,
    this.description,
  });
}

class SocialLink {
  final String platform;
  final String url;
  final String icon;

  const SocialLink({
    required this.platform,
    required this.url,
    required this.icon,
  });
}
