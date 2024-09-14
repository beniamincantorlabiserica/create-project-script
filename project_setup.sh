#!/bin/bash

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
echo "3) Avalonia"
read -p "Enter the number of your choice: " project_choice

case $project_choice in
    1) project_type="sveltekit" ;;
    2) project_type="laravel" ;;
    3) project_type="avalonia" ;;
    *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

# Prompt user for project name
read -p "Enter a name for your application: " project_name

# Create project directory
mkdir "$project_name"
cd "$project_name" || exit

# Initialize project based on type
case $project_type in
    sveltekit)
        npm create svelte@latest .
        npm install
        ;;
    laravel)
        composer create-project laravel/laravel .
        ;;
    avalonia)
        dotnet new avalonia.app -n "$project_name"
        ;;
esac

# Initialize git repository
git init

# Create GitHub repository
gh repo create "$project_name" --public --source=. --remote=origin

# Determine the default branch name
default_branch=$(git symbolic-ref --short HEAD)

# Add all files, commit, and push to GitHub
git add .
git commit -m "Initial commit"
git push -u origin "$default_branch"

echo "Project setup complete. Your $project_type project '$project_name' is now connected to GitHub."