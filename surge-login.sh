#!/bin/bash

# 🦀 guiClaw Website - Surge.sh Login Script
# This script helps you log in to Surge.sh

echo "🦀 guiClaw Website - Surge.sh Login"
echo "===================================="
echo ""

# Check if Surge is installed
if ! command -v surge &> /dev/null; then
    echo "❌ Surge.sh is not installed"
    echo "   Install with: npm install -g surge"
    exit 1
fi

# Check current login status
echo "Checking current login status..."
if surge whoami &> /dev/null; then
    echo "✅ Already logged in as:"
    surge whoami
    echo ""
    echo "You can proceed with deployment!"
    exit 0
fi

echo "❌ Not logged in to Surge.sh"
echo ""
echo "To log in to Surge.sh, you need to:"
echo "1. Create an account at: https://surge.sh/"
echo "2. Or log in using the command line"
echo ""
echo "Would you like to log in now? (y/n)"
read -p "Choice: " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo ""
    echo "Starting Surge login..."
    echo "Please follow the prompts:"
    echo ""
    surge login
else
    echo ""
    echo "Please create an account at: https://surge.sh/"
    echo "Then run this script again."
fi