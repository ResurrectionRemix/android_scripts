#    Resurrection Remix Compilation Script
#
#    Copyright (C) 2014 Shubhang Rathore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


# No scrollback buffer
echo -e '\0033\0143'



# Get intial time of script startup
res1=$(date +%s.%N)



# Specify colors for shell
red='tput setaf 1'              # red
green='tput setaf 2'            # green
yellow='tput setaf 3'           # yellow
blue='tput setaf 4'             # blue
violet='tput setaf 5'           # violet
cyan='tput setaf 6'             # cyan
white='tput setaf 7'            # white
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold red
bldgrn=${txtbld}$(tput setaf 2) # Bold green
bldblu=${txtbld}$(tput setaf 4) # Bold blue
bldcya=${txtbld}$(tput setaf 6) # Bold cyan
normal='tput sgr0'


tput bold
tput setaf 1
clear
echo -e ""
echo -e ""
echo -e "      (         (           (    (                       (        )      )  "
echo -e "      )\ )      )\ )        )\ ) )\ )        (     *   ) )\ )  ( /(   ( /(  "
echo -e "     (()/( (   (()/(    (  (()/((()/( (      )\    )  /((()/(  )\())  )\()) "
echo -e "      /(_)))\   /(_))   )\  /(_))/(_)))\   (((_)  ( )(_))/(_))((_)\  ((_)\  "
echo -e "     (_)) ((_) (_))  _ ((_)(_)) (_)) ((_)  )\___ (_(_())(_))    ((_)  _((_) "
echo -e "     | _ \| __|/ __|| | | || _ \| _ \| __|((/ __||_   _||_ _|  / _ \ | \| | "
echo -e "     |   /| _| \__ \| |_| ||   /|   /| _|  | (__   | |   | |  | (_) || .  | "
echo -e "     |_|_\|___||___/ \___/ |_|_\|_|_\|___|  \___|  |_|  |___|  \___/ |_|\_| "
echo -e ""
echo -e ""
echo -e "                         (           *     (        )                       "
echo -e "                         )\ )      (       )\ )  ( /(                       "
echo -e "                        (()/( (    )\))(  (()/(  )\())                      "
echo -e "                         /(_)))\  ((_)()\  /(_))((_)\                       "
echo -e "                        (_)) ((_) (_()((_)(_))  __((_)                      "
echo -e "                        | _ \| __||  \/  ||_ _| \ \/ /                      "
echo -e "                        |   /| _| | |\/| | | |   >  <                       "
echo -e "                        |_|_\|___||_|  |_||___| /_/\_\                      "
echo -e ""
echo -e ""
echo -e ""
echo -e ""

sleep 3s

# Clear terminal
clear

# Confirm 'make clean'
echo -e "\n\n${bldgrn}  Do you want to make clean?\n"
echo ""
echo -e "${bldblu}  1. Yes"
echo -e "${bldblu}  2. No"
echo ""
echo ""
$normal
read askClean

echo ""
echo ""
if [ "$askClean" == "1" ]
then
    echo -e "${bldred}  Compilation will continue after cleaning previous build files... "
else
    echo -e "${bldred}  ROM will be compiled without cleaning previous build files... "
fi
echo ""
echo ""


# Confirm fetching prebuilts
echo -e "\n\n${bldgrn}  Do you want to fetch prebuilts?\n  (You don't need to fetch them frequently)"
echo ""
echo -e "${bldblu}  1. Yes"
echo -e "${bldblu}  2. No"
echo ""
echo ""
$normal
read askPrebuilts



echo ""
echo ""
if [ "$askPrebuilts" == "1" ]
then
    echo -e "${bldred}  Prebuilts will be fetched... "
else
    echo -e "${bldred}  Prebuilts won't be fetched... "
fi
echo ""
echo ""


# Confirm toolchain to be used for compilation
# Linaro or default GCC

echo ""
echo -e "\n\n${bldgrn}  Toolchain selection\n"
echo ""
echo -e "${bldgrn}  If you are getting errors in your kernel source,"
echo -e "  while using the Linaro Toolchain, you need to patch your kernel,"
echo -e "  or else use GCC toolchain for your builds.\n"
echo ""
echo -e "${bldblu}  1. GCC"
echo -e "${bldblu}  2. Linaro"
echo ""
echo ""
echo -e "${bldblu}  Which toolchain do you want to use? \n\n"
$normal
read askToolchain

