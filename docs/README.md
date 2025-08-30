# OSVMarchi Documentation & GitHub Pages

This directory contains the GitHub Pages site for OSVMarchi, featuring a FAR Manager-style interface that provides an interactive way to explore the project.

## Features

### 🎨 FAR Manager Style Interface
- Retro terminal aesthetic with two-panel layout
- Blue color scheme reminiscent of classic file managers
- Keyboard navigation and shortcuts
- Responsive design for mobile devices

### ⌨️ Keyboard Shortcuts
- **F1** - Help and keyboard shortcuts
- **F3** - Toggle search functionality
- **F5** - Quick access to ISO downloads
- **F6** - Open GitHub repository
- **F7** - Cycle through color themes
- **F8** - View features overview
- **F10** - About OSVMarchi
- **ESC** - Close modals and search
- **Arrow Keys** - Navigate menu items
- **Enter/Space** - Activate selected items

### 🔍 Search Functionality
- Real-time search across documentation
- Indexed content for fast results
- Keyboard accessible (F3 to toggle)
- Click results to navigate directly

### 📱 Responsive Design
- Adapts to mobile and tablet screens
- Touch-friendly interface
- Maintains functionality across devices
- Optimized for keyboard and mouse

### 🎨 Theme Support
- Multiple color schemes (Blue, Green, Amber, Default)
- F7 to cycle through themes
- Persistent theme selection
- Accessibility-friendly color combinations

## Content Sections

### 🏠 Home
- ASCII art logo display
- Project overview and description
- Quick action buttons for common tasks

### 💿 ISO Downloads
- Grid layout of available architectures
- Direct links to GitHub Actions artifacts
- Architecture-specific optimization details
- Download instructions and verification steps

### 📚 Documentation
- Links to installation guides
- Configuration documentation
- Theme and utility information
- Organized in accessible card layout

### ⚡ Features
- Visual feature overview
- Detailed capability descriptions
- Technology stack information
- Development environment highlights

### 🔧 Installation
- Step-by-step installation methods
- System requirements
- Warning about compatibility
- Code examples and commands

### 🐙 GitHub Integration
- Live repository statistics
- Direct links to GitHub sections
- Issue and pull request access
- Actions workflow status

## Technical Implementation

### File Structure
```
docs/
├── _config.yml          # Jekyll configuration
├── index.html           # Main interface HTML
├── assets/
│   ├── css/
│   │   └── far-style.css # FAR Manager styling
│   └── js/
│       └── far-interface.js # Interactive functionality
├── ISO_BUILDING.md      # Existing ISO documentation
└── README.md           # This file
```

### Technologies Used
- **HTML5** - Semantic markup and accessibility
- **CSS3** - FAR Manager styling and responsive design
- **Vanilla JavaScript** - Interactive functionality
- **Jekyll** - GitHub Pages static site generation
- **GitHub Actions** - Automated deployment

### Accessibility Features
- Full keyboard navigation
- Screen reader friendly
- High contrast color schemes
- Semantic HTML structure
- ARIA labels where appropriate
- Focus indicators for interactive elements

## Development

### Local Testing
To test the GitHub Pages site locally:

```bash
# Install Jekyll (requires Ruby)
gem install jekyll bundler

# Navigate to docs directory
cd docs

# Serve locally
jekyll serve

# Open http://localhost:4000 in browser
```

### Deployment
The site automatically deploys via GitHub Actions when changes are pushed to the `docs/` directory on the main branch.

### Customization
- Modify `assets/css/far-style.css` for styling changes
- Update `assets/js/far-interface.js` for functionality
- Edit `index.html` for content and structure changes
- Configure `_config.yml` for Jekyll settings

## Integration with OSVMarchi

The GitHub Pages site seamlessly integrates with the OSVMarchi project by:

- **ISO Downloads** - Direct links to GitHub Actions workflow artifacts
- **Documentation** - References existing docs and configuration files
- **Repository Links** - Quick access to source code and issues
- **Live Stats** - Real-time GitHub repository statistics
- **Brand Consistency** - Uses OSVMarchi ASCII logo and styling

This creates a cohesive experience that bridges the gap between the project repository and user-friendly documentation access.