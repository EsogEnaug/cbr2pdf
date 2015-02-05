#!/bin/bash
 
#Depende de:
# - Unrar
# - Sam2p o ImageMagik
# - Pdftk
#En debian se instalan con:
# aptget install unrar sam2p imagemagik pdftk
 
 
mkdir ./temp
 
#Cambiamos " " por "_"
for fichero in *.cbr; do
unrar e $fichero ./temp
for f in ./temp/*; do
g=`echo $f | sed 's/ /_/g'`
##echo "$f will be renamed as $g"
mv "$f" "$g"
done
# Pasarmos el nombre del archivo a minusculas
for f in ./temp/*; do
g=`echo "$f" | tr '[:upper:]' '[:lower:]'`
# Si el nuevo nombre es diferente cambiamos el nombre
if [ $f != $g ]; then
mv "$f" "$g"
fi
done
# Pasar a PDF
for f in ./temp/*; do
#Comentar y descomentar para elegir entre sam2p o convert
#convert $f $f.pdf
sam2p $f PDF: $f.pdf
done
rm ./temp/*.jpg
pdftk ./temp/*.pdf output $fichero.pdf
rm ./temp/*.pdf
done 
