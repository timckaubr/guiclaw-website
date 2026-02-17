#!/bin/bash

# 🦀 guiClaw Website - Multi-Platform Deployment Script
# Supports: Surge.sh, GitHub Pages, Netlify, and more

set -e  # Exit on error

echo "🦀 guiClaw Website Deployment Tool"
echo "===================================="
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found in current directory"
    echo "   Please run this script from the guiClaw-website folder"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Surge
install_surge() {
    echo "📦 Installing Surge..."
    if command_exists npm; then
        npm install -g surge
        echo "✅ Surge installed successfully"
    else
        echo "❌ npm not found. Please install Node.js first."
        echo "   Download from: https://nodejs.org/"
        exit 1
    fi
}

# Function to install gh-pages
install_gh_pages() {
    echo "📦 Installing gh-pages..."
    if command_exists npm; then
        npm install --save-dev gh-pages
        echo "✅ gh-pages installed successfully"
    else
        echo "❌ npm not found. Please install Node.js first."
        exit 1
    fi
}

# Function to install Netlify CLI
install_netlify() {
    echo "📦 Installing Netlify CLI..."
    if command_exists npm; then
        npm install -g netlify-cli
        echo "✅ Netlify CLI installed successfully"
    else
        echo "❌ npm not found. Please install Node.js first."
        exit 1
    fi
}

# Function to deploy to Surge.sh
deploy_surge() {
    echo "🚀 Deploying to Surge.sh..."
    
    # Check if Surge is installed
    if ! command_exists surge; then
        install_surge
    fi
    
    # Create a simple index.html if it doesn't exist
    if [ ! -f "index.html" ]; then
        echo "❌ index.html not found"
        exit 1
    fi
    
    # Deploy to Surge
    echo "Starting deployment to Surge.sh..."
    surge . --domain guiclaw.surge.sh
    
    echo ""
    echo "✅ Deployed to Surge.sh!"
    echo "   Your site is live at: https://guiclaw.surge.sh"
    echo ""
    echo "   To use a custom domain:"
    echo "   surge . --domain yourdomain.com"
}

# Function to deploy to GitHub Pages
deploy_github() {
    echo "🚀 Deploying to GitHub Pages..."
    
    # Check if gh-pages is installed
    if ! command_exists gh-pages; then
        install_gh_pages
    fi
    
    # Check if we're in a git repository
    if [ ! -d ".git" ]; then
        echo "⚠️  Not a git repository. Initializing git..."
        git init
        git add .
        git commit -m "Initial commit: guiClaw website"
    fi
    
    # Create package.json if it doesn't exist
    if [ ! -f "package.json" ]; then
        echo "{
  \"name\": \"guiclaw-website\",
  \"version\": \"1.0.0\",
  \"scripts\": {
    \"deploy\": \"gh-pages -d . -b gh-pages\"
  }
}" > package.json
    fi
    
    # Add deploy script to package.json
    if ! grep -q '"deploy"' package.json; then
        # This is a simple approach - in production, you'd want to use jq or similar
        echo "⚠️  Please add this to your package.json scripts:"
        echo "   \"deploy\": \"gh-pages -d . -b gh-pages\""
        echo ""
        echo "   Then run: npm run deploy"
        exit 1
    fi
    
    # Deploy
    echo "Deploying to GitHub Pages..."
    gh-pages -d . -b gh-pages
    
    echo ""
    echo "✅ Deployed to GitHub Pages!"
    echo "   Your site will be available at: https://YOUR_USERNAME.github.io/guiclaw-website/"
    echo ""
    echo "   Make sure your repository is public!"
}

# Function to deploy to Netlify
deploy_netlify() {
    echo "🚀 Deploying to Netlify..."
    
    # Check if Netlify CLI is installed
    if ! command_exists netlify; then
        install_netlify
    fi
    
    # Login to Netlify (if not already logged in)
    echo "Checking Netlify login status..."
    if ! netlify status >/dev/null 2>&1; then
        echo "Please log in to Netlify..."
        netlify login
    fi
    
    # Deploy
    echo "Deploying to Netlify..."
    netlify deploy --prod --dir=.
    
    echo ""
    echo "✅ Deployed to Netlify!"
    echo "   Your site is live at: https://guiclaw.netlify.app"
    echo ""
    echo "   To set up a custom domain:"
    echo "   netlify domains:add yourdomain.com"
}

# Function to deploy to Vercel
deploy_vercel() {
    echo "🚀 Deploying to Vercel..."
    
    # Check if Vercel CLI is installed
    if ! command_exists vercel; then
        echo "📦 Installing Vercel CLI..."
        if command_exists npm; then
            npm install -g vercel
            echo "✅ Vercel CLI installed successfully"
        else
            echo "❌ npm not found. Please install Node.js first."
            exit 1
        fi
    fi
    
    # Deploy
    echo "Deploying to Vercel..."
    vercel --prod --yes
    
    echo ""
    echo "✅ Deployed to Vercel!"
    echo "   Your site is live at: https://guiclaw.vercel.app"
}

# Function to create GitHub repository
create_github_repo() {
    echo "🚀 Creating GitHub repository..."
    
    if ! command_exists gh; then
        echo "📦 Installing GitHub CLI..."
        if command_exists brew; then
            brew install gh
        else
            echo "❌ GitHub CLI not found. Please install it:"
            echo "   macOS: brew install gh"
            echo "   Other: https://cli.github.com/"
            exit 1
        fi
    fi
    
    # Create repository
    echo "Creating repository 'guiclaw-website'..."
    gh repo create guiclaw-website --public --source=. --remote=origin --push
    
    echo ""
    echo "✅ GitHub repository created!"
    echo "   Repository: https://github.com/YOUR_USERNAME/guiclaw-website"
}

# Function to show deployment options
show_options() {
    echo "Choose deployment platform:"
    echo ""
    echo "1) 🌊 Surge.sh (Easiest - CLI only)"
    echo "   - Free, no credit card"
    echo "   - Instant deployment"
    echo "   - Custom domains supported"
    echo ""
    echo "2) 📦 GitHub Pages (Free, requires GitHub account)"
    echo "   - Free hosting"
    echo "   - Custom domains with SSL"
    echo "   - Good for open source projects"
    echo ""
    echo "3) 🌐 Netlify (Free, requires account)"
    echo "   - Free tier with custom domains"
    echo "   - Continuous deployment"
    echo "   - Form handling, functions"
    echo ""
    echo "4) ⚡ Vercel (Free, requires account)"
    echo "   - Free tier with custom domains"
    echo "   - Excellent performance"
    echo "   - Great for frontend frameworks"
    echo ""
    echo "5) 📋 Create GitHub Repository"
    echo "   - Set up GitHub repo for your website"
    echo ""
    echo "6) 🔄 Local Server (Test locally)"
    echo "   - Start local server on port 8080"
    echo ""
    echo "7) 📁 Copy to guiClaw folder"
    echo "   - Replace guiClaw's index.html"
    echo ""
    echo "8) 📊 Show deployment status"
    echo "   - Check current deployment status"
    echo ""
    echo "9) ❌ Exit"
    echo ""
}

# Function to show deployment status
show_status() {
    echo "📊 Deployment Status"
    echo "===================="
    echo ""
    
    # Check if Surge is installed
    if command_exists surge; then
        echo "✅ Surge.sh: Installed"
    else
        echo "❌ Surge.sh: Not installed"
    fi
    
    # Check if gh-pages is installed
    if command_exists gh-pages; then
        echo "✅ gh-pages: Installed"
    else
        echo "❌ gh-pages: Not installed"
    fi
    
    # Check if Netlify CLI is installed
    if command_exists netlify; then
        echo "✅ Netlify CLI: Installed"
    else
        echo "❌ Netlify CLI: Not installed"
    fi
    
    # Check if Vercel CLI is installed
    if command_exists vercel; then
        echo "✅ Vercel CLI: Installed"
    else
        echo "❌ Vercel CLI: Not installed"
    fi
    
    # Check if GitHub CLI is installed
    if command_exists gh; then
        echo "✅ GitHub CLI: Installed"
    else
        echo "❌ GitHub CLI: Not installed"
    fi
    
    echo ""
    echo "Current directory: $(pwd)"
    echo "Files in directory:"
    ls -la | head -10
}

# Function to copy to guiClaw folder
copy_to_guiclaw() {
    echo "📁 Copying to guiClaw folder..."
    
    if [ -d "$HOME/Desktop/guiClaw" ]; then
        cp index.html "$HOME/Desktop/guiClaw/"
        echo "✅ Website copied to ~/Desktop/guiClaw/"
        echo ""
        echo "To use with guiClaw:"
        echo "1. Start guiClaw: node ~/Desktop/guiClaw/proxy.js"
        echo "2. Open browser: http://localhost:8000"
    else
        echo "❌ guiClaw folder not found at ~/Desktop/guiClaw/"
        echo ""
        echo "Please specify the guiClaw folder path:"
        read -p "Enter path to guiClaw folder: " guiclaw_path
        
        if [ -d "$guiclaw_path" ]; then
            cp index.html "$guiclaw_path/"
            echo "✅ Website copied to $guiclaw_path/"
        else
            echo "❌ Path not found: $guiclaw_path"
        fi
    fi
}

# Function to start local server
start_local_server() {
    echo "🌐 Starting local server..."
    
    if command_exists node; then
        echo "Starting Node.js server on port 8080..."
        echo "Press Ctrl+C to stop"
        echo ""
        node server.js
    elif command_exists python3; then
        echo "Starting Python HTTP server on port 8080..."
        echo "Press Ctrl+C to stop"
        echo ""
        python3 -m http.server 8080
    else
        echo "❌ Neither Node.js nor Python 3 found"
        echo "   Please install Node.js or Python 3"
        exit 1
    fi
}

# Main menu loop
while true; do
    show_options
    read -p "Enter choice (1-9): " choice
    
    case $choice in
        1)
            deploy_surge
            break
            ;;
        2)
            deploy_github
            break
            ;;
        3)
            deploy_netlify
            break
            ;;
        4)
            deploy_vercel
            break
            ;;
        5)
            create_github_repo
            break
            ;;
        6)
            start_local_server
            break
            ;;
        7)
            copy_to_guiclaw
            break
            ;;
        8)
            show_status
            ;;
        9)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "❌ Invalid choice. Please enter 1-9."
            ;;
    esac
done

echo ""
echo "🎉 Deployment complete!"
echo "Thank you for using guiClaw Website Deployment Tool"