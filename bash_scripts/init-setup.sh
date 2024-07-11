#
#! /bin/bash
#
# Developer: Jacob Pfeiff
# Dec-19-2018
#
# The purpose of this script is for installing initial progarms for a clean OS.
#
#

# list of things to add
#
# gnome_disks
# Steam
# Python3.7
# Weechat
# iftop 
# sysstat
# r-base
# nvtop
#

echo "Init-Install CLI"
echo -n "Salect 1 for Desktop; and 2 for Server: "
read str
# Logic for Desktop salection.
if [ "$str" = "1" ] ; then
    echo "Starting Desktop Init-Install"
    mkdir ~/Documents/Logs      # Creating a diractory for user created log files.
    sleep 2
    # Selecting style of Desktop to setup.
    echo "Please select one of the fallowing"
    echo "A - Basic"
    echo "B - Gaming"
    echo "C - Progarming"
    echo -n "Enter Selection: "
    read str
    # Logic for adding any addisnal software not inclueded in selected setup.
    if [ "$str" = "A" ] ; then
        installArray=("htop" "nvtop" "iftop" "yakuake" "git" "steam")
        for i in ${installArray[@]}; do
            echo $i         # Listing inclueded software in selected setup.
            sleep 2
            echo -n "Would you like to add any software? (Y/n): "
            read str
            if [ "$str" = "Y" ] ; then
                rc=0
                while [ $rc -le 0 ] ; do
                    echo -n "Please enter one at a time, and enter 'exit' when done.: "
                    read str
                    if [ "$str" = "exit" ] ; then
                        rc=1
                    else
                        installArray=[${installArray[@]}]="'$str'"
                    fi
                done
                
                for i in ${installArray[@]}; do
                    echo $i         # Listing software after adding addisnal.
                done
            elif [ "$str" = "n" ] ; then
                exit 1
            fi
        done
        # Updating with logs and Creating logs for installed software for comparing.
        echo "The system will now be updated...."
        sudo apt-get update > "$(date)_Init-Update.log" && sudo apt-get upgrade -y >> "$(date)_Init-Update.log" | mv "$(date)_Init-Update.log" -t ~/Documents/Logs
        apt list --installed > ~/Documents/Clean_Installed.txt
        sudo apt-get install -y ${installArray[@]} > "$(date)_Init-Install.log" | mv "$(date)_Intit-Install.log" -t ~/Documents/Logs
        apt list --installed > ~/Documents/Mod_Installed.txt
        diff -u <(sort Clean_Installed.txt) <(sort Mod_Installed.txt) | less > "User-Installed.txt" | mv "User-Installed" -t ~/Documents/Logs
        echo -n "Would you like to RICE your config's (Y/n): "
        read str
        # Setup for Ricing config files.
        if [ $str = "Y" ] ; then
            installedArray=()
            mkdir ~/bin
            sleep 1
            mkdir ~/Documents/Rice-Setup
            sleep 1
            mkdir ~/Documents/Rice-Setup/Backup-configs
            sleep 1
            cd ~/Documents/Rice-Setup
            git clone
            cd
            for f in ~/Documents/Rice-Setup/* ; do
                echo "The following config files will be wirten to the syetem."
                echo "$f"
                echo -n "Would you like to contune? (Y/n): "
                read str
                if [ $str = "Y" ] ; then
                    installedArray="$f"
                else
                    echo "Init-Install Complate"
                    exit 0
                fi
            done
            # installedArray=(".bashrc" "htop" "nvtop" "iftop" "yakuake" "git" "steam") # For testing.
            # Logic for replacing config files with riced configs.
            for i in ${!installedArray[@]}; do
                backup=~/Documents/Rice-Setup/Backup-configs
                riceConfigs=~/Documents/Riced-configs
                workingDir=~/
                configReplace() {
                    if test -f "$workingDir"/"${installedArray[$i]}"; then
                        echo "File '${installedArray[$i]}' found moving to '$backup'...."
                        mv "${installedArray[$i]}" -t "$backup"
                        echo "Moveing file complate...."
                        echo "Copying riced '${installedArray[$i]}' config to dir...."
                        cp "$riceConfigs"/"${installedArray[$i]}" "$workingDir"/"${installedArray[$i]}"
                        echo "'${installedArray[$i]}' config complate...."
                    else
                        echo "File '${installedArray[$i]}' not found in HOME dir...."
                        echo "Checking dir ~/.config...."
                        workingDir=~/.config
                        if test -f "$workingDir"/"${installedArray[$i]}"; then
                            echo "File '${installedArray[$i]}' found moving to '$backup'...."
                            mv "${installedArray[$i]}" -t "$backup"
                            echo "Moveing file complate...."
                            echo "Copying riced '${installedArray[$i]}' config to dir...."
                            cp "$riceConfigs"/"${installedArray[$i]}" "$workingDir"/"${installedArray[$i]}"
                            echo "'${installedArray[$i]}' config complate...."
                        elif echo "File '${installedArray[$i]}' not found in ~/.config dir...."; then
                            echo "Please chack '${installedArray[$i]}''s documention to locate it's config file location."
                            echo -n "Enter configs dir (exp. /etc/resolv.conf): "
                            read $str
                            workingDir=$str
                            if test -f "$workingDir"/"${installedArray[$i]}"; then
                                echo "File '${installedArray[$i]}' found moving to '$backup'...."
                                mv "${installedArray[$i]}" -t "$backup"
                                echo "Moveing file complate...."
                                echo "Copying riced '${installedArray[$i]}' config to dir...."
                                cp "$riceConfigs"/"${installedArray[$i]}" "$workingDir"/"${installedArray[$i]}"
                                echo "'${installedArray[$i]}' config complate...."
                            fi
                        fi
                    fi
                }
            done
        else
            echo "Init-Install Complate"
            exit 0
        fi
	fi
elif [ "$str" = "2" ] ; then
    echo "Starting Desktop Init-Install"
    mkdir ~/Documents/Logs      # Creating a diractory for user created log files.
    sleep 2
    # Selecting style of Desktop to setup.
    echo "Please select one of the fallowing"
    echo "A - Basic"
    echo "B - Gaming"
    echo "C - Progarming"
    echo -n "Enter Selection: "
    read str
    # Logic for adding any addisnal software not inclueded in selected setup.
    if [ "$str" = "A" ] ; then
        installArray=("htop" "nvtop" "iftop" "yakuake" "git" "steam")
        for i in ${installArray[@]}; do
            echo $i         # Listing inclueded software in selected setup.
            sleep 2
            echo -n "Would you like to add any software? (Y/n): "
            read str
            if [ "$str" = "Y" ] ; then
                rc=0
                while [ $rc -le 0 ] ; do
                    echo -n "Please enter one at a time, and enter 'exit' when done.: "
                    read str
                    if [ "$str" = "exit" ] ; then
                        rc=1
                    else
                        installArray=[${installArray[@]}]="'$str'"
                    fi
                done
                
                for i in ${installArray[@]}; do
                    echo $i         # Listing software after adding addisnal.
                done
            elif [ "$str" = "n" ] ; then
                exit 1
            fi
        done
