
exit 0

cp -f br.bmp 1.bmp
magick 1.bmp -crop 47x48+0+0 -gravity east -background magenta -extent 48x48 br.bmp
cp -f wr.bmp 1.bmp
magick 1.bmp -crop 47x48+0+0 -gravity east -background magenta -extent 48x48 wr.bmp

cp -f bq.bmp 1.bmp
magick 1.bmp -crop 47x48+1+0 -gravity west -background magenta -extent 48x48 bq.bmp
cp -f wq.bmp 1.bmp
magick 1.bmp -crop 47x48+1+0 -gravity west -background magenta -extent 48x48 wq.bmp

cp -f bn.bmp 1.bmp
magick 1.bmp -crop 47x48+1+0 -gravity west -background magenta -extent 48x48 bn.bmp
cp -f wn.bmp 1.bmp
magick 1.bmp -crop 47x48+1+0 -gravity west -background magenta -extent 48x48 wn.bmp

cp -f bb.bmp 1.bmp
magick 1.bmp -crop 47x48+1+0 -gravity west -background magenta -extent 48x48 bb.bmp
cp -f wb.bmp 1.bmp
magick 1.bmp -crop 47x48+1+0 -gravity west -background magenta -extent 48x48 wb.bmp

exit 0

mv wb.bmp backup-wb.bmp
magick backup-wb.bmp -crop 48x44+0+4 aux-wb.bmp  
magick aux-wb.bmp -bordercolor magenta -border 0x2 wb.bmp

mv wp.bmp backup-wp.bmp
magick backup-wp.bmp -crop 48x46+0+2 aux-wp.bmp  
magick aux-wp.bmp -bordercolor magenta -border 0x1 wp.bmp

mv bb.bmp backup-bb.bmp
magick backup-bb.bmp -crop 48x44+0+4 aux-bb.bmp  
magick aux-bb.bmp -bordercolor magenta -border 0x2 bb.bmp

mv bp.bmp backup-bp.bmp
magick backup-bp.bmp -crop 48x46+0+2 aux-bp.bmp  
magick aux-bp.bmp -bordercolor magenta -border 0x1 bp.bmp