echo ""
echo ""
if [ "$askToolchain" == "2" ]
then
    echo -e "${bldred}  Resurrection Remix ROM will be compiled using Linaro Toolchain... "
else
    echo -e "${bldred}  Resurrection Remix ROM will be compiled using the default GCC Toolchain..."
fi
echo ""
echo ""


sleep 2s

# Clear terminal
clear


# Apply patch to enable compilation with Linaro Toolchain
if [ "$askToolchain" == "2" ]
then
	echo ""
	echo ""
	echo -e "${bldgrn}  Patching build environment to use Linaro Toolchain... "
	echo ""
	echo ""
	$normal
	cd build
    	patch -p1 < ../patches/.linaro/build.patch
    	cd ..
fi



sleep 2s

# Clear terminal
clear


if [ "$askClean" == "1" ]
then
	echo ""
	echo ""
	echo -e "${bldgrn}  Removing files from previous compilations - Cleaning... "
	echo ""
	echo ""
	$normal
	make clobber
fi



# Get prebuilts
if [ "$askPrebuilts" == "1" ]
then
	echo -e ""
	echo -e ""
	echo -e "${bldgrn}  Fetching prebuilts..."
	echo -e ""
	echo -e ""
	$normal
	cd vendor/cm
	./get-prebuilts
	cd ../../
fi


# Clear terminal
clear


# Setup environment
echo -e ""
echo -e ""
echo -e "${bldgrn}  Setting up build environment..."
echo -e ""
echo -e ""
$normal
. build/envsetup.sh



# Clear terminal
clear



# Lunch device
echo -e ""
echo -e ""
echo -e "${bldcya}  Choose your device from the lunch menu..."
echo -e ""
echo -e ""
$normal
$green
lunch


# Clear terminal
clear


# Start compilation
echo -e ""
echo -e ""
echo -e "${bldcya}  Starting compilation of Resurrection Remix ROM..."
echo -e ""
echo -e ""
$normal
mka bacon
echo -e ""



# Get elapsed time
$blue
res2=$(date +%s.%N)
echo -e ""
echo -e ""
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
echo -e ""
echo -e ""

# Reverting toolchain to default GCC from linaro
cd build
git checkout .
cd ..


# Compilation complete
tput bold
tput setaf 1
clear
echo -e ""
echo -e ""
echo -e "      (         (           (    (                       (        )      )  "
echo -e "      )\ )      )\ )        )\ ) )\ )        (     *   ) )\ )  ( /(   ( /(  "
echo -e "     (()/( (   (()/(    (  (()/((()/( (      )\    )  /((()/(  )\())  )\()) "
echo -e "      /(_)))\   /(_))   )\  /(_))/(_)))\   (((_)  ( )(_))/(_))((_)\  ((_)\  "
echo -e "     (_)) ((_) (_))  _ ((_)(_)) (_)) ((_)  )\___ (_(_())(_))    ((_)  _((_) "
echo -e "     | _ \| __|/ __|| | | || _ \| _ \| __|((/ __||_   _||_ _|  / _ \ | \| | "
echo -e "     |   /| _| \__ \| |_| ||   /|   /| _|  | (__   | |   | |  | (_) || .  | "
echo -e "     |_|_\|___||___/ \___/ |_|_\|_|_\|___|  \___|  |_|  |___|  \___/ |_|\_| "
echo -e ""
echo -e ""
echo -e "                         (           *     (        )                       "
echo -e "                         )\ )      (       )\ )  ( /(                       "
echo -e "                        (()/( (    )\))(  (()/(  )\())                      "
echo -e "                         /(_)))\  ((_)()\  /(_))((_)\                       "
echo -e "                        (_)) ((_) (_()((_)(_))  __((_)                      "
echo -e "                        | _ \| __||  \/  ||_ _| \ \/ /                      "
echo -e "                        |   /| _| | |\/| | | |   >  <                       "
echo -e "                        |_|_\|___||_|  |_||___| /_/\_\                      "
echo -e ""
echo -e ""


# Switch terminal back to normal
$normal

