#!/bin/bash
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required dependencies
for cmd in git gh composer npm dotnet; do
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

# Create GitHub repository if it doesn't exist
echo "Creating GitHub repository..."
if ! gh repo view "$project_name" &>/dev/null; then
    gh repo create "$project_name" --public --confirm || {
        echo "Error: Failed to create GitHub repository. Please check your GitHub CLI authentication and permissions."
        exit 1
    }
else
    echo "Repository $project_name already exists. Skipping creation."
fi

# Clone the repository if it doesn't exist locally
if [ ! -d "$project_name" ]; then
    gh repo clone "$project_name" || {
        echo "Error: Failed to clone the repository."
        exit 1
    }
fi

# Navigate to the project directory
cd "$project_name" || exit

# Initialize project based on type
case $project_type in
    sveltekit)
        echo "Initializing SvelteKit project..."
        npm create svelte@latest . -- --typescript
        npm install
        ;;
    laravel)
        echo "Initializing Laravel project..."
        # Create a temporary directory
        temp_dir=$(mktemp -d)
        # Create Laravel project in the temporary directory
        composer create-project laravel/laravel "$temp_dir"
        # Move contents of temp directory to current directory, excluding .git
        rsync -a --exclude='.git' "$temp_dir"/ .
        # Remove temp directory
        rm -rf "$temp_dir"
        # Ensure .gitignore is present
        [ ! -f .gitignore ] && echo "/vendor/\n/node_modules/\n.env" > .gitignore
        ;;
    avalonia-mvvm)
        echo "Initializing Avalonia MVVM project..."
        dotnet new avalonia.mvvm -n "$project_name"
        mv ./$project_name/* .
        rm -rf ./$project_name
        ;;
esac

# Add all files, commit, and push to GitHub
git add .
git status  # Debug: Check what's being staged
git commit -m "Initial commit: Add $project_type project files"

# Determine the default branch name
default_branch=$(git rev-parse --abbrev-ref HEAD)

# Try pushing to the default branch
if git push -u origin "$default_branch"; then
    echo "Successfully pushed to $default_branch branch."
else
    # If pushing to the default branch fails, try the other common branch name
    other_branch=$([ "$default_branch" = "main" ] && echo "master" || echo "main")
    if git push -u origin "$default_branch:$other_branch"; then
        echo "Successfully pushed to $other_branch branch."
        # Set the local branch to track the remote branch
        git branch --set-upstream-to="origin/$other_branch" "$default_branch"
    else
        echo "Failed to push to both main and master branches. Please check your repository settings and try again."
        exit 1
    fi
fi

echo "Project setup complete. Your $project_type project '$project_name' is now connected to GitHub."