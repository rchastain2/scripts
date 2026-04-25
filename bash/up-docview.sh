
printf "This is $BASH_SOURCE\n"

## My desktop file for DocView
SHORTCUT=~/Desktop/docview.desktop

## DocView help file
INF=docview.inf

if [ ! -v FPGUI ]; then
printf "[ERROR] Variable not defined: FPGUI\n"
exit 0
elif [ ! -d $FPGUI ]; then
printf "[ERROR] Directory not found: %s\n" $FPGUI
exit 0
elif [ ! -f $SHORTCUT ]; then
printf "[ERROR] File not found: %s\n" $SHORTCUT
exit 0
elif [ ! -f $INF ]; then
printf "[ERROR] File not found: %s\n" $INF
exit 0
fi

printf "[INFO] fpGUI directory: %s\n" $FPGUI

pushd $FPGUI
printf "[INFO] Pull\n"
git pull
printf "[INFO] Build\n"
pasbuild clean
pasbuild compile -p unix
popd

DATE=$(date +"%y%m%d")
DIR="docview-$DATE"

printf "[INFO] Copy %s/docview to %s\n" $FPGUI $DIR
cp -rf $FPGUI/docview $DIR

printf "[INFO] Update %s\n" $SHORTCUT
sed -i -E "s/apps\/docview-[0-9]+/apps\/$DIR/g" $SHORTCUT

printf "[INFO] Copy %s\n" $INF
cp $INF $DIR/target

printf "[INFO] Done\n"
