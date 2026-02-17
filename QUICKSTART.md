# guiClaw Website - Quick Start Guide

## 🚀 Get Started in 3 Steps

### Step 1: Start the Website

**Option A: Using Node.js (Recommended)**
```bash
cd ~/Desktop/guiClaw-Website
npm start
```

**Option B: Using Python**
```bash
cd ~/Desktop/guiClaw-Website
python3 -m http.server 8080
```

**Option C: Using the deploy script**
```bash
cd ~/Desktop/guiClaw-Website
./deploy.sh
```

### Step 2: Open in Browser

Open your web browser and visit:
- **Main site:** http://localhost:8080
- **Demo page:** http://localhost:8080/demo.html

### Step 3: Use with guiClaw

If you want to replace the existing guiClaw website:

1. **Copy the website to guiClaw folder:**
   ```bash
   cp index.html ~/Desktop/guiClaw/
   ```

2. **Start guiClaw:**
   ```bash
   node ~/Desktop/guiClaw/proxy.js
   ```

3. **Access guiClaw:**
   Open http://localhost:8000 in your browser

## 📁 File Structure

```
guiclaw-website/
├── index.html          # Main landing page
├── demo.html           # Interactive demo page
├── server.js           # Node.js server
├── deploy.sh           # Deployment script
├── package.json        # Node.js configuration
├── README.md           # Documentation
└── QUICKSTART.md       # This file
```

## 🎯 Features

### Main Page (index.html)
- Modern, responsive design
- Feature showcase
- Quick start instructions
- Version badge (v3.1)
- Demo button

### Demo Page (demo.html)
- Interactive feature cards
- Click to see feature details
- Start interactive demo
- Launch guiClaw button

## 🔧 Customization

### Change Colors
Edit the CSS variables in the `<style>` section:
```css
:root {
    --primary: #6366f1;    /* Main color */
    --secondary: #10b981;  /* Accent color */
    --dark: #1f2937;       /* Text color */
    --light: #f9fafb;      /* Background */
}
```

### Update Content
Edit the HTML content in the `<body>` section:
- Change feature descriptions
- Update installation commands
- Modify button text

### Add New Features
Add new feature cards in the `.features` section:
```html
<div class="feature-card">
    <div class="feature-icon">🎯</div>
    <h3>New Feature</h3>
    <p>Description of your new feature</p>
</div>
```

## 📱 Responsive Design

The website is fully responsive and works on:
- Desktop (1200px+)
- Tablet (768px - 1199px)
- Mobile (< 768px)

## 🌐 Browser Support

- ✅ Chrome/Edge (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ Mobile browsers (iOS Safari, Chrome Mobile)

## 🚨 Troubleshooting

### "Port already in use"
Change the port in `server.js`:
```javascript
const PORT = 8081; // Change to another port
```

### "Cannot access localhost"
Make sure the server is running:
```bash
# Check if Node.js is running
ps aux | grep node

# Check if port is listening
lsof -i :8080
```

### "Website not loading"
1. Check browser console for errors
2. Ensure all files are in the same directory
3. Try a different browser

## 📊 Performance

- **Load time:** < 1 second
- **File size:** ~13KB (index.html)
- **No external dependencies**
- **Pure vanilla JS and CSS**

## 🔄 Updates

To update the website:
1. Download the latest version
2. Replace the old files
3. Restart the server

## 📞 Support

For issues or questions:
- Check the README.md file
- Review the QUICKSTART.md guide
- Visit the OpenClaw documentation

## 🎨 Design Principles

- **Clean:** Minimalist design with plenty of white space
- **Modern:** Gradient backgrounds and smooth animations
- **Accessible:** Good contrast and readable fonts
- **Fast:** No external dependencies or heavy libraries
- **Responsive:** Works on all screen sizes

## 📝 License

This website is part of the guiClaw project for OpenClaw.
Free to use and modify for personal projects.