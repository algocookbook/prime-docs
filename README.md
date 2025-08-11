# PRIME Documentation GitHub Pages

This repository hosts the documentation for PRIME - Professional Reinforcement Intelligence for Market Excellence.

## 🌐 Live Documentation

Visit our documentation at: https://your-username.github.io/prime-docs/

## 📚 Contents

- **Landing Page** (`index.html`) - Beautiful introduction to PRIME
- **Full Documentation** (`documentation.md`) - Complete technical documentation
- **API Reference** (`api.md`) - Detailed API documentation
- **Strategies** (`strategies.md`) - Strategy catalog and descriptions
- **Getting Started** (`getting-started.md`) - Quick start guide

## 🚀 Deployment Instructions

### Option 1: Deploy to GitHub Pages

1. Create a new GitHub repository named `prime-docs`
2. Push this folder to the repository:
```bash
cd /home/opc/taco-maker/prime-docs
git init
git add .
git commit -m "Initial PRIME documentation"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/prime-docs.git
git push -u origin main
```

3. Enable GitHub Pages:
   - Go to Settings → Pages
   - Source: Deploy from a branch
   - Branch: main
   - Folder: / (root)
   - Click Save

4. Your site will be available at: `https://YOUR-USERNAME.github.io/prime-docs/`

### Option 2: Custom Domain

1. Add a CNAME file with your domain:
```bash
echo "prime-trading.ai" > CNAME
```

2. Configure your DNS:
   - Add A records pointing to GitHub Pages IPs:
     - 185.199.108.153
     - 185.199.109.153
     - 185.199.110.153
     - 185.199.111.153

3. Enable HTTPS in GitHub Pages settings

## 📝 Local Development

To preview the site locally:

```bash
# Install Jekyll (if not already installed)
gem install jekyll bundler

# Install dependencies
bundle install

# Serve locally
bundle exec jekyll serve

# Visit http://localhost:4000
```

## 🎨 Customization

### Changing Colors
Edit the CSS variables in `index.html`:
```css
:root {
    --primary: #6366f1;
    --secondary: #10b981;
    --background: #0f0f23;
    /* ... */
}
```

### Adding Pages
1. Create a new `.md` or `.html` file
2. Add front matter for Jekyll:
```yaml
---
layout: default
title: Your Page Title
---
```

### Updating Content
- Main documentation: Edit `documentation.md`
- Landing page: Edit `index.html`
- API docs: Edit `api.md`

## 📊 Analytics

To add Google Analytics:
1. Get your tracking ID from Google Analytics
2. Add it to `_config.yml`:
```yaml
google_analytics: UA-XXXXXXXXX-X
```

## 🔧 Technical Stack

- **GitHub Pages** - Hosting
- **Jekyll** - Static site generator
- **HTML/CSS** - Custom landing page
- **Markdown** - Documentation format

## 📄 License

This documentation is part of the PRIME Trading Intelligence system.
Copyright © 2025 PRIME Team. All rights reserved.

## 🤝 Contributing

To contribute to the documentation:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

- GitHub Issues: [Report issues](https://github.com/your-org/prime-docs/issues)
- Email: docs@prime-trading.ai
- Discord: [Join our community](https://discord.gg/prime)

---

Built with ❤️ by the PRIME Team