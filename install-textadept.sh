
# Script pour télécharger, compiler et installer l'éditeur de texte [Textadept](https://github.com/orbitalquark/textadept) sous Linux

check_command_availability()
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
  INSTALL_NAME="textadept-$TIMESTAMP"
  INSTALL_DIR2="$INSTALL_DIR/$INSTALL_NAME"
  
  REPOSITORY=https://github.com/orbitalquark/textadept.git
  
  SOURCE=$INSTALL_DIR2/source
  BUILD=$INSTALL_DIR2/build
  INSTALL=$INSTALL_DIR2/install
  SHARE=$INSTALL/share/textadept
  
  TARGET=$SHARE/textadept
  SYMLINK=~/.local/bin/textadept
  SVGDIR=~/.local/share/icons/Nordic-bluish/apps/scalable/
  PNGDIR=~/.local/share/icons/

  echo "[DEBUG] REPOSITORY=$REPOSITORY"
  echo "[DEBUG] SOURCE=$SOURCE"
  echo "[DEBUG] BUILD=$BUILD"
  echo "[DEBUG] INSTALL=$INSTALL"
  echo "[DEBUG] SHARE=$SHARE"
  echo "[DEBUG] TARGET=$TARGET"
  echo "[DEBUG] SYMLINK=$SYMLINK"
  echo "[DEBUG] SVGDIR=$SVGDIR"
  echo "[DEBUG] PNGDIR=$PNGDIR"
  
  mkdir -p $INSTALL_DIR2
}

download()
{
  echo "[INFO] Download Textadept source"

  if [ -d "$SOURCE" ]; then
    echo "[INFO] Directory already exists: $SOURCE"
  else
    git clone $REPOSITORY $SOURCE
  fi
}

build()
{
  echo "[INFO] Build Textadept"
  mkdir $BUILD
  cmake -S $SOURCE -B $BUILD -D CMAKE_INSTALL_PREFIX=$INSTALL
  cmake --build $BUILD -j
  cmake --install $BUILD
}

create_link()
{
  echo "[INFO] Create symbolic link"
  mkdir -p ~/.local/bin/
  ln -sf $TARGET $SYMLINK
}

copy_desktop_files()
{
  echo "[INFO] Copy .desktop files"
  mkdir -p ~/.local/share/applications/
  cp -f $SHARE/textadept.desktop ~/.local/share/applications/
  cp -f $SHARE/textadept.desktop ~/Desktop
  chmod -R 777 ~/Desktop/textadept.desktop
}

copy_svg_icon()
{
  echo "[INFO] Copy SVG icon"
  if [ -d "$SVGDIR" ]; then
    cp -f $SHARE/core/images/textadept.svg "$SVGDIR"
  else
    echo "[WARNING] $SVGDIR does not exist."
  fi
}

copy_png_icon()
{
  echo "[INFO] Copy PNG icon"
  mkdir -p $PNGDIR
  ##cp -f $SHARE/core/images/textadept.png $PNGDIR
  cp -f $SHARE/core/images/textadept.ico $PNGDIR
}

echo "Textadept Bash installer"

check_command_availability git
check_command_availability cmake

INSTALL_DIR="$PWD"

# Read command-line options
while getopts d: flag
do
  case "${flag}" in
    d) INSTALL_DIR=${OPTARG};;
  esac
done

configure $INSTALL_DIR
download
build
create_link
copy_desktop_files
copy_svg_icon
copy_png_icon
