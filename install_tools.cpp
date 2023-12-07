#include <iostream>
#include <cstdlib>
#include <filesystem>
#include <vector>

namespace fs = std::filesystem;

bool commandExists(const std::string &command) {
    const std::string cmd = "where " + command + " > nul 2>&1";
    return system(cmd.c_str()) == 0;
}

void createToolsDirectory() {
    const char *userProfile = std::getenv("USERPROFILE");
    fs::path toolsDir = fs::path(userProfile) / "tools";

    fs::create_directories(toolsDir);
    fs::current_path(toolsDir);
}

void installGit() {
    if (!commandExists("git")) {
        std::cout << "Git is not installed. Installing...\n";

        if (system("uname") == 0) { // Assumes Linux
            if (geteuid() != 0) {
                std::cout << "This operation requires superuser privileges to install Git.\n";
                exit(1);
            } else {
                system("sudo apt-get update");
                system("sudo apt-get install -y git");
            }
        } else if (system("brew help > /dev/null 2>&1") == 0) { // Assumes macOS with Homebrew
            system("brew install git");
        } else if (system("where powershell > nul 2>&1") == 0) { // Assumes Windows with PowerShell
            std::cout << "Please download Git for Windows from https://git-scm.com/download/win and install it.\n";
            std::cout << "After installation, make sure 'git' is added to the PATH.\n";
            system("pause"); // Pausing execution for user to install Git manually
        } else {
            std::cout << "Unsupported operating system\n";
            exit(1);
        }
    }
}

void cloneRepositories(const std::vector<std::string> &repos) {
    const char *userProfile = std::getenv("USERPROFILE");
    fs::path toolsDir = fs::path(userProfile) / "tools";

    fs::create_directories(toolsDir);
    fs::current_path(toolsDir);

    for (const auto &repo : repos) {
        system(("git clone " + repo).c_str());
    }
}

void installAptPackages(const std::vector<std::string> &packages) {
    if (system("uname") == 0) { // Assumes Linux
        system("sudo apt-get update");
        for (const auto &package : packages) {
            system(("sudo apt-get install -y " + package).c_str());
        }
    }
}

void installTools(const std::vector<std::string> &repos) {
    const char *userProfile = std::getenv("USERPROFILE");
    fs::path toolsDir = fs::path(userProfile) / "tools";

    for (const auto &repo : repos) {
        fs::path repoPath = toolsDir / fs::path(repo).filename().replace_extension("");
        fs::current_path(repoPath);

        if (fs::exists("install.sh")) {
            system("bash install.sh");
        } else if (fs::exists("setup.py")) {
            system("python setup.py install");
        } else if (fs::exists("requirements.txt")) {
            system("pip install -r requirements.txt");
        } else {
            std::cout << "No installation instructions found for " << repoPath << std::endl;
        }
    }
}

int main() {
    std::vector<std::string> githubRepos = {
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
        "https://github.com/securestate/king-phisher.git",  
        "https://github.com/lanjelot/patator.git",  
        "https://github.com/Dionach/CMSmap.git",  
        "https://github.com/commixproject/commix.git",  
        "https://github.com/vanhauser-thc/thc-hydra.git",  
        "https://github.com/EgeBalci/The-Eye.git", 
        };

    std::vector<std::string> aptPackages = {
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
        };

    createToolsDirectory();
    installGit();
    cloneRepositories(githubRepos);
    installAptPackages(aptPackages);
    installTools(githubRepos);

    return 0;
}
