#!/usr/bin/bash

# Must be in the directory to prepare

# simplify file extensions
for i in *.jpeg; do
  mv -v "$i" "${i%.jpeg}.jpg"
done

for i in *.JPG; do
  mv -v "$i" "${i%.JPG}.jpg"
done


for i in *.jpg; do
  printf "$i\n"
  convert $i -format jpg -unsharp 0.25x0.25+8+0.065 -dither None -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip -thumbnail "1920x1080" ${i/.jpg/-resized.jpg}
  convert $i -format jpg -unsharp 0.25x0.25+8+0.065 -dither None -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip -thumbnail "250x250" ${i/.jpg/-thumb.jpg}
  rm $i
done
