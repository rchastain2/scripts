
DEST=git

if [ ! -d $DEST ]; then
  mkdir -p $DEST
fi

cp -uv README.md $DEST
cp -uv .gitignore $DEST

#mkdir -p $DEST/example1 && cp -ruv example1/* $DEST/example1
mkdir -p $DEST/example1 && cp -ruv example1/* $_
CP() {
    mkdir -p $(dirname "$2") && cp "$1" "$2"
}
#install -D -m 644 $HOME/.vimrc /tmp/test/one/non-exist/backup/dir/myVimrc
## https://www.baeldung.com/linux/create-destination-directory

if [ ! -z "$1" ]; then
  pushd $DEST
  git add .
  git commit -m "$1"
  git push
  popd
fi
