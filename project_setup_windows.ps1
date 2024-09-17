# Windows Project Setup Script

# Function to check if a command exists
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Check for required dependencies
$dependencies = @("git", "gh", "composer", "npm", "dotnet")
foreach ($dep in $dependencies) {
    if (-not (Test-Command $dep)) {
        Write-Host "Error: $dep is not installed. Please install it and try again."
        exit 1
    }
}

# Prompt user for project type
Write-Host "Choose a project type:"
Write-Host "1) SvelteKit"
Write-Host "2) Laravel"
Write-Host "3) Avalonia MVVM"
$project_choice = Read-Host "Enter the number of your choice"

switch ($project_choice) {
    1 { $project_type = "sveltekit" }
    2 { $project_type = "laravel" }
    3 { $project_type = "avalonia-mvvm" }
    default { 
        Write-Host "Invalid choice. Exiting."
        exit 1
    }
}

# Prompt user for project name
$project_name = Read-Host "Enter a name for your application"

# Create GitHub repository if it doesn't exist
Write-Host "Creating GitHub repository..."
if (-not (gh repo view $project_name 2>$null)) {
    gh repo create $project_name --public --confirm
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to create GitHub repository. Please check your GitHub CLI authentication and permissions."
        exit 1
    }
}
else {
    Write-Host "Repository $project_name already exists. Skipping creation."
}

# Clone the repository if it doesn't exist locally
if (-not (Test-Path $project_name)) {
    gh repo clone $project_name
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to clone the repository."
        exit 1
    }
}

# Navigate to the project directory
Set-Location $project_name

# Initialize project based on type
switch ($project_type) {
    "sveltekit" {
        Write-Host "Initializing SvelteKit project..."
        npm create svelte@latest . -- --typescript
        npm install
    }
    "laravel" {
        Write-Host "Initializing Laravel project..."
        $temp_dir = New-TemporaryFile | ForEach-Object { Remove-Item $_; New-Item -ItemType Directory -Path $_.FullName }
        composer create-project laravel/laravel $temp_dir
        Get-ChildItem -Path $temp_dir -Recurse | Where-Object { $_.FullName -notlike "*\.git*" } | Copy-Item -Destination . -Recurse -Force
        Remove-Item -Path $temp_dir -Recurse -Force
        if (-not (Test-Path .gitignore)) {
            @"/vendor/", "/node_modules/", ".env" | Out-File -FilePath .gitignore
        }
    }
    "avalonia-mvvm" {
        Write-Host "Initializing Avalonia MVVM project..."
        dotnet new avalonia.mvvm -n $project_name
        Get-ChildItem -Path $project_name | Move-Item -Destination . -Force
        Remove-Item -Path $project_name -Recurse -Force
    }
}

# Add all files, commit, and push to GitHub
# git add .
# git status  # Debug: Check what's being staged
# git commit -m "Initial commit: Add $project_type project files"

# Determine the default branch name
$default_branch = git rev-parse --abbrev-ref HEAD

# Try pushing to the default branch
if (git push -u origin $default_branch) {
    Write-Host "Successfully pushed to $default_branch branch."
}
else {
    # If pushing to the default branch fails, try the other common branch name
    $other_branch = if ($default_branch -eq "main") { "master" } else { "main" }
    if (git push -u origin "${default_branch}:${other_branch}") {
        Write-Host "Successfully pushed to $other_branch branch."
        # Set the local branch to track the remote branch
        git branch --set-upstream-to="origin/$other_branch" $default_branch
    }
    else {
        Write-Host "Failed to push to both main and master branches. Please check your repository settings and try again."
        exit 1
    }
}
/
# revised on windows - missing a lot of packages and dependencies

Write-Host "Project setup complete. Your $project_type project '$project_name' is now connected to GitHub."