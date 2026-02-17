#!/bin/bash

# 🦀 guiClaw Website - GitHub Pages Deployment Script
# This script deploys your guiClaw website to GitHub Pages

set -e

echo "🦀 guiClaw Website - GitHub Pages Deployment"
echo "============================================="
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found in current directory"
    echo "   Please run this script from the guiClaw-website folder"
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed"
    echo "   Please install Git from: https://git-scm.com/"
    exit 1
fi

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "   Install with: brew install gh (macOS)"
    echo "   Or download from: https://cli.github.com/"
    exit 1
fi

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "⚠️  Not a git repository. Initializing git..."
    git init
    git config user.email "guiClaw@example.com"
    git config user.name "guiClaw Website"
    git add .
    git commit -m "Initial commit: guiClaw website"
fi

# Check if we're logged in to GitHub
echo "Checking GitHub login status..."
if ! gh auth status &> /dev/null; then
    echo "❌ Not logged in to GitHub"
    echo ""
    echo "To log in to GitHub:"
    echo "1. Run: gh auth login"
    echo "2. Follow the prompts"
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "✅ Logged in to GitHub"
echo ""

# Get current repository info
echo "📋 Repository Information:"
git remote -v
echo ""

# Ask for repository name
echo "Enter a name for your GitHub repository:"
echo "   (e.g., guiclaw-website)"
read -p "Repository name: " repo_name

if [ -z "$repo_name" ]; then
    repo_name="guiclaw-website"
fi

# Check if repository exists
echo ""
echo "Checking if repository exists..."
if gh repo view "$repo_name" &> /dev/null; then
    echo "✅ Repository '$repo_name' exists"
    echo ""
    echo "Would you like to use this repository? (y/n)"
    read -p "Choice: " choice
    
    if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
        echo "Please choose a different repository name."
        exit 1
    fi
else
    echo "❌ Repository '$repo_name' does not exist"
    echo ""
    echo "Would you like to create it? (y/n)"
    read -p "Choice: " choice
    
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "Creating repository '$repo_name'..."
        gh repo create "$repo_name" --public --source=. --remote=origin --push
        echo "✅ Repository created and pushed"
    else
        echo "Please create the repository first and run this script again."
        exit 1
    fi
fi

# Create gh-pages branch
echo ""
echo "Creating gh-pages branch..."
git checkout --orphan gh-pages
git rm -rf .
git add .
git commit -m "Deploy guiClaw website to GitHub Pages"
git push -f origin gh-pages

# Enable GitHub Pages
echo ""
echo "Enabling GitHub Pages..."
gh api "repos/$(gh repo view --json nameWithOwner -q '.nameWithOwner')/pages" \
  --method POST \
  -F source@- <<EOF
{
  "branch": "gh-pages",
  "path": "/"
}
EOF

echo ""
echo "✅ Deployment Complete!"
echo ""
echo "🎉 Your guiClaw website is now live on GitHub Pages!"
echo ""
echo "🌐 Your site will be available at:"
echo "   https://YOUR_USERNAME.github.io/$repo_name/"
echo ""
echo "📋 Next steps:"
echo "   1. Visit your repository on GitHub"
echo "   2. Go to Settings > Pages"
echo "   3. Your site should be live in a few minutes"
echo "   4. Consider setting up a custom domain"
echo ""
echo "🔄 To redeploy in the future:"
echo "   git checkout gh-pages"
echo "   git add ."
echo "   git commit -m 'Update website'"
echo "   git push origin gh-pages"
echo ""
echo "Thank you for using guiClaw Website! 🦀"