#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Git is installed, install if necessary
if ! command_exists git; then
    echo "Git is not installed. Installing..."
    if [ "$EUID" -ne 0 ]; then
        echo "This operation requires superuser privileges to install Git."
        exit 1
    else
        sudo apt-get update
        sudo apt-get install -y git
    fi
fi

# Create a directory to install tools
install_dir="$HOME/ethical_tools"
mkdir -p "$install_dir"
cd "$install_dir" || exit

declare -a github_repos=(
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


# List of apt packages
declare -a apt_packages=(
    "metasploit-framework"
    "nmap"
    "wireshark"
    "john"
    "hydra"
    "aircrack-ng"
    "king-phisher"
    "patator"
    "cmsmap"
    "commix"
    # Add other apt packages...
)

# Function to clone GitHub repositories
clone_repositories() {
    for repo in "${github_repos[@]}"
    do
        git clone "$repo"
    done
}

# Function to install apt packages
install_apt_packages() {
    sudo apt-get update  # Update package lists before installing
    for package in "${apt_packages[@]}"
    do
        sudo apt-get install -y "$package"
    done
}

# Function to install tools after cloning
install_tools() {
    # Loop through each repository
    for repo in "${github_repos[@]}"
    do
        # Get the repository name from the URL
        repo_name=$(basename "$repo" .git)
       
        # Change directory to the repository
        cd "$repo_name" || continue

        # Check if there's an installation script or Python-based setup
        if [ -f "install.sh" ]; then
            # If there's an installation script, execute it
            bash install.sh
        elif [ -f "setup.py" ]; then
            # If there's a setup.py file, run the installation using pip
            python setup.py install
        elif [ -f "requirements.txt" ]; then
            # If there's a requirements.txt file, install dependencies using pip
            pip install -r requirements.txt
        else
            # Add other checks or installation procedures as needed for different repositories
            echo "No installation instructions found for $repo_name"
        fi
       
        # Return to the main directory
        cd ..
    done
}

# Execute functions
clone_repositories
install_apt_packages
install_tools