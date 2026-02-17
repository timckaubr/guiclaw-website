#!/bin/bash

# 🦀 guiClaw Website - Test Deployment Script
# This script tests if your website is ready for deployment

set -e

echo "🦀 guiClaw Website - Deployment Test"
echo "====================================="
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found"
    echo "   Please run this script from the guiClaw-website folder"
    exit 1
fi

echo "✅ Found index.html"
echo ""

# Check file size
size=$(stat -f%z index.html 2>/dev/null || stat -c%s index.html 2>/dev/null)
echo "📊 File size: $size bytes"

if [ $size -lt 1000 ]; then
    echo "⚠️  Warning: index.html seems very small"
else
    echo "✅ File size looks good"
fi
echo ""

# Check if Node.js is installed
if command -v node &> /dev/null; then
    echo "✅ Node.js: $(node --version)"
else
    echo "❌ Node.js: Not installed"
    echo "   Download from: https://nodejs.org/"
fi
echo ""

# Check if npm is installed
if command -v npm &> /dev/null; then
    echo "✅ npm: $(npm --version)"
else
    echo "❌ npm: Not installed"
fi
echo ""

# Check if Surge is installed
if command -v surge &> /dev/null; then
    echo "✅ Surge.sh: Installed"
else
    echo "❌ Surge.sh: Not installed"
    echo "   Install with: npm install -g surge"
fi
echo ""

# Check if gh-pages is installed
if command -v gh-pages &> /dev/null; then
    echo "✅ gh-pages: Installed"
else
    echo "❌ gh-pages: Not installed"
    echo "   Install with: npm install --save-dev gh-pages"
fi
echo ""

# Check if Netlify CLI is installed
if command -v netlify &> /dev/null; then
    echo "✅ Netlify CLI: Installed"
else
    echo "❌ Netlify CLI: Not installed"
    echo "   Install with: npm install -g netlify-cli"
fi
echo ""

# Check if Vercel CLI is installed
if command -v vercel &> /dev/null; then
    echo "✅ Vercel CLI: Installed"
else
    echo "❌ Vercel CLI: Not installed"
    echo "   Install with: npm install -g vercel"
fi
echo ""

# Check if GitHub CLI is installed
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI: Installed"
else
    echo "❌ GitHub CLI: Not installed"
    echo "   Install with: brew install gh (macOS)"
fi
echo ""

# Check if Python is installed (for local server)
if command -v python3 &> /dev/null; then
    echo "✅ Python 3: $(python3 --version)"
else
    echo "⚠️  Python 3: Not installed (optional)"
fi
echo ""

# Check if curl is installed
if command -v curl &> /dev/null; then
    echo "✅ curl: Installed"
else
    echo "❌ curl: Not installed"
fi
echo ""

# Check internet connection
echo "🌐 Testing internet connection..."
if curl -s --head http://www.google.com | head -n 1 | grep "HTTP" > /dev/null; then
    echo "✅ Internet connection: Working"
else
    echo "❌ Internet connection: Not working"
fi
echo ""

# List all files in directory
echo "📁 Files in current directory:"
ls -la
echo ""

# Check for common deployment files
echo "📋 Deployment file check:"
for file in index.html demo.html server.js package.json; do
    if [ -f "$file" ]; then
        echo "✅ $file: Found"
    else
        echo "❌ $file: Missing"
    fi
done
echo ""

# Summary
echo "📊 Deployment Readiness Summary:"
echo "================================"
echo ""

# Count how many tools are installed
tools_installed=0
tools_total=4

if command -v surge &> /dev/null; then tools_installed=$((tools_installed + 1)); fi
if command -v gh-pages &> /dev/null; then tools_installed=$((tools_installed + 1)); fi
if command -v netlify &> /dev/null; then tools_installed=$((tools_installed + 1)); fi
if command -v vercel &> /dev/null; then tools_installed=$((tools_installed + 1)); fi

echo "CLI Tools Installed: $tools_installed/$tools_total"

if [ $tools_installed -eq 0 ]; then
    echo "❌ No deployment tools installed"
    echo "   Recommended: npm install -g surge"
elif [ $tools_installed -eq 1 ]; then
    echo "✅ At least one deployment tool installed"
else
    echo "✅ Multiple deployment tools available"
fi
echo ""

# Check if website is ready
if [ -f "index.html" ] && [ $size -gt 1000 ]; then
    echo "✅ Website is ready for deployment!"
    echo ""
    echo "🚀 Recommended next steps:"
    echo "   1. Run: ./deploy-surge.sh (easiest)"
    echo "   2. Or run: ./deploy-all.sh (choose platform)"
    echo "   3. Or run: ./deploy.sh (original script)"
else
    echo "❌ Website needs more work"
    echo "   Make sure index.html exists and has content"
fi
echo ""

echo "🎉 Test complete!"
echo "   Run './deploy-surge.sh' to deploy to Surge.sh"
echo "   Run './deploy-all.sh' for more options"