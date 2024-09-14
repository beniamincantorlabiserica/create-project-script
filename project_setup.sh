#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required dependencies
for cmd in git gh; do
    if ! command_exists "$cmd"; then
        echo "Error: $cmd is not installed. Please install it and try again."
        exit 1
    fi
done

# Prompt user for project type
echo "Choose a project type:"
echo "1) SvelteKit"
echo "2) Laravel"
echo "3) Avalonia MVVM"
read -p "Enter the number of your choice: " project_choice

case $project_choice in
    1) project_type="sveltekit" ;;
    2) project_type="laravel" ;;
    3) project_type="avalonia-mvvm" ;;
    *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

# Prompt user for project name
read -p "Enter a name for your application: " project_name

# Create GitHub repository first
echo "Creating GitHub repository..."
gh repo create "$project_name" --public --clone || {
    echo "Error: Failed to create GitHub repository. Please check your GitHub CLI authentication and permissions."
    exit 1
}

# Navigate to the cloned repository
cd "$project_name" || exit

# Initialize project based on type
case $project_type in
    sveltekit)
        echo "Initializing SvelteKit project..."
        npm create svelte@latest . -- --no-git
        npm install
        ;;
    laravel)
        echo "Initializing Laravel project..."
        composer create-project laravel/laravel . --no-git
        ;;
    avalonia-mvvm)
        echo "Initializing Avalonia MVVM project..."
        dotnet new avalonia.mvvm -n "$project_name" --no-git
        mv ./$project_name/* .
        rm -rf ./$project_name
        ;;
esac

# Add all files, commit, and push to GitHub
git add .
git commit -m "Initial commit: Add $project_type project files"
git push -u origin main || git push -u origin master

echo "Project setup complete. Your $project_type project '$project_name' is now connected to GitHub."