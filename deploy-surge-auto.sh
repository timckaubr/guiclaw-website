#!/bin/bash

# 🦀 guiClaw Website - Surge.sh Auto Deployment Script
# This script deploys your guiClaw website to Surge.sh without interactive prompts

set -e

echo "🦀 guiClaw Website - Surge.sh Auto Deployment"
echo "=============================================="
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found in current directory"
    echo "   Please run this script from the guiClaw-website folder"
    exit 1
fi

# Check if Surge is installed
if ! command -v surge &> /dev/null; then
    echo "❌ Surge.sh is not installed"
    echo "   Install with: npm install -g surge"
    exit 1
fi

# Check if we're logged in to Surge
echo "Checking Surge login status..."
if ! surge whoami &> /dev/null; then
    echo "⚠️  Not logged in to Surge.sh"
    echo "   Please log in first by running:"
    echo "   surge login"
    echo ""
    echo "   Or create an account at: https://surge.sh/"
    echo ""
    echo "   After logging in, run this script again."
    exit 1
fi

# Get current user info
echo "✅ Logged in as:"
surge whoami
echo ""

# Generate a random subdomain
random_subdomain="guiclaw-$(date +%s | tail -c 4)"
domain="${random_subdomain}.surge.sh"

echo "🌐 Deployment Details:"
echo "   Domain: $domain"
echo "   Directory: $(pwd)"
echo ""

# Deploy to Surge
echo "🚀 Deploying to Surge.sh..."
echo "   This may take a moment..."
echo ""

# Use surge with path and domain (non-interactive)
surge . "$domain"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment Complete!"
    echo ""
    echo "🎉 Your guiClaw website is now live!"
    echo ""
    echo "🌐 Your site is available at:"
    echo "   https://$domain"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Visit https://$domain in your browser"
    echo "   2. Share the URL with others"
    echo "   3. Consider setting up a custom domain"
    echo ""
    echo "🔄 To redeploy in the future:"
    echo "   cd $(pwd)"
    echo "   ./deploy-surge-auto.sh"
    echo ""
    echo "Thank you for using guiClaw Website! 🦀"
else
    echo ""
    echo "❌ Deployment failed"
    echo "   Please check the error messages above"
    exit 1
fi