#!/bin/bash

# 🦀 guiClaw Website - Get Surge Token Script
# This script helps you get a Surge token for non-interactive deployment

echo "🦀 guiClaw Website - Get Surge Token"
echo "===================================="
echo ""

# Check if Surge is installed
if ! command -v surge &> /dev/null; then
    echo "❌ Surge.sh is not installed"
    echo "   Install with: npm install -g surge"
    exit 1
fi

echo "To get a Surge token for non-interactive deployment:"
echo ""
echo "1. Run this command in your terminal:"
echo "   surge token"
echo ""
echo "2. Follow the prompts to log in to your Surge account"
echo "   (or create a new account if you don't have one)"
echo ""
echo "3. Copy the token that's displayed"
echo "   It will look like: token: abc123def456..."
echo ""
echo "4. Save the token to a file:"
echo "   mkdir -p ~/.surge"
echo "   echo 'YOUR_TOKEN_HERE' > ~/.surge/token"
echo ""
echo "5. Run the deployment script:"
echo "   ./deploy-surge-token.sh"
echo ""
echo "Note: The token will be stored securely in your home directory."
echo "      Only you and applications on your computer can access it."
echo ""
echo "Would you like me to help you generate a token now? (y/n)"
read -p "Choice: " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo ""
    echo "Starting Surge token generation..."
    echo "Please follow the prompts:"
    echo ""
    surge token
else
    echo ""
    echo "Please run 'surge token' manually when you're ready."
    echo "Then save the token to ~/.surge/token"
fi