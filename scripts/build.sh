#!/bin/bash

printf "================================= LeoPays.CDT ==================================\n\n"

VERSION=2.1 # Build script version
CMAKE_BUILD_TYPE=Release
export DISK_MIN=20
DOXYGEN=false
ENABLE_COVERAGE_TESTING=false
CORE_SYMBOL_NAME="LPC"
START_MAKE=true

TIME_BEGIN=$( date -u +%s )
txtbld=$(tput bold)
bldred=${txtbld}$(tput setaf 1)
txtrst=$(tput sgr0)

export SRC_LOCATION=${HOME}/leopays.cdt/src
export OPT_LOCATION=${HOME}/leopays.cdt/opt
export VAR_LOCATION=${HOME}/leopays.cdt/var
export ETC_LOCATION=${HOME}/leopays.cdt/etc
export BIN_LOCATION=${HOME}/leopays.cdt/bin
export DATA_LOCATION=${HOME}/leopays.cdt/data
export CMAKE_VERSION_MAJOR=3
export CMAKE_VERSION_MINOR=13
export CMAKE_VERSION_PATCH=2
export CMAKE_VERSION=${CMAKE_VERSION_MAJOR}.${CMAKE_VERSION_MINOR}.${CMAKE_VERSION_PATCH}
export BOOST_VERSION_MAJOR=1
export BOOST_VERSION_MINOR=67
export BOOST_VERSION_PATCH=0
export BOOST_VERSION=${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}_${BOOST_VERSION_PATCH}
export BOOST_ROOT=${SRC_LOCATION}/boost_${BOOST_VERSION}
export BOOST_LINK_LOCATION=${OPT_LOCATION}/boost
export TINI_VERSION=0.18.0

export PATH=$HOME/bin:$PATH:$HOME/opt/llvm/bin

# Setup directories
mkdir -p $SRC_LOCATION
mkdir -p $OPT_LOCATION
mkdir -p $VAR_LOCATION
mkdir -p $BIN_LOCATION
mkdir -p $VAR_LOCATION/log
mkdir -p $ETC_LOCATION

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="${SCRIPT_DIR}/.."
BUILD_DIR="${REPO_ROOT}/build"

