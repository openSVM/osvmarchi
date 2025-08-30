// FAR Manager Style JavaScript Interface
class FARInterface {
    constructor() {
        this.currentTheme = 'default';
        this.searchIndex = [];
        this.init();
    }

    init() {
        this.updateTime();
        this.setupEventListeners();
        this.loadAsciiLogo();
        this.buildSearchIndex();
        this.loadGitHubStats();
        
        // Update time every second
        setInterval(() => this.updateTime(), 1000);
    }

    updateTime() {
        const now = new Date();
        const timeString = now.toLocaleTimeString('en-US', {
            hour12: false,
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        const dateString = now.toLocaleDateString('en-US', {
            month: '2-digit',
            day: '2-digit',
            year: 'numeric'
        });
        
        const timeElement = document.getElementById('current-time');
        if (timeElement) {
            timeElement.textContent = `${dateString} ${timeString}`;
        }
    }

    setupEventListeners() {
        // Navigation item clicks
        document.querySelectorAll('.file-item').forEach(item => {
            item.addEventListener('click', (e) => {
                this.selectNavItem(item);
                const target = item.dataset.target;
                if (target) {
                    this.showContent(target);
                }
            });
        });

        // Keyboard navigation
        document.addEventListener('keydown', (e) => {
            this.handleKeyboard(e);
        });

        // Search input
        const searchInput = document.getElementById('search-input');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.performSearch(e.target.value);
            });
            
            searchInput.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') {
                    this.toggleSearch();
                }
            });
        }

        // Modal clicks
        document.getElementById('modal').addEventListener('click', (e) => {
            if (e.target.id === 'modal') {
                this.closeModal();
            }
        });

        // Focus management for accessibility
        document.querySelectorAll('.file-item, .menu-item').forEach(item => {
            item.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    item.click();
                }
            });
        });
    }

    selectNavItem(selectedItem) {
        document.querySelectorAll('.file-item').forEach(item => {
            item.classList.remove('selected');
        });
        selectedItem.classList.add('selected');
    }

    showContent(contentId) {
        // Hide all content pages
        document.querySelectorAll('.content-page').forEach(page => {
            page.classList.remove('active');
        });

        // Show selected content
        const targetContent = document.getElementById(`${contentId}-content`);
        if (targetContent) {
            targetContent.classList.add('active');
        }

        // Handle special cases
        if (contentId === 'github') {
            this.loadGitHubStats();
        }
    }

    handleKeyboard(e) {
        // Function key handlers
        switch(e.key) {
            case 'F1':
                e.preventDefault();
                this.showHelp();
                break;
            case 'F3':
                e.preventDefault();
                this.toggleSearch();
                break;
            case 'F5':
                e.preventDefault();
                this.showContent('downloads');
                break;
            case 'F6':
                e.preventDefault();
                window.open('https://github.com/openSVM/osvmarchi', '_blank');
                break;
            case 'F7':
                e.preventDefault();
                this.toggleTheme();
                break;
            case 'F8':
                e.preventDefault();
                this.showContent('features');
                break;
            case 'F10':
                e.preventDefault();
                this.showAbout();
                break;
            case 'Escape':
                e.preventDefault();
                this.closeModal();
                this.hideSearch();
                break;
        }

        // Arrow key navigation in nav panel
        if (e.target.classList.contains('file-item')) {
            const navItems = Array.from(document.querySelectorAll('.file-item'));
            const currentIndex = navItems.indexOf(e.target);
            
            switch(e.key) {
                case 'ArrowUp':
                    e.preventDefault();
                    if (currentIndex > 0) {
                        navItems[currentIndex - 1].focus();
                    }
                    break;
                case 'ArrowDown':
                    e.preventDefault();
                    if (currentIndex < navItems.length - 1) {
                        navItems[currentIndex + 1].focus();
                    }
                    break;
            }
        }
    }

    loadAsciiLogo() {
        const logoContent = `████████████████████████████████████████████████████████████████████
█▌................................................................▐█
█▌................................................................▐█
█▌................................................................▐█
█▌................................................................▐█
█▌........███████.....█████████..█████...█████.██████...██████....▐█
█▌......███░░░░░███..███░░░░░███░░███...░░███.░░██████.██████.....▐█
█▌.....███.....░░███░███....░░░..░███....░███..░███░█████░███.....▐█
█▌....░███......░███░░█████████..░███....░███..░███░░███.░███.....▐█
█▌....░███......░███.░░░░░░░░███.░░███...███...░███.░░░..░███.....▐█
█▌....░░███.....███..███....░███..░░░█████░....░███......░███.....▐█
█▌.....░░░███████░..░░█████████.....░░███......█████.....█████....▐█
█▌.......░░░░░░░.....░░░░░░░░░.......░░░......░░░░░.....░░░░░.....▐█
█▌................................................................▐█
█▌................................................................▐█
█▌................................................................▐█
█▌................................................................▐█
████████████████████████████████████████████████████████████████████`;

        const logoElement = document.getElementById('ascii-logo');
        if (logoElement) {
            logoElement.textContent = logoContent;
        }
    }

    buildSearchIndex() {
        this.searchIndex = [
            { term: 'install', content: 'installation', description: 'Installation instructions and requirements' },
            { term: 'iso', content: 'downloads', description: 'Download ISO images for different architectures' },
            { term: 'download', content: 'downloads', description: 'Download pre-built ISO images' },
            { term: 'arch', content: 'downloads', description: 'Architecture-specific optimizations' },
            { term: 'zen4', content: 'downloads', description: 'AMD Zen4 optimized ISO' },
            { term: 'zen5', content: 'downloads', description: 'AMD Zen5 optimized ISO' },
            { term: 'epyc', content: 'downloads', description: 'AMD EPYC optimized ISO' },
            { term: 'threadripper', content: 'downloads', description: 'AMD Threadripper optimized ISO' },
            { term: 'x86_64', content: 'downloads', description: 'Generic x86_64 ISO' },
            { term: 'amd64', content: 'downloads', description: 'AMD64 baseline ISO' },
            { term: 'hyprland', content: 'features', description: 'Hyprland window manager features' },
            { term: 'solana', content: 'features', description: 'Solana development environment' },
            { term: 'themes', content: 'features', description: 'Available color themes' },
            { term: 'packages', content: 'features', description: '118+ curated packages' },
            { term: 'utilities', content: 'features', description: '84+ utility commands' },
            { term: 'github', content: 'github', description: 'GitHub repository and statistics' },
            { term: 'docs', content: 'documentation', description: 'Documentation and guides' },
            { term: 'config', content: 'documentation', description: 'Configuration options' },
            { term: 'help', content: 'home', description: 'Help and support information' }
        ];
    }

    performSearch(query) {
        const results = document.getElementById('search-results');
        if (!results || !query.trim()) {
            if (results) results.innerHTML = '';
            return;
        }

        const matches = this.searchIndex.filter(item => 
            item.term.toLowerCase().includes(query.toLowerCase()) ||
            item.description.toLowerCase().includes(query.toLowerCase())
        );

        results.innerHTML = '';
        matches.forEach(match => {
            const resultDiv = document.createElement('div');
            resultDiv.className = 'search-result';
            resultDiv.innerHTML = `
                <strong>${match.term}</strong><br>
                <small>${match.description}</small>
            `;
            resultDiv.addEventListener('click', () => {
                this.showContent(match.content);
                this.toggleSearch();
            });
            results.appendChild(resultDiv);
        });
    }

    async loadGitHubStats() {
        try {
            const response = await fetch('https://api.github.com/repos/openSVM/osvmarchi');
            const data = await response.json();
            
            const starsElement = document.getElementById('github-stars');
            const forksElement = document.getElementById('github-forks');
            const issuesElement = document.getElementById('github-issues');
            
            if (starsElement) starsElement.textContent = data.stargazers_count || '-';
            if (forksElement) forksElement.textContent = data.forks_count || '-';
            if (issuesElement) issuesElement.textContent = data.open_issues_count || '-';
        } catch (error) {
            console.log('Could not load GitHub stats:', error);
        }
    }

    toggleSearch() {
        const searchBar = document.getElementById('search-bar');
        const searchInput = document.getElementById('search-input');
        
        if (searchBar.classList.contains('hidden')) {
            searchBar.classList.remove('hidden');
            searchInput.focus();
        } else {
            searchBar.classList.add('hidden');
            searchInput.value = '';
            document.getElementById('search-results').innerHTML = '';
        }
    }

    hideSearch() {
        const searchBar = document.getElementById('search-bar');
        if (!searchBar.classList.contains('hidden')) {
            searchBar.classList.add('hidden');
            document.getElementById('search-input').value = '';
            document.getElementById('search-results').innerHTML = '';
        }
    }

    toggleTheme() {
        const themes = ['default', 'green', 'amber', 'blue'];
        const currentIndex = themes.indexOf(this.currentTheme);
        const nextIndex = (currentIndex + 1) % themes.length;
        this.currentTheme = themes[nextIndex];
        
        document.body.className = `theme-${this.currentTheme}`;
        
        // Update CSS variables based on theme
        const root = document.documentElement;
        switch(this.currentTheme) {
            case 'green':
                root.style.setProperty('--bg-primary', '#004000');
                root.style.setProperty('--bg-secondary', '#008000');
                root.style.setProperty('--text-secondary', '#00ff00');
                break;
            case 'amber':
                root.style.setProperty('--bg-primary', '#404000');
                root.style.setProperty('--bg-secondary', '#808000');
                root.style.setProperty('--text-secondary', '#ffff00');
                break;
            case 'blue':
                root.style.setProperty('--bg-primary', '#000040');
                root.style.setProperty('--bg-secondary', '#000080');
                root.style.setProperty('--text-secondary', '#00ffff');
                break;
            default:
                root.style.setProperty('--bg-primary', '#000080');
                root.style.setProperty('--bg-secondary', '#008080');
                root.style.setProperty('--text-secondary', '#ffff00');
                break;
        }
    }

    showHelp() {
        this.showModal('Help - OSVMarchi FAR Interface', `
            <h3>🔤 Keyboard Shortcuts</h3>
            <div style="margin: 15px 0;">
                <strong>F1</strong> - Show this help<br>
                <strong>F3</strong> - Toggle search<br>
                <strong>F5</strong> - Go to downloads<br>
                <strong>F6</strong> - Open GitHub repository<br>
                <strong>F7</strong> - Change theme<br>
                <strong>F8</strong> - Show features<br>
                <strong>F10</strong> - About OSVMarchi<br>
                <strong>ESC</strong> - Close modals/search<br>
                <strong>↑/↓</strong> - Navigate menu items<br>
                <strong>Enter/Space</strong> - Activate selected item
            </div>
            
            <h3>🖱️ Mouse Controls</h3>
            <div style="margin: 15px 0;">
                • Click navigation items to switch content<br>
                • Click bottom menu items for quick actions<br>
                • Use search to find specific content<br>
                • All download links open in new tabs
            </div>
            
            <h3>📱 Mobile Support</h3>
            <div style="margin: 15px 0;">
                Interface adapts to mobile devices with responsive design and touch-friendly controls.
            </div>
        `);
    }

    showAbout() {
        this.showModal('About OSVMarchi', `
            <div style="text-align: center; margin-bottom: 20px;">
                <h2 style="color: var(--text-secondary);">OSVMarchi</h2>
                <p><strong>Version:</strong> 1.0</p>
                <p><strong>License:</strong> MIT</p>
            </div>
            
            <h3>🎯 Mission</h3>
            <p>Transform a fresh Arch Linux installation into a fully-configured, beautiful, and modern Solana and web development system based on Hyprland.</p>
            
            <h3>✨ Key Features</h3>
            <ul>
                <li>🪟 Hyprland window manager with stunning effects</li>
                <li>⚡ Optimized for Solana and web development</li>
                <li>🎨 Multiple beautiful themes</li>
                <li>🛠️ 84+ utility commands</li>
                <li>📦 118+ curated packages</li>
                <li>🔄 Automated updates and management</li>
            </ul>
            
            <h3>🏗️ Architecture Support</h3>
            <p>Pre-built ISOs available for x86_64, AMD64, Zen4, Zen5, EPYC, and Threadripper architectures with processor-specific optimizations.</p>
            
            <h3>🔗 Links</h3>
            <p>
                <a href="https://github.com/openSVM/osvmarchi" target="_blank" style="color: var(--text-highlight);">GitHub Repository</a><br>
                <a href="https://osvm.archi" target="_blank" style="color: var(--text-highlight);">Official Website</a>
            </p>
        `);
    }

    showModal(title, content) {
        document.getElementById('modal-title').textContent = title;
        document.getElementById('modal-body').innerHTML = content;
        document.getElementById('modal').classList.remove('hidden');
    }

    closeModal() {
        document.getElementById('modal').classList.add('hidden');
    }
}

// Global functions for event handlers
function showContent(contentId) {
    window.farInterface.showContent(contentId);
}

function toggleSearch() {
    window.farInterface.toggleSearch();
}

function toggleTheme() {
    window.farInterface.toggleTheme();
}

function showHelp() {
    window.farInterface.showHelp();
}

function showAbout() {
    window.farInterface.showAbout();
}

function closeModal() {
    window.farInterface.closeModal();
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.farInterface = new FARInterface();
});