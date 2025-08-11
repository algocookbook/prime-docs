#!/bin/bash

# GitHub Repository Setup Script for PRIME Documentation
# This script helps configure and push the documentation to GitHub

echo "================================================"
echo "       PRIME Documentation GitHub Setup"
echo "================================================"
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ] || [ ! -f "_config.yml" ]; then
    echo "❌ Error: Not in the prime-docs directory!"
    echo "Please run this script from /home/opc/taco-maker/prime-docs/"
    exit 1
fi

# Function to check if GitHub CLI is available
check_gh_cli() {
    if command -v gh &> /dev/null; then
        echo "✅ GitHub CLI found"
        return 0
    else
        echo "⚠️  GitHub CLI not found"
        return 1
    fi
}

# Function to create repository using GitHub CLI
create_with_gh() {
    echo ""
    echo "Creating repository with GitHub CLI..."
    echo ""
    
    read -p "Enter repository name (default: prime-docs): " REPO_NAME
    REPO_NAME=${REPO_NAME:-prime-docs}
    
    read -p "Make repository public? (y/n, default: y): " IS_PUBLIC
    IS_PUBLIC=${IS_PUBLIC:-y}
    
    if [ "$IS_PUBLIC" = "y" ]; then
        VISIBILITY="--public"
    else
        VISIBILITY="--private"
    fi
    
    echo ""
    echo "Creating repository '$REPO_NAME'..."
    gh repo create "$REPO_NAME" $VISIBILITY --source=. --remote=origin --push
    
    if [ $? -eq 0 ]; then
        echo "✅ Repository created and pushed successfully!"
        echo ""
        echo "Enabling GitHub Pages..."
        gh repo edit --enable-pages
        echo ""
        echo "🎉 Your documentation will be available at:"
        echo "https://$(gh api user -q .login).github.io/$REPO_NAME/"
    else
        echo "❌ Failed to create repository"
        return 1
    fi
}

# Function to manually configure remote
manual_setup() {
    echo ""
    echo "Manual GitHub Setup"
    echo "==================="
    echo ""
    echo "Step 1: Create a new repository on GitHub"
    echo "---------------------------------------"
    echo "1. Go to: https://github.com/new"
    echo "2. Repository name: prime-docs (or your choice)"
    echo "3. Description: PRIME Trading Intelligence Documentation"
    echo "4. Choose Public or Private"
    echo "5. DO NOT initialize with README, .gitignore, or license"
    echo "6. Click 'Create repository'"
    echo ""
    read -p "Press Enter when you've created the repository..."
    echo ""
    
    echo "Step 2: Configure Git Remote"
    echo "----------------------------"
    echo ""
    read -p "Enter your GitHub username: " GITHUB_USER
    read -p "Enter repository name (default: prime-docs): " REPO_NAME
    REPO_NAME=${REPO_NAME:-prime-docs}
    
    echo ""
    echo "Choose connection method:"
    echo "1) HTTPS (recommended for beginners)"
    echo "2) SSH (requires SSH key setup)"
    read -p "Enter choice (1 or 2): " CONNECTION_METHOD
    
    if [ "$CONNECTION_METHOD" = "2" ]; then
        REMOTE_URL="git@github.com:$GITHUB_USER/$REPO_NAME.git"
    else
        REMOTE_URL="https://github.com/$GITHUB_USER/$REPO_NAME.git"
    fi
    
    echo ""
    echo "Adding remote: $REMOTE_URL"
    git remote add origin "$REMOTE_URL"
    
    if [ $? -eq 0 ]; then
        echo "✅ Remote added successfully"
    else
        echo "⚠️  Remote might already exist, updating..."
        git remote set-url origin "$REMOTE_URL"
    fi
    
    echo ""
    echo "Step 3: Push to GitHub"
    echo "----------------------"
    echo ""
    echo "Pushing to GitHub..."
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Successfully pushed to GitHub!"
        echo ""
        echo "Step 4: Enable GitHub Pages"
        echo "---------------------------"
        echo "1. Go to: https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
        echo "2. Under 'Source', select 'Deploy from a branch'"
        echo "3. Choose 'main' branch and '/ (root)' folder"
        echo "4. Click 'Save'"
        echo ""
        echo "Your documentation will be available at:"
        echo "https://$GITHUB_USER.github.io/$REPO_NAME/"
    else
        echo ""
        echo "❌ Push failed. Common solutions:"
        echo ""
        echo "1. If using HTTPS, you might need a Personal Access Token:"
        echo "   - Go to GitHub Settings → Developer settings → Personal access tokens"
        echo "   - Generate new token with 'repo' scope"
        echo "   - Use the token as your password when prompted"
        echo ""
        echo "2. If using SSH, ensure your SSH key is set up:"
        echo "   - Check: ssh -T git@github.com"
        echo "   - Setup guide: https://docs.github.com/en/authentication/connecting-to-github-with-ssh"
        echo ""
        echo "3. Try pushing again with:"
        echo "   git push -u origin main"
    fi
}

# Main execution
echo "Current repository status:"
echo "--------------------------"
git status --short
echo ""
echo "Files to be pushed:"
echo "------------------"
ls -lh *.{html,md,yml} 2>/dev/null | awk '{print $9, "("$5")"}'
echo ""

# Check for existing remote
if git remote get-url origin &>/dev/null; then
    echo "⚠️  Remote 'origin' already exists:"
    git remote get-url origin
    echo ""
    read -p "Do you want to push to this remote? (y/n): " USE_EXISTING
    
    if [ "$USE_EXISTING" = "y" ]; then
        echo "Pushing to existing remote..."
        git push -u origin main
        if [ $? -eq 0 ]; then
            echo "✅ Successfully pushed!"
        else
            echo "❌ Push failed. See error above for details."
        fi
        exit 0
    else
        echo "Removing existing remote..."
        git remote remove origin
    fi
fi

# Check for GitHub CLI
if check_gh_cli; then
    echo ""
    echo "Choose setup method:"
    echo "1) Automatic with GitHub CLI (recommended)"
    echo "2) Manual setup"
    read -p "Enter choice (1 or 2): " SETUP_METHOD
    
    if [ "$SETUP_METHOD" = "1" ]; then
        create_with_gh
    else
        manual_setup
    fi
else
    manual_setup
fi

echo ""
echo "================================================"
echo "              Setup Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "1. Verify your site is live (may take 5-10 minutes)"
echo "2. Check the Actions tab on GitHub for build status"
echo "3. Custom domain setup: Settings → Pages → Custom domain"
echo ""
echo "Documentation files:"
echo "- Landing page: index.html"
echo "- PRIME docs: documentation.md"
echo "- Strategies: strategies.md"
echo "- API reference: api.md"
echo "- Performance: performance.md"
echo ""
echo "To update in the future:"
echo "  git add ."
echo "  git commit -m 'Update documentation'"
echo "  git push"