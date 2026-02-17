#!/bin/bash

# 🦀 guiClaw Website - Surge.sh Token-Based Deployment Script
# This script deploys your guiClaw website to Surge.sh using tokens

set -e

echo "🦀 guiClaw Website - Surge.sh Token Deployment"
echo "==============================================="
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

# Check if token file exists
TOKEN_FILE="$HOME/.surge/token"
if [ -f "$TOKEN_FILE" ]; then
    echo "✅ Found existing Surge token"
    TOKEN=$(cat "$TOKEN_FILE")
    echo "   Token: ${TOKEN:0:10}..."
else
    echo "❌ No Surge token found"
    echo ""
    echo "To get a Surge token:"
    echo "1. Run: surge token"
    echo "2. Follow the prompts to log in"
    echo "3. Copy the token that's displayed"
    echo ""
    echo "Then run this script again."
    exit 1
fi

# Generate a random subdomain
random_subdomain="guiclaw-$(date +%s | tail -c 4)"
domain="${random_subdomain}.surge.sh"

echo ""
echo "🌐 Deployment Details:"
echo "   Domain: $domain"
echo "   Directory: $(pwd)"
echo "   Token: ${TOKEN:0:10}..."
echo ""

# Deploy to Surge using token
echo "🚀 Deploying to Surge.sh..."
echo "   This may take a moment..."
echo ""

# Create a temporary directory with the website files
TEMP_DIR="/tmp/guiclaw-deploy-$$"
mkdir -p "$TEMP_DIR"
cp -r ./* "$TEMP_DIR/"

# Deploy using surge with token
cd "$TEMP_DIR"
surge . "$domain" --token "$TOKEN"

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
    echo "   ./deploy-surge-token.sh"
    echo ""
    echo "Thank you for using guiClaw Website! 🦀"
    
    # Clean up
    rm -rf "$TEMP_DIR"
else
    echo ""
    echo "❌ Deployment failed"
    echo "   Please check the error messages above"
    
    # Clean up
    rm -rf "$TEMP_DIR"
    exit 1
fi