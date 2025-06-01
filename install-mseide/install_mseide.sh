
## install_mseide.sh
## Télécharge, compile et installe (1) MSEide sous Linux.

## (1) L'installation consiste dans la création de deux raccourcis : l'un sur le
## bureau, l'autre dans le menu des applications.

## Exemple d'utilisation :
## sh install_mseide.sh -d ~/Applications -b maint &> install_mseide.log

## Au premier lancement de MSEide, vous devez aller dans Settings/Configure MSEide
## et renseigner la variable MSEDIR.

check_available()
{
  COMMAND="$1"
  if ! command -v $COMMAND 2>&1 >/dev/null; then
    echo "[ERROR] Command not available: $COMMAND"
    exit 0
  fi
}

configure()
{
  INSTALL_DIR="$1"
  BRANCH="$2"
  
  case $BRANCH in
    main)
      URL="https://codeberg.org/fredvs/mseide-msegui.git"
      ;;
    maint)
      URL="https://codeberg.org/rchastain/mseide-msegui.git"
      ;;
    *)
      echo "[ERROR] Unknown branch"
      exit 0
      ;;
  esac
  
  DESKTOP=~/Desktop
  if [ ! -d "$DESKTOP" ]; then
    if command -v xdg-user-dir 2>&1 >/dev/null; then
      DESKTOP=$(xdg-user-dir DESKTOP)
    else
      echo "[ERROR] Cannot find desktop"
      exit 0
    fi
  fi
  
  TIMESTAMP=$(date +"%y%m%d%H%M")
  INSTALL_NAME="mseide-$TIMESTAMP"
  MSEDIR="$INSTALL_DIR/$INSTALL_NAME"
  
  APPMENU_DIR="$HOME/.local/share/applications"
  
  echo "[DEBUG] INSTALL_DIR=$INSTALL_DIR"
  echo "[DEBUG] BRANCH=$BRANCH"
  echo "[DEBUG] URL=$URL"
  echo "[DEBUG] DESKTOP=$DESKTOP"
  echo "[DEBUG] TIMESTAMP=$TIMESTAMP"
  echo "[DEBUG] INSTALL_NAME=$INSTALL_NAME"
  echo "[DEBUG] MSEDIR=$MSEDIR"
  echo "[DEBUG] APPMENU_DIR=$APPMENU_DIR"
}

download()
{
  echo "[INFO] Clone MSEide-MSEgui repository"
 
  if [ -d "$MSEDIR" ]; then
    echo "[INFO] Directory already exists: $MSEDIR"
  else
    git clone --single-branch --branch $BRANCH $URL $MSEDIR 
  fi
}

build()
{
  echo "[INFO] Build MSEide"
  
  pushd $MSEDIR/apps/ide/

  fpc \
  -Fu../../lib/common/* \
  -Fu../../lib/common/kernel \
  -Fi../../lib/common/kernel \
  -Fu../../lib/common/kernel/linux \
  -Mobjfpc -Sh mseide.pas

  popd
}

install()
{
  echo "[INFO] Create shortcuts"
  
  FILE=$INSTALL_NAME.desktop
  
  cat > $FILE << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=MSEide ($BRANCH, $TIMESTAMP) 
Comment=Pascal IDE
Exec=$MSEDIR/apps/ide/mseide --globstatfile=$MSEDIR/apps/ide/mseide.sta %F
Icon=$MSEDIR/msegui_64.png
Path=$MSEDIR/apps/ide
Terminal=false
StartupNotify=true
Categories=Application;IDE;Development;GUIDesigner;Programming;
Keywords=editor;Pascal;IDE;FreePascal;fpc;Design;Designer;
EOF
  
  #sudo chmod -R 777 $FILE
  chmod -R 777 $FILE
  cp -f $FILE $DESKTOP
  
  # https://forum.xfce.org/viewtopic.php?id=16357
  f=$DESKTOP/$FILE; gio set -t string $f metadata::xfce-exe-checksum "$(sha256sum $f | awk '{print $1}')"
  
  if [ ! -d $APPMENU_DIR ]; then
    echo "[INFO] Create directory: $APPMENU_DIR"
    mkdir -p $APPMENU_DIR
  fi
  mv -f $FILE $APPMENU_DIR
}

# ==============================================================================

echo "MSEide Installer"

# Checks commands availability
check_available git
check_available fpc
#check_available sudo

# Default installation directory (current directory)
INSTALL_DIR="$PWD"
# Default branch
BRANCH=main

# Read command-line options
while getopts d:b: flag
do
  case "${flag}" in
    d) INSTALL_DIR=${OPTARG};;
    b) BRANCH=${OPTARG};;
  esac
done

# Start installation
configure $INSTALL_DIR $BRANCH
download
build
install
