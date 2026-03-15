
DATETIMESTAMP=$(date +"%y%m%d%H%M")

echo $DATETIMESTAMP

FOLDER=image
PREFIX=pascal

pushd ..
zip -r $FOLDER-$DATETIMESTAMP.zip $FOLDER \
-x $FOLDER/archives/\* \
-x $FOLDER/raster-master/\*

mv -fv $FOLDER-$DATETIMESTAMP.zip /run/media/roland/xxx/sauvegardes/$PREFIX-$FOLDER-$DATETIMESTAMP.zip
popd
