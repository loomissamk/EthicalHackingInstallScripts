# Function to check if a command exists
function CommandExists {
    param([string]$command)
    try {
        $null = Get-Command $command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Check if Git is installed, install if necessary
if (-Not (CommandExists "git")) {
    Write-Host "Git is not installed. Installing..."

    # Check for Chocolatey package manager and install Git
    if (-Not (CommandExists "choco")) {
        Write-Host "Chocolatey is not installed. Please install it and rerun this script."
        exit 1
    }

    choco install git -y
}

# Create a directory to install tools
$install_dir = "$env:USERPROFILE\ethical_tools"
New-Item -ItemType Directory -Path $install_dir -Force | Out-Null
Set-Location -Path $install_dir

# List of GitHub repositories
$github_repos = @(
    # Existing repositories...
)

# Function to clone GitHub repositories
function CloneRepositories {
    param([string[]]$repos)

    foreach ($repo in $repos) {
        git clone $repo

        # Return to the main directory
        Set-Location -Path $install_dir
    }
}

# Call the function to clone repositories
CloneRepositories -repos $github_repos

# Function to install tools after cloning
function InstallTools {
    param([string[]]$repos)

    foreach ($repo in $repos) {
        # Get the repository name from the URL
        $repoName = [System.IO.Path]::GetFileNameWithoutExtension($repo)

        # Change directory to the repository
        Set-Location -Path "$install_dir\$repoName" -ErrorAction SilentlyContinue

        # Check if there's an installation script or setup file
        if (Test-Path "install.ps1") {
            # If there's an installation script, execute it
            & ".\install.ps1"
        } elseif (Test-Path "setup.py") {
            # If there's a setup.py file, run the installation
            python setup.py install
        } elseif (Test-Path "requirements.txt") {
            # If there's a requirements.txt file, install dependencies
            pip install -r requirements.txt
        } else {
            # Add other checks or installation procedures as needed for different repositories
            Write-Host "No installation instructions found for $repoName"
        }

        # Return to the main directory
        Set-Location -Path $install_dir
    }
}

# Call the function to install tools
InstallTools -repos $github_repos

# Additional GitHub repositories for ethical hacking tools on Windows
# List of GitHub repositories
$github_repos = @(
    "https://github.com/rapid7/metasploit-framework.git"
    "https://github.com/wireshark/wireshark.git"
    "https://github.com/sullo/nikto.git"
    "https://github.com/Mr-xn/BurpSuite-collections.git"
    "https://github.com/nmap/nmap.git"
    "https://github.com/daniel-cues/NMapGUI.git"
    "https://github.com/vanhauser-thc/thc-hydra.git"
    "https://github.com/sqlmapproject/sqlmap.git"
    "https://github.com/codingo/NoSQLMap.git"
    "https://github.com/allfro/sploitego.git"
    "https://github.com/Datalux/Osintgram.git"
    "https://github.com/lanmaster53/recon-ng.git"
    "https://github.com/aircrack-ng/aircrack-ng.git"
    "https://github.com/Open-Security-Group-OSG/HiddenEyeReborn.git"
    "https://github.com/beelogger/RPi-Beelogger.git"
    "https://github.com/iobee-org/beelogger-web.git"
    "https://github.com/4w4k3/BeeLogger.git"
    "https://github.com/sdrausty/evil-ssdp.git"
    "https://github.com/Optane002/ZPhisher.git"
    "https://github.com/wpscanteam/wpscan.git"
    "https://github.com/swisskyrepo/Wordpresscan.git"
    "https://github.com/hashcat/ophcrack.git"
    "https://github.com/foreni-packages/ophcrack.git"
    "https://github.com/CrypToolProject/CrypTool-2.git"
    "https://github.com/panther-labs/panther-analysis.git"
    "https://github.com/buildbot/botherders.git"
    "https://github.com/SpiderLabs/Responder.git"
    "https://github.com/EmpireProject/Empire.git"
    "https://github.com/nomikugg/CrackMapExec.git"
    "https://github.com/byt3bl33d3r/CrackMapExec.git"
    "https://github.com/BloodHoundAD/BloodHound.git"
    "https://github.com/dirkjanm/BloodHound.py.git"
    "https://github.com/S1lkys/shellphishSS.git"
    "https://github.com/GiacomoLaw/Keylogger.git"
    "https://github.com/aydinnyunus/Keylogger.git"
    "https://github.com/ajayrandhawa/Keylogger.git"
    "https://github.com/TermuxHackz/wifi-cracker.git"
    "https://github.com/adelashraf/cenarius.git"
    "https://github.com/openwall/johnny.git"
    "https://github.com/lakiw/pcfg_cracker.git"
    "https://github.com/NorthernSec/VeraCracker.git"
    "https://github.com/MatrixTM/MHDDoS.git"
    "https://github.com/cyweb/hammer.git"
    "https://github.com/byt3bl33d3r/MITMf.git"
    "https://github.com/LionSec/xerosploit.git"
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/securestate/king-phisher.git" # King Phisher from Kali
    "https://github.com/lanjelot/patator.git" # Patator from Kali
    "https://github.com/Dionach/CMSmap.git" # CMSmap from Kali
    "https://github.com/commixproject/commix.git" # Commix from Kali
    "https://github.com/vanhauser-thc/thc-hydra.git" # THC-Hydra (included again for completeness)
    "https://github.com/EgeBalci/The-Eye.git" # The Eye from Parrot OS
    # Add any other GitHub repositories here
)

# Merge the additional repositories with the existing ones
$github_repos += $additional_repos

# Call the function to clone repositories
CloneRepositories -repos $github_repos

# Function to install additional tools after cloning
function InstallAdditionalTools {
    param([string[]]$additionalRepos)

    foreach ($repo in $additionalRepos) {
        # Get the repository name from the URL
        $repoName = [System.IO.Path]::GetFileNameWithoutExtension($repo)

        # Change directory to the repository
        Set-Location -Path "$install_dir\$repoName" -ErrorAction SilentlyContinue

        # Check if there's an installation script or setup file
        if (Test-Path "install.ps1") {
            # If there's an installation script, execute it
            & ".\install.ps1"
        } elseif (Test-Path "setup.py") {
            # If there's a setup.py file, run the installation
            python setup.py install
        } elseif (Test-Path "requirements.txt") {
            # If there's a requirements.txt file, install dependencies
            pip install -r requirements.txt
        } else {
            # Add other checks or installation procedures as needed for different repositories
            Write-Host "No installation instructions found for $repoName"
        }

        # Return to the main directory
        Set-Location -Path $install_dir
    }
}

# Call the function to install additional tools
InstallAdditionalTools -additionalRepos $additional_repos
