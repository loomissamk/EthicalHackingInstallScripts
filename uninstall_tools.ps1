# Function to uninstall Git
function UninstallGit {
    # Uninstall Git if it's installed
    $gitInstalled = Test-Path -Path "C:\Program Files\Git\cmd\git.exe"

    if ($gitInstalled) {
        # Uninstall Git (example)
        # Uninstall-Item -Path "C:\Program Files\Git" -Recurse -Force
        Write-Host "Uninstalling Git..."
    }
}

# Function to uninstall a tool or package
function UninstallTool {
    param([string]$toolName)

    # Uninstall logic for each tool
    # Example: Uninstalling a hypothetical tool named 'toolName'
    if ($toolName -eq 'toolName') {
        # Uninstall 'toolName' using its uninstallation command
        # Example: Uninstalling 'toolName'
        # Remove-Item -Path "C:\Program Files\toolName" -Recurse -Force
        Write-Host "Uninstalling $toolName..."
    }
    # Extend this logic for each tool or package you want to uninstall
}

# Function to uninstall tools
function UninstallTools {
    # List of tools or packages to uninstall
    $toolsToUninstall = @(
        "metasploit-framework",
        "nmap",
        "wireshark",
        # Add other tools or packages to uninstall...
    )

    foreach ($tool in $toolsToUninstall) {
        UninstallTool -toolName $tool
    }
}

# Function to remove Git repositories directory
function RemoveGitRepositories {
    # Remove the directory containing Git repositories
    # Replace with your actual path to the directory
    $gitRepoDirectory = "C:\path\to\your\repositories"

    if (Test-Path -Path $gitRepoDirectory) {
        Remove-Item -Path $gitRepoDirectory -Recurse -Force
        Write-Host "Git repositories directory removed."
    }
}

# Uninstall Git, tools, and remove Git repositories directory
UninstallGit
UninstallTools
RemoveGitRepositories
