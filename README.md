# 🎱 SnookerNet

A decentralized snooker game built on StarkNet where players can compete, earn tokens, and collect NFTs.

## 🌟 Features

- **Play-to-Earn**: Earn GRUFT tokens and NFTs by playing and winning matches
- **NFT System**: Collect and trade unique cues, tables, and achievements
- **DAO Governance**: Community-driven game development and rule changes
- **Social Features**: Trophy rooms and player achievements
- **AI Challenges**: Train and compete against AI opponents
- **AR Integration**: Real-world location-based features

## 🔧 Technology Stack

- StarkNet Smart Contracts (Cairo)
- ERC20 (GRUFT Token)
- ERC721 (Game NFTs)
- Decentralized Storage (IPFS)

## 📦 Prerequisites

Before you begin, ensure you have installed:
- [asdf version manager](https://asdf-vm.com/guide/getting-started.html)
- Required asdf plugins:
  ```bash
  asdf plugin add scarb
  asdf plugin add starknet-foundry
  ```

The project uses specific versions of tools defined in `.tool-versions`:
```
scarb 2.10.1
starknet-foundry 0.38.0
```

## 🚀 Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/snooknet_contract.git
cd snooknet_contract
```

2. Install tool versions (this will read from .tool-versions):
```bash
asdf install
```

3. Verify installations:
```bash
scarb --version    # Should show 2.10.1
snforge --version  # Should show 0.38.0
```

4. Install dependencies:
```bash
scarb install
```

5. Build the project:
```bash
scarb build
```

6. Run tests:
```bash
scarb test
```

## 🤝 Contributing

We welcome contributions from the community! Before you start:

### Prerequisites for Contributors
1. ⭐ Star the repository (required before working on any issue)
2. 📱 Share your Telegram handle in your PR (for community communication)
3. 🎯 Comment on the issue you want to work on
4. 🔄 Wait for assignment before starting work

### First Time Contributors
1. Star the repository
2. Join our [Telegram Community](your-telegram-link)
3. Read through our documentation
4. Look for issues tagged with `good-first-issue`

### Git Workflow

1. **Fork the Repository**
   - Fork the main repository to your GitHub account
   - Clone your fork locally

2. **Branch Naming Convention**
   - feature/[feature-name] (e.g., feature/ai-challenge)
   - fix/[bug-name] (e.g., fix/stake-calculation)
   - docs/[doc-name] (e.g., docs/api-documentation)
   - refactor/[refactor-name] (e.g., refactor/game-logic)

3. **Development Process**
   ```bash
   # Create a new branch
   git checkout -b feature/your-feature

   # Make your changes
   git add .
   git commit -m "feat: description of your changes"

   # Keep your branch updated
   git fetch origin
   git rebase origin/main

   # Push changes
   git push origin feature/your-feature
   ```

4. **Commit Message Convention**
   - feat: New feature
   - fix: Bug fix
   - docs: Documentation changes
   - style: Code style changes (formatting, etc)
   - refactor: Code refactoring
   - test: Test-related changes
   - chore: Regular maintenance tasks

5. **Pull Request Process**
   - Create PR against the main branch
   - Fill out the PR template
   - Request review from maintainers
   - Address review comments
   - Ensure CI passes

### Code Style Guidelines

1. **Cairo Style**
   - Use SCREAMING_SNAKE_CASE for constants
   - Use PascalCase for trait names and structs
   - Use snake_case for functions and variables
   - Add comprehensive comments for complex logic

2. **Interface Organization**
   - All interface files should be in UPPERCASE (e.g., IGRUFT.cairo)
   - Group related functions with clear comments
   - Include comprehensive documentation for public functions

3. **Testing Requirements**
   - Unit tests for all new functions
   - Integration tests for feature interactions
   - Test coverage should be maintained or improved

## 🏗️ Project Structure

```
snooknet_contract/
├── src/
│   ├── interfaces/     # Contract interfaces
│   ├── contracts/      # Implementation contracts
│   ├── tests/         # Test files
│   └── types/         # Common types and structs
├── scripts/           # Deployment and utility scripts
└── docs/             # Documentation
```

## 🧪 Testing

```bash
# Run all tests
scarb test

# Run specific test file
scarb test tests/game_test.cairo
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Code of Conduct

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

## 🔗 Useful Links

- [Documentation](docs/README.md)
- [StarkNet Documentation](https://docs.starknet.io)
- [Cairo Book](https://book.cairo-lang.org)
- [Discord Community](your-discord-link)

## 🚨 Security

If you discover any security-related issues, please email security@snookernet.com instead of using the issue tracker.

## ✨ Contributors

Thanks goes to these wonderful people:

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <!-- Add contributor images and links here -->
  </tr>
</table>
<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://allcontributors.org) specification.

## 🌟 Support the Project

If you find this project useful, please consider:
- Starring the repository
- Contributing code or documentation
- Sharing the project with others

## 🛠️ Development Setup

### Tool Versions
We use `.tool-versions` to maintain consistent development environments. If you're using a different version manager, ensure you have these versions:

```
scarb 2.10.1
starknet-foundry 0.38.0
```

To update your local tools to match the project:
```bash
# Using asdf
asdf install          # Installs all tools at versions specified in .tool-versions
asdf current          # Verify your active tool versions

# Manual installation
scarb --version       # Verify Scarb version
snforge --version     # Verify StarkNet Foundry version
``` 