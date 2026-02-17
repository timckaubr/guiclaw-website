# guiClaw Website - Deployment Guide

## 🚀 Quick Deployment Options

### Option 1: Surge.sh (Easiest - Recommended for Beginners)

**Why Surge.sh?**
- ✅ Completely free
- ✅ No credit card required
- ✅ Instant deployment via CLI
- ✅ Custom domains supported
- ✅ SSL included
- ✅ No account setup needed

**Steps:**
```bash
# 1. Install Surge
npm install -g surge

# 2. Navigate to your website folder
cd /Users/tim/.openclaw/workspace/guiclaw-website

# 3. Deploy to Surge
surge .

# 4. Follow the prompts
# - Enter email (first time only)
# - Choose a subdomain (e.g., guiclaw.surge.sh)
# - Or use custom domain
```

**Your site will be live at:** `https://guiclaw.surge.sh`

---

### Option 2: GitHub Pages (Free, Requires GitHub Account)

**Why GitHub Pages?**
- ✅ Completely free
- ✅ Custom domains with SSL
- ✅ Good for open source projects
- ✅ Integrated with GitHub repositories

**Steps:**
```bash
# 1. Install gh-pages CLI
npm install --save-dev gh-pages

# 2. Create a GitHub repository
gh repo create guiclaw-website --public

# 3. Add deployment script to package.json
# Add this to your package.json:
{
  "scripts": {
    "deploy": "gh-pages -d . -b gh-pages"
  }
}

# 4. Deploy
npm run deploy
```

**Your site will be live at:** `https://YOUR_USERNAME.github.io/guiclaw-website/`

---

### Option 3: Netlify (Free Tier)

**Why Netlify?**
- ✅ Free tier with custom domains
- ✅ Continuous deployment
- ✅ Form handling
- ✅ Serverless functions
- ✅ Great developer experience

**Steps:**
```bash
# 1. Install Netlify CLI
npm install -g netlify-cli

# 2. Login to Netlify
netlify login

# 3. Deploy
netlify deploy --prod --dir=.

# 4. Follow the prompts
# - Create new site
# - Choose publish directory (current directory)
```

**Your site will be live at:** `https://guiclaw.netlify.app`

---

### Option 4: Vercel (Free Tier)

**Why Vercel?**
- ✅ Free tier with custom domains
- ✅ Excellent performance
- ✅ Great for frontend frameworks
- ✅ Easy GitHub integration

**Steps:**
```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Deploy
vercel --prod --yes

# 3. Follow the prompts
# - Link to GitHub (optional)
# - Choose project settings
```

**Your site will be live at:** `https://guiclaw.vercel.app`

---

## 📊 Comparison Table

| Feature | Surge.sh | GitHub Pages | Netlify | Vercel |
|---------|----------|--------------|---------|--------|
| **Cost** | Free | Free | Free tier | Free tier |
| **CLI** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Custom Domain** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **SSL** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Continuous Deploy** | ❌ No | ✅ Yes | ✅ Yes | ✅ Yes |
| **Build Time** | Instant | ~1 min | ~1 min | ~1 min |
| **Setup Time** | 1 min | 5 min | 3 min | 3 min |
| **Best For** | Quick demos | Open source | Full projects | Frontend apps |

---

## 🛠️ Using the Deployment Script

### Run the All-in-One Script

```bash
# Navigate to the website folder
cd /Users/tim/.openclaw/workspace/guiclaw-website

# Run the deployment script
./deploy-all.sh
```

### Script Features:
- **Interactive menu** - Choose your deployment platform
- **Auto-install** - Installs required CLI tools
- **Multi-platform** - Supports 4+ hosting services
- **Status check** - Shows what's installed
- **Local testing** - Start local server
- **Copy to guiClaw** - Replace guiClaw's index.html

---

## 📋 Step-by-Step Deployment Process

### Step 1: Prepare Your Website
```bash
# Navigate to your website folder
cd /Users/tim/.openclaw/workspace/guiclaw-website

# Verify files are present
ls -la
# Should show: index.html, demo.html, server.js, etc.
```

### Step 2: Choose Your Platform
Based on your needs:
- **Quick demo** → Surge.sh
- **Open source project** → GitHub Pages
- **Full-featured site** → Netlify
- **Frontend app** → Vercel

### Step 3: Install Required CLI
```bash
# For Surge
npm install -g surge

# For GitHub Pages
npm install --save-dev gh-pages

# For Netlify
npm install -g netlify-cli

# For Vercel
npm install -g vercel
```

### Step 4: Deploy
```bash
# Surge
surge .

# GitHub Pages
gh-pages -d . -b gh-pages

# Netlify
netlify deploy --prod --dir=.

# Vercel
vercel --prod --yes
```

