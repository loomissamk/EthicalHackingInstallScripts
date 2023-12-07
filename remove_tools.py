import subprocess
import shutil
import os
import platform

def uninstall_apt_packages(packages):
    if platform.system() == "Linux":
        for package in packages:
            subprocess.run(["sudo", "apt-get", "remove", "-y", package])
            subprocess.run(["sudo", "apt-get", "autoremove", "-y"])  # Remove dependencies

def delete_git_repos():
    if platform.system() == "Windows":
        git_dir = os.path.join(os.environ["USERPROFILE"], "tools")
    else:
        git_dir = os.path.join(os.environ["HOME"], "tools")

    if os.path.exists(git_dir):
        shutil.rmtree(git_dir)
    else:
        print("Git directory not found. No cleanup needed.")

def main():
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

    uninstall_apt_packages(apt_packages)
    delete_git_repos()

if __name__ == "__main__":
    main()