# Use current directory's tmp directory if noexec is enabled for /tmp
if (mount | grep "/tmp " | grep --quiet noexec); then
      mkdir -p $REPO_ROOT/tmp
      TEMP_DIR="${REPO_ROOT}/tmp"
      rm -rf $REPO_ROOT/tmp/*
else # noexec wasn't found
      TEMP_DIR="/tmp"
fi

if [ ! -d "${REPO_ROOT}/.git" ]; then
   printf "\\nThis build script only works with sources cloned from git\\n"
   printf "Please clone a new LeoPays directory with 'git clone https://github.com/leopays-core/leopays --recursive'\\n"
   exit 1
fi

cd $REPO_ROOT

STALE_SUBMODS=$(( $(git submodule status --recursive | grep -c "^[+\-]") ))
if [ $STALE_SUBMODS -gt 0 ]; then
   printf "\\ngit submodules are not up to date.\\n"
   printf "Please run the command 'git submodule update --init --recursive'.\\n"
   exit 1
fi

printf "Beginning build version: %s\\n" "${VERSION}"
printf "%s\\n" "$( date -u )"
printf "User: %s\\n" "$( whoami )"
# printf "git head id: %s\\n" "$( cat .git/refs/heads/master )"
printf "Current branch: %s\\n" "$( git rev-parse --abbrev-ref HEAD )"

ARCH=$( uname )
printf "\\nARCHITECTURE: %s\\n" "${ARCH}"

# Find and use existing CMAKE
export CMAKE=$(command -v cmake 2>/dev/null)

if [ "$ARCH" == "Linux" ]; then
   # Check if cmake is already installed or not and use source install location
   if [ -z $CMAKE ]; then export CMAKE=$HOME/bin/cmake; fi
   export OS_NAME=$( cat /etc/os-release | grep ^NAME | cut -d'=' -f2 | sed 's/\"//gI' )
   case "$OS_NAME" in
      "Amazon Linux AMI"|"Amazon Linux")
         FILE="./scripts/build_amazon.sh"
         CXX_COMPILER=g++
         C_COMPILER=gcc
      ;;
      "CentOS Linux")
         FILE="${REPO_ROOT}/scripts/build_centos.sh"
         CXX_COMPILER=g++
         C_COMPILER=gcc
      ;;
      "elementary OS")
         FILE="${REPO_ROOT}/scripts/build_ubuntu.sh"
         CXX_COMPILER=clang++-4.0
         C_COMPILER=clang-4.0
      ;;
      "Fedora")
         FILE="${REPO_ROOT}/scripts/build_fedora.sh"
         CXX_COMPILER=g++
         C_COMPILER=gcc
      ;;
      "Linux Mint")
         FILE="${REPO_ROOT}/scripts/build_ubuntu.sh"
         CXX_COMPILER=clang++-4.0
         C_COMPILER=clang-4.0
      ;;
      "Ubuntu")
         FILE="${REPO_ROOT}/scripts/build_ubuntu.sh"
         CXX_COMPILER=clang++-4.0
         C_COMPILER=clang-4.0
      ;;
      "Debian GNU/Linux")
         FILE="${REPO_ROOT}/scripts/build_ubuntu.sh"
         CXX_COMPILER=clang++-4.0
         C_COMPILER=clang-4.0
      ;;
      *)
         printf "\\nUnsupported Linux Distribution. Exiting now.\\n\\n"
         exit 1
   esac
fi

if [ "$ARCH" == "Darwin" ]; then
   # Check if cmake is already installed or not and use source install location
   if [ -z $CMAKE ]; then export CMAKE=/usr/local/bin/cmake; fi
   FILE="${REPO_ROOT}/scripts/build_darwin.sh"
   FREE_MEM=`vm_stat | grep "Pages free:"`
   read -ra FREE_MEM <<< "$FREE_MEM"
   FREE_MEM=$((${FREE_MEM[2]%?}*(4096))) # free pages * page size
else
   FREE_MEM=`LC_ALL=C free | grep "Mem:" | awk '{print $7}'`
fi

cd $SRC_LOCATION
. "$FILE" # Execute OS specific build file

CORES_AVAIL=`getconf _NPROCESSORS_ONLN`
MEM_CORES=$(( ${FREE_MEM}/4000000 )) # 4 gigabytes per core
MEM_CORES=$(( $MEM_CORES > 0 ? $MEM_CORES : 1 ))
CORES=$(( $CORES_AVAIL < $MEM_CORES ? $CORES_AVAIL : $MEM_CORES ))

mkdir -p $BUILD_DIR
cd $BUILD_DIR

printf "\\n================================================================================\\n"
printf "========================== Starting LeoPays.CDT Build ==========================\\n"

$CMAKE -DCMAKE_INSTALL_PREFIX=${HOME}/leopays.cdt "${REPO_ROOT}"
if [ $? -ne 0 ]; then exit -1; fi
make -j$CORES
if [ $? -ne 0 ]; then exit -1; fi

TIME_END=$(( $(date -u +%s) - $TIME_BEGIN ))
printf "\n${bldred}    __          _______      _____      ______            __     __   ______    \n"
printf "   |  |        |   ____|    / ___ \    |  ___ \     /\    \ \   / /  / _____|   \n"
printf "   |  |        |  |__      | |   | |   | |___) |   /  \    \ \_/ /  | (____     \n"
printf "   |  |        |   __|     | |   | |   |  ____/   / /\ \    \   /    \____ \    \n"
printf "   |  |____    |  |____    | |___| |   | |       / ____ \    | |     _____) |   \n"
printf "   |_______|   |_______|    \_____/    |_|      /_/    \_\   |_|    |______/    \n\n${txtrst}"
printf "                                                                                \n"
printf "================================================================================\n"
printf "\\nLeoPays.CDT has been successfully built. %02d:%02d:%02d\\n\\n" $(($TIME_END/3600)) $(($TIME_END%3600/60)) $(($TIME_END%60))
printf "${txtrst}================================================================================\\n"
printf "For more information:\\n"
printf "LeoPays website: https://leopays.com\\n"
