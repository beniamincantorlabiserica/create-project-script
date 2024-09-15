# 🚀 Project Setup Script

## 🎭 What is this?
This repository contains scripts that automate the process of setting up a new project, creating a GitHub repository, and pushing the initial commit. It's like having a personal assistant for your coding projects! 🤖✨

## 🤔 Why did I create this?
I was tired of repeating the same steps every time I started a new project. These scripts save time and reduce errors in the initial setup process. Work smarter, not harder! 💡

## 🌟 Features
- 🎨 Supports multiple project types:
  - SvelteKit 🧡
  - Laravel 🐘
  - Avalonia MVVM 🖥️
- 🐙 Automatically creates a GitHub repository
- 🔗 Connects your local project to the GitHub repo
- 🚀 Initializes the project with the chosen framework
- 📦 Commits and pushes the initial project files
- 🖥️ Cross-platform support: Unix-like systems (macOS, Linux) and Windows

## 🛠️ How to Use

### Prerequisites
Make sure you have these installed:
- Git 🌳
- GitHub CLI (gh) 🐙
- Node.js and npm (for SvelteKit) 📦
- Composer (for Laravel) 🎼
- .NET SDK (for Avalonia) 🔷

### Steps for Unix-like systems (macOS, Linux)

1. 📥 Download the `project_setup_unix.sh` script
2. 🔐 Make it executable:
   ```
   chmod +x project_setup_unix.sh
   ```
3. 🔑 Authenticate with GitHub CLI (if you haven't):
   ```
   gh auth login
   ```
4. 🚀 Run the script:
   ```
   ./project_setup_unix.sh
   ```
5. 🎉 Follow the prompts and watch the magic happen!

### Steps for Windows

1. 📥 Download the `project_setup_windows.ps1` script
2. 🔓 Open PowerShell as an administrator
3. 🔐 Set the execution policy to run scripts (if needed):
   ```
   Set-ExecutionPolicy RemoteSigned
   ```
4. 🔑 Authenticate with GitHub CLI (if you haven't):
   ```
   gh auth login
   ```
5. 🚀 Navigate to the script's directory and run:
   ```
   .\project_setup_windows.ps1
   ```
6. 🎉 Follow the prompts and watch the magic happen!

## 🐛 Troubleshooting
If you encounter any issues, make sure:
- 🔒 You're authenticated with GitHub CLI
- 📡 You have a stable internet connection
- 🛠️ All required tools are properly installed and accessible from the command line
- 🖥️ For Windows: PowerShell execution policy allows running scripts

## 🤝 Contributing
Feel free to fork, improve, and submit pull requests. Let's make these scripts even more awesome together! 🌟

## 📜 License
This project is open source and available under the [MIT License](LICENSE).

Happy coding! 💻😊
