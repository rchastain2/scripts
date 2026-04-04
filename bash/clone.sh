
## clone.sh
##
## Clone un dépôt Git,
## supprime le dossier .git,
## sauvegarde l'URL dans un fichier nommé url.txt.
##
## Usage :
##   sh clone.sh URL [DIRNAME]

printf "[INFO] BASH_SOURCE $BASH_SOURCE\n"

if [ ! -z "$1" ]
then
  URL="$1"
  printf "[DEBUG] URL \"%s\"\n" "$URL"
  
  git clone --single-branch --depth 1 $URL $2
  
  BASENAME=$(basename $URL)
  printf "[DEBUG] BASENAME \"%s\"\n" "$BASENAME"
  
  if [ ! -z "$2" ]
  then
    FILENAME="$2"
  else
    FILENAME=${BASENAME%.*}
  fi
  printf "[DEBUG] FILENAME \"%s\"\n" "$FILENAME"
  
  if [ ! -z "$FILENAME" ]
  then
    sed -n 's/^	url = //p' $FILENAME/.git/config > $FILENAME/url.txt
    rm -rf $FILENAME/.git
    rm -rf $FILENAME/.github
  fi
fi
