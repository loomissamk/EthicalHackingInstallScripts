import subprocess
import os
import platform

def command_exists(command):
    try:
        subprocess.run(["where" if platform.system() == "Windows" else "which", command], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
        return True
    except subprocess.CalledProcessError:
        return False

def create_tools_directory():
    if platform.system() == "Windows":
        tools_dir = os.path.join(os.environ["USERPROFILE"], "tools")
    else:
        tools_dir = os.path.join(os.environ["HOME"], "tools")
    
    os.makedirs(tools_dir, exist_ok=True)
    os.chdir(tools_dir)

def install_git():
    if not command_exists("git"):
        print("Git is not installed. Installing...")

        if platform.system() == "Linux":
            if os.geteuid() != 0:
                print("This operation requires superuser privileges to install Git.")
                exit(1)
            else:
                subprocess.run(["sudo", "apt-get", "update"])
                subprocess.run(["sudo", "apt-get", "install", "-y", "git"])
        elif platform.system() == "Windows":
            print("Please download Git for Windows from https://git-scm.com/download/win and install it.")
            print("After installation, make sure 'git' is added to the PATH.")
            input("Press Enter to continue after installing Git...")
            # Here, add code to ensure Git is added to the PATH after installation on Windows
        elif platform.system() == "Darwin":  # macOS
            if not command_exists("brew"):
                print("Homebrew is not installed. Please install Homebrew from https://brew.sh/")
                exit(1)
            else:
                subprocess.run(["brew", "install", "git"])
        else:
            print("Unsupported operating system")
            exit(1)

def clone_repositories(repos):
    if platform.system() == "Windows":
        tools_dir = os.path.join(os.environ["USERPROFILE"], "tools")
    else:
        tools_dir = os.path.join(os.environ["HOME"], "tools")
    os.makedirs(tools_dir, exist_ok=True)
    os.chdir(tools_dir)
    
    for repo in repos:
        subprocess.run(["git", "clone", repo])

def install_apt_packages(packages):
    if platform.system() == "Linux":
        subprocess.run(["sudo", "apt-get", "update"])
        for package in packages:
            subprocess.run(["sudo", "apt-get", "install", "-y", package])

def install_tools(repos):
    if platform.system() == "Windows":
        tools_dir = os.path.join(os.environ["USERPROFILE"], "tools")
    else:
        tools_dir = os.path.join(os.environ["HOME"], "tools")
    
    for repo in repos:
        repo_name = os.path.splitext(os.path.basename(repo))[0]
        os.chdir(os.path.join(tools_dir, repo_name))
        
        if os.path.isfile("install.sh"):
            subprocess.run(["bash", "install.sh"])
        elif os.path.isfile("setup.py"):
            subprocess.run(["python", "setup.py", "install"])
        elif os.path.isfile("requirements.txt"):
            subprocess.run(["pip", "install", "-r", "requirements.txt"])
        else:
            print(f"No installation instructions found for {repo_name}")

def main():
    github_repos = [
        # List of GitHub repositories...
    ]
    
    apt_packages = [
        # List of apt packages...
    ]
    
    create_tools_directory()
    install_git()
    clone_repositories(github_repos)
    
    if platform.system() == "Linux":
        install_apt_packages(apt_packages)
    
    install_tools(github_repos)

if __name__ == "__main__":
    main()
    github_repos = [
    "https://github.com/rapid7/metasploit-framework.git",
    "https://github.com/wireshark/wireshark.git",
    "https://github.com/sullo/nikto.git",
    "https://github.com/Mr-xn/BurpSuite-collections.git",
    "https://github.com/nmap/nmap.git",
    "https://github.com/daniel-cues/NMapGUI.git",
    "https://github.com/vanhauser-thc/thc-hydra.git",
    "https://github.com/sqlmapproject/sqlmap.git",
    "https://github.com/codingo/NoSQLMap.git",
    "https://github.com/allfro/sploitego.git",
    "https://github.com/Datalux/Osintgram.git",
    "https://github.com/lanmaster53/recon-ng.git",
    "https://github.com/aircrack-ng/aircrack-ng.git",
    "https://github.com/Open-Security-Group-OSG/HiddenEyeReborn.git",
    "https://github.com/beelogger/RPi-Beelogger.git",
    "https://github.com/iobee-org/beelogger-web.git",
    "https://github.com/4w4k3/BeeLogger.git",
    "https://github.com/sdrausty/evil-ssdp.git",
    "https://github.com/Optane002/ZPhisher.git",
    "https://github.com/wpscanteam/wpscan.git",
    "https://github.com/swisskyrepo/Wordpresscan.git",
    "https://github.com/hashcat/ophcrack.git",
    "https://github.com/foreni-packages/ophcrack.git",
    "https://github.com/CrypToolProject/CrypTool-2.git",
    "https://github.com/panther-labs/panther-analysis.git",
    "https://github.com/buildbot/botherders.git",
    "https://github.com/SpiderLabs/Responder.git",
    "https://github.com/EmpireProject/Empire.git",
    "https://github.com/nomikugg/CrackMapExec.git",
    "https://github.com/byt3bl33d3r/CrackMapExec.git",
    "https://github.com/BloodHoundAD/BloodHound.git",
    "https://github.com/dirkjanm/BloodHound.py.git",
    "https://github.com/S1lkys/shellphishSS.git",
    "https://github.com/GiacomoLaw/Keylogger.git",
    "https://github.com/aydinnyunus/Keylogger.git",
    "https://github.com/ajayrandhawa/Keylogger.git",
    "https://github.com/TermuxHackz/wifi-cracker.git",
    "https://github.com/adelashraf/cenarius.git",
    "https://github.com/openwall/johnny.git",
    "https://github.com/lakiw/pcfg_cracker.git",
    "https://github.com/NorthernSec/VeraCracker.git",
    "https://github.com/MatrixTM/MHDDoS.git",
    "https://github.com/cyweb/hammer.git",
    "https://github.com/byt3bl33d3r/MITMf.git",
    "https://github.com/LionSec/xerosploit.git",
    "https://github.com/Ha3MrX/DDos-Attack.git",
    "https://github.com/securestate/king-phisher.git",  # King Phisher from Kali
    "https://github.com/lanjelot/patator.git",  # Patator from Kali
    "https://github.com/Dionach/CMSmap.git",  # CMSmap from Kali
    "https://github.com/commixproject/commix.git",  # Commix from Kali
    "https://github.com/vanhauser-thc/thc-hydra.git",  # THC-Hydra (included again for completeness)
    "https://github.com/EgeBalci/The-Eye.git",  # The Eye from Parrot OS
    # Add any other GitHub repositories here
    ]

    
    apt_packages = [
    "metasploit-framework",
    "nmap",
    "wireshark",
    "john",
    "hydra",
    "aircrack-ng",
    "king-phisher",
    "patator",
    "cmsmap",
    "commix",
    # Add other apt packages...
    ]
    create_tools_directory()
    install_git()
    clone_repositories(github_repos)
    
    if platform.system() == "Linux":
        install_apt_packages(apt_packages)
    
    install_tools(github_repos)

if __name__ == "__main__":
    main()