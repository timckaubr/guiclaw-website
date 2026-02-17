#!/bin/bash

# 🦀 guiClaw Website - Surge.sh Deployment Script
# This script deploys your guiClaw website to Surge.sh

set -e

echo "🦀 guiClaw Website - Surge.sh Deployment"
echo "========================================="
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found in current directory"
    echo "   Please run this script from the guiClaw-website folder"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed"
    echo "   Please install Node.js from: https://nodejs.org/"
    exit 1
fi

# Check if Surge is installed
if ! command -v surge &> /dev/null; then
    echo "📦 Installing Surge.sh CLI..."
    npm install -g surge
    echo "✅ Surge installed successfully"
    echo ""
fi

# Show website info
echo "📋 Website Information:"
echo "   Location: $(pwd)"
echo "   Files:"
ls -la | grep -E "\.(html|js|css|json)$" | head -10
echo ""

# Ask for domain (optional)
echo "🌐 Domain Options:"
echo "   1) Use random subdomain (e.g., guiclaw-123.surge.sh)"
echo "   2) Use custom subdomain (e.g., guiclaw.surge.sh)"
echo "   3) Use custom domain (e.g., yourdomain.com)"
echo ""
read -p "Choose option (1-3) or press Enter for option 1: " domain_choice

case $domain_choice in
    2)
        read -p "Enter subdomain (without .surge.sh): " subdomain
        domain="${subdomain}.surge.sh"
        ;;
    3)
        read -p "Enter custom domain (e.g., yourdomain.com): " domain
        ;;
    *)
        domain=""
        ;;
esac

# Deploy to Surge
echo ""
echo "🚀 Deploying to Surge.sh..."
echo "   This may take a moment..."
echo ""

if [ -n "$domain" ]; then
    surge . --domain "$domain"
else
    surge .
fi

echo ""
echo "✅ Deployment Complete!"
echo ""
echo "🎉 Your guiClaw website is now live!"
echo ""
echo "Next steps:"
echo "1. Visit your site in the browser"
echo "2. Share the URL with others"
echo "3. Consider setting up a custom domain"
echo ""
echo "To redeploy in the future:"
echo "  cd $(pwd)"
echo "  ./deploy-surge.sh"
echo ""
echo "Thank you for using guiClaw Website! 🦀"