### Step 5: Configure Custom Domain (Optional)
```bash
# Surge
surge . --domain yourdomain.com

# GitHub Pages
# Add CNAME file with your domain

# Netlify
netlify domains:add yourdomain.com

# Vercel
vercel domains add yourdomain.com
```

---

## 🔧 Advanced Configuration

### Custom Domain Setup

#### For Surge.sh:
```bash
# Deploy with custom domain
surge . --domain guiclaw.example.com

# Or add CNAME file in your directory
echo "guiclaw.example.com" > CNAME
surge .
```

#### For GitHub Pages:
1. Add CNAME file in your directory:
   ```
   guiclaw.example.com
   ```
2. Configure DNS:
   - A Record: `185.199.108.153`
   - A Record: `185.199.109.153`
   - A Record: `185.199.110.153`
   - A Record: `185.199.111.153`
3. Enable GitHub Pages in repository settings

#### For Netlify:
```bash
# Add custom domain
netlify domains:add guiclaw.example.com

# Configure DNS
netlify open --site
# Then go to Domain settings in Netlify dashboard
```

### SSL/HTTPS
All platforms automatically provide SSL certificates:
- **Surge.sh**: Automatic
- **GitHub Pages**: Automatic
- **Netlify**: Automatic
- **Vercel**: Automatic

---

## 🚨 Troubleshooting

### Common Issues

#### "Command not found"
```bash
# Make sure Node.js is installed
node --version

# If not installed, download from:
# https://nodejs.org/
```

#### "Permission denied"
```bash
# Make scripts executable
chmod +x deploy-all.sh
chmod +x deploy.sh
```

#### "Port already in use"
```bash
# Change port in server.js
# Edit: const PORT = 8081;
```

#### "Deployment failed"
```bash
# Check internet connection
# Check if CLI is installed correctly
# Try with verbose output:
surge . --verbose
```

### Platform-Specific Issues

#### Surge.sh Issues:
- **Email verification**: First time requires email verification
- **Domain taken**: Choose a different subdomain
- **Rate limits**: Free tier has reasonable limits

#### GitHub Pages Issues:
- **Repository must be public** for free hosting
- **Branch must be gh-pages** or main branch
- **CNAME file** required for custom domains

#### Netlify Issues:
- **Build command**: For static sites, leave empty
- **Publish directory**: Set to current directory (.)
- **Build timeout**: Free tier has 15-minute limit

---

## 📈 Performance Tips

### Optimize Your Website
1. **Minify HTML/CSS/JS** (optional for small sites)
2. **Use CDN** (all platforms provide this)
3. **Compress images** before uploading
4. **Enable caching** headers

### Monitor Performance
```bash
# Check site speed
curl -w "@curl-format.txt" -o /dev/null -s https://your-site.com

# Check SSL certificate
curl -I https://your-site.com
```

---

## 🔄 Continuous Deployment

### Auto-deploy on Git Push

#### GitHub Pages:
```bash
# Set up GitHub Actions
# Create .github/workflows/deploy.yml
name: Deploy to GitHub Pages
on:
  push:
    branches: [ main ]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: .
```

#### Netlify/Vercel:
- Connect your GitHub repository
- Set up automatic deployments
- Deploy on every push

---

## 📁 File Structure for Deployment

Your website folder should contain:
```
guiclaw-website/
├── index.html          # Main page (required)
├── demo.html           # Demo page (optional)
├── server.js           # Local server (optional)
├── package.json        # Node.js config (optional)
├── CNAME               # Custom domain (optional)
└── README.md           # Documentation (optional)
```

---

## 🎯 Recommended Deployment Path

### For Master Au (Beginner-Friendly):
1. **Start with Surge.sh** - Easiest, no setup
2. **Try GitHub Pages** - If you have GitHub account
3. **Explore Netlify** - For more features
4. **Consider Vercel** - For future projects

### Quick Start Commands:
```bash
# Option 1: Surge.sh (Fastest)
npm install -g surge
surge .

# Option 2: GitHub Pages (Free + Custom Domain)
npm install -g gh-pages
gh-pages -d . -b gh-pages

# Option 3: Netlify (Most Features)
npm install -g netlify-cli
netlify deploy --prod --dir=.
```

---

## 📞 Support Resources

- **Surge.sh**: https://surge.sh/help
- **GitHub Pages**: https://docs.github.com/en/pages
- **Netlify**: https://docs.netlify.com/
- **Vercel**: https://vercel.com/docs

---

## ✅ Deployment Checklist

- [ ] Website files are ready (index.html)
- [ ] CLI tool installed (surge/gh-pages/netlify/vercel)
- [ ] Account created (if required)
- [ ] Deployed successfully
- [ ] Site accessible via URL
- [ ] SSL certificate active
- [ ] Custom domain configured (optional)
- [ ] Tested on mobile devices
- [ ] Performance is acceptable

---

**Happy Deploying! 🚀**