#!/bin/bash

# guiClaw Website Deployment Script
# This script helps you deploy the guiClaw website

echo "🦀 guiClaw Website Deployment"
echo "================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Download from: https://nodejs.org/"
    exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "⚠️  Python 3 not found. You can still use Node.js server."
fi

echo ""
echo "Choose your deployment method:"
echo "1) Start Node.js server (recommended)"
echo "2) Start Python HTTP server"
echo "3) Copy to guiClaw folder"
echo "4) Open in browser"
echo "5) Exit"
echo ""

read -p "Enter choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo "Starting Node.js server..."
        echo "Server will run on: http://localhost:8080"
        echo "Press Ctrl+C to stop"
        echo ""
        node server.js
        ;;
    2)
        echo ""
        echo "Starting Python HTTP server..."
        echo "Server will run on: http://localhost:8080"
        echo "Press Ctrl+C to stop"
        echo ""
        python3 -m http.server 8080
        ;;
    3)
        echo ""
        echo "Copying website to guiClaw folder..."
        if [ -d "$HOME/Desktop/guiClaw" ]; then
            cp index.html "$HOME/Desktop/guiClaw/"
            echo "✅ Website copied to ~/Desktop/guiClaw/"
            echo "   Now start guiClaw with: node ~/Desktop/guiClaw/proxy.js"
            echo "   Then visit: http://localhost:8000"
        else
            echo "❌ guiClaw folder not found at ~/Desktop/guiClaw/"
            echo "   Please install guiClaw first or specify a different path."
        fi
        ;;
    4)
        echo ""
        echo "Opening website in browser..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open http://localhost:8080
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open http://localhost:8080
        elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
            start http://localhost:8080
        else
            echo "Please open http://localhost:8080 in your browser"
        fi
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Please enter 1-5."
        exit 1
        ;;
esac