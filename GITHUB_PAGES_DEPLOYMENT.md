# Deploying to GitHub Pages

This guide will help you deploy your Flutter web application to GitHub Pages.

## Prerequisites

- A GitHub account
- Git installed on your computer
- Your Flutter project (cvmed)

## Step 1: Create a GitHub Repository

1. Go to [GitHub](https://github.com) and sign in to your account
2. Click on the "+" icon in the top-right corner and select "New repository"
3. Name your repository "cvmed"
4. Choose whether to make it public or private
5. Click "Create repository"

## Step 2: Push Your Code to GitHub

Run the following commands in your project directory:

```bash
# Initialize Git repository (if not already done)
git init

# Add all files to staging
git add .

# Commit your changes
git commit -m "Initial commit"

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/cvmed.git

# Push your code to GitHub
git push -u origin main
```

Replace `YOUR_USERNAME` with your actual GitHub username.

## Step 3: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click on "Settings"
3. Scroll down to the "GitHub Pages" section
4. For the source, select "gh-pages" branch (this will be created by the GitHub Actions workflow)
5. Click "Save"

## Step 4: Wait for Deployment

The GitHub Actions workflow we've set up will automatically:
1. Build your Flutter web app
2. Deploy it to the gh-pages branch
3. Make it available at `https://YOUR_USERNAME.github.io/cvmed/`

This process usually takes 2-5 minutes after pushing to the main branch.

## Troubleshooting

If your deployment doesn't work:

1. Check the "Actions" tab in your GitHub repository to see if there are any errors
2. Make sure you've enabled GitHub Pages in the repository settings
3. Verify that the repository name matches the base-href in the build command (`/cvmed/`)

## Manual Deployment

If you prefer to deploy manually:

1. Build the web app locally:
   ```bash
   flutter build web --release --base-href /cvmed/
   ```

2. Create a new branch named gh-pages:
   ```bash
   git checkout -b gh-pages
   ```

3. Copy the contents of the build/web directory to the root of the gh-pages branch:
   ```bash
   cp -r build/web/* .
   ```

4. Commit and push the gh-pages branch:
   ```bash
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin gh-pages
   ```

5. Configure GitHub Pages to use the gh-pages branch in your repository settings.
