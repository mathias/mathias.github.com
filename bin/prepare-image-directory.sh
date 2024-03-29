#!/usr/bin/bash

# Must be in the directory to prepare

# fix up file extensions
declare -a Extensions=(".JPEG" ".JPG" ".jpeg" )

for ext in ${Extensions[@]}; do
  echo "Moving $ext files"
  for i in *$ext; do
    new=$(echo $i | sed -e "s/\\$ext/.jpg/")
    mv -v "$i" "$new"
  done
done

for i in *.jpg; do
  printf "$i\n"
  convert $i -format jpg -unsharp 0.25x0.25+8+0.065 -dither None -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip -thumbnail "1920x1080" ${i/.jpg/-resized.jpg}
  convert $i -format jpg -unsharp 0.25x0.25+8+0.065 -dither None -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip -thumbnail "250x250" ${i/.jpg/-thumb.jpg}
  rm $i
done
