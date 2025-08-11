#!/bin/bash

# 🚀 Deploy PRIME Documentation to GitHub Pages
# This script helps you deploy the documentation to GitHub

echo "======================================"
echo "🚀 PRIME Documentation GitHub Deployer"
echo "======================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install git first."
    exit 1
fi

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter repository name (default: prime-docs): " REPO_NAME
REPO_NAME=${REPO_NAME:-prime-docs}

echo ""
echo "📋 Configuration:"
echo "  Username: $GITHUB_USER"
echo "  Repository: $REPO_NAME"
echo "  URL will be: https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""

read -p "Is this correct? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "Cancelled."
    exit 0
fi

# Initialize git repository
echo ""
echo "📦 Initializing git repository..."
git init

# Update index.html with correct GitHub URL
echo "🔧 Updating GitHub links..."
sed -i "s|your-org/prime|$GITHUB_USER/prime|g" index.html
sed -i "s|YOUR-USERNAME|$GITHUB_USER|g" README.md
sed -i "s|your-username|$GITHUB_USER|g" README.md

# Create .nojekyll file to use custom HTML
echo "" > .nojekyll
echo "Created .nojekyll file for custom HTML"

# Add all files
echo "📝 Adding files to git..."
git add .

# Commit
echo "💾 Creating initial commit..."
git commit -m "🚀 Initial PRIME documentation

- Beautiful landing page with stats and features
- Complete technical documentation (775+ strategies)
- Getting started guide
- API reference structure
- GitHub Pages ready"

# Set main branch
git branch -M main

# Add remote
echo ""
echo "🌐 Setting up GitHub remote..."
echo "Remote URL: https://github.com/$GITHUB_USER/$REPO_NAME.git"
git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"

echo ""
echo "======================================"
echo "✅ Local setup complete!"
echo "======================================"
echo ""
echo "📌 Next steps:"
echo ""
echo "1. Create a new repository on GitHub:"
echo "   https://github.com/new"
echo "   Name: $REPO_NAME"
echo "   (Leave it empty, don't add README or .gitignore)"
echo ""
echo "2. Push the documentation:"
echo "   git push -u origin main"
echo ""
echo "3. Enable GitHub Pages:"
echo "   - Go to: https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "   - Source: Deploy from a branch"
echo "   - Branch: main"
echo "   - Folder: / (root)"
echo "   - Click Save"
echo ""
echo "4. Your site will be live at:"
echo "   https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""
echo "5. (Optional) Custom domain:"
echo "   - Add a CNAME file with your domain"
echo "   - Configure DNS settings"
echo ""
echo "======================================"
echo "📚 Documentation structure:"
echo "  - index.html         : Beautiful landing page"
echo "  - documentation.md   : Full PRIME documentation"  
echo "  - getting-started.md : Quick start guide"
echo "  - README.md          : Repository information"
echo "======================================"