
check_command_availability()
{
  COMMAND="$1"
  if command -v $COMMAND 2>&1 >/dev/null; then
    echo "[INFO] Command available: $COMMAND"
  else
    echo "[ERROR] Command not available: $COMMAND"
    exit 0
  fi
}

configure()
{
  INSTALL_DIR="$1"
  
  URL="https://codeberg.org/rchastain/eschecs.git"
  
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
  INSTALL_NAME="eschecs-$TIMESTAMP"
  ESCHECS_DIR="$INSTALL_DIR/$INSTALL_NAME"
  
  APPMENU_DIR="$HOME/.local/share/applications"
  
  echo "[DEBUG] INSTALL_DIR=$INSTALL_DIR"
  echo "[DEBUG] URL=$URL"
  echo "[DEBUG] DESKTOP=$DESKTOP"
  echo "[DEBUG] TIMESTAMP=$TIMESTAMP"
  echo "[DEBUG] INSTALL_NAME=$INSTALL_NAME"
  echo "[DEBUG] ESCHECS_DIR=$ESCHECS_DIR"
  echo "[DEBUG] APPMENU_DIR=$APPMENU_DIR"
}

download()
{
  echo "[INFO] Clone Eschecs repository"
 
  if [ -d "$ESCHECS_DIR" ]; then
    echo "[INFO] Directory already exists: $ESCHECS_DIR"
  else
    #git clone --recurse-submodules $URL $ESCHECS_DIR
    git clone $URL $ESCHECS_DIR
    pushd $ESCHECS_DIR
    git submodule update --init
    popd
  fi
}

build()
{
  echo "[INFO] Build Eschecs"
  
  pushd $ESCHECS_DIR
  make
  popd
}

install()
{
  echo "[INFO] Create shortcuts"
  
  DESKTOPFILE=$INSTALL_NAME.desktop
  
  cat > $DESKTOPFILE << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Eschecs $TIMESTAMP
Comment=Chess Game
Comment[fr]=Jeu d'échecs
Exec=$ESCHECS_DIR/eschecs %f
Icon=$ESCHECS_DIR/source/eschecs.ico
Path=$ESCHECS_DIR
Terminal=false
StartupNotify=true
Categories=Game;BoardGame;
EOF
  
  chmod -R 777 $DESKTOPFILE
  cp -f $DESKTOPFILE $DESKTOP
  
  if [ ! -d $APPMENU_DIR ]; then
    echo "[INFO] Create directory: $APPMENU_DIR"
    mkdir -p $APPMENU_DIR
  fi
  mv -f $DESKTOPFILE $APPMENU_DIR
}

# ==============================================================================

echo "Eschecs Bash Installer"

# Checks commands availability
check_command_availability git
check_command_availability fpc
check_command_availability make

# Default installation directory (current directory)
INSTALL_DIR="$PWD"

# Read command-line options
while getopts d: flag
do
  case "${flag}" in
    d) INSTALL_DIR=${OPTARG};;
  esac
done

# Start installation
configure $INSTALL_DIR
download
build
install

echo "[INFO] Installation successful"
