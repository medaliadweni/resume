# Modern CV App

A modern, elegant, and visually appealing CV application built with Flutter.

## Features

- **Clean, Modern Design**: Minimalistic design with well-structured sections
- **Responsive Layout**: Adapts to mobile, tablet, and desktop screens
- **Animated UI Elements**: Smooth animations for enhanced user experience
- **Comprehensive CV Sections**: 
  - Profile summary
  - Work experience
  - Education
  - Skills with proficiency levels
  - Projects
  - Languages
  - Interests
  - Certificates
- **Contact Information**: Easy access to contact details

## Screenshots

(Screenshots will be added here)

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Deployment to GitHub Pages

This project is configured for automatic deployment to GitHub Pages using GitHub Actions.

### Automatic Deployment

1. Push your changes to the `main` or `master` branch
2. GitHub Actions will automatically build and deploy your app to GitHub Pages
3. Your app will be available at `https://[your-username].github.io/resume/`

### Manual Deployment

If you prefer to deploy manually:

1. Build the web app: `flutter build web --release --base-href /resume/`
2. Navigate to your GitHub repository settings
3. Go to Pages section
4. Select the `gh-pages` branch and `/` (root) folder
5. Click Save

## Dependencies

- flutter_animate: For smooth animations
- font_awesome_flutter: For icons
- google_fonts: For typography
- glassmorphism: For modern glass effects
- url_launcher: For launching URLs
- flutter_svg: For SVG icons
- provider: For state management
- shared_preferences: For local storage

## Project Structure

- `lib/models/`: Data models for CV information
- `lib/screens/`: Main screens of the application
- `lib/theme/`: Theme configuration
- `lib/widgets/`: Reusable UI components

## Customization

You can customize your CV by modifying the sample data in `lib/models/cv_data.dart`.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
