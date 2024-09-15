# 🚀 Awesome Project Setup Script

## 🎭 What is this?
This script automates the process of setting up a new project, creating a GitHub repository, and pushing the initial commit. It's like having a personal assistant for your coding projects! 🤖✨

## 🤔 Why did I create this?
I was tired of repeating the same steps every time I started a new project. This script saves time and reduces errors in the initial setup process. Work smarter, not harder! 💡

## 🌟 Features
- 🎨 Supports multiple project types:
  - SvelteKit 🧡
  - Laravel 🐘
  - Avalonia MVVM 🖥️
- 🐙 Automatically creates a GitHub repository
- 🔗 Connects your local project to the GitHub repo
- 🚀 Initializes the project with the chosen framework
- 📦 Commits and pushes the initial project files

## 🛠️ How to Use

### Prerequisites
Make sure you have these installed:
- Git 🌳
- GitHub CLI (gh) 🐙
- Node.js and npm (for SvelteKit) 📦
- Composer (for Laravel) 🎼
- .NET SDK (for Avalonia) 🔷

### Steps
1. 📥 Download the `project_setup.sh` script
2. 🔐 Make it executable:
   ```
   chmod +x project_setup.sh
   ```
3. 🔑 Authenticate with GitHub CLI (if you haven't):
   ```
   gh auth login
   ```
4. 🚀 Run the script:
   ```
   ./project_setup.sh
   ```
5. 🎉 Follow the prompts and watch the magic happen!

## 🐛 Troubleshooting
If you encounter any issues, make sure:
- 🔒 You're authenticated with GitHub CLI
- 📡 You have a stable internet connection
- 🛠️ All required tools are properly installed

## 🤝 Contributing
Feel free to fork, improve, and submit pull requests. Let's make this script even more awesome together! 🌟

## 📜 License
This project is open source and available under the [MIT License](LICENSE).

Happy coding! 💻😊
