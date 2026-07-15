#!/bin/bash

FOLDER="./wallpapers/"
OUTPUT="./42-wallpapers.xml"

if [ ! -d "$FOLDER" ]; then
    echo "dossier wallpapers n'existe pas :("
    exit 1;
fi

{
    echo '<?xml version="1.0" encoding="UTF-8"?>'
    echo '<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">'
    echo '<wallpapers>'

    for file in "$FOLDER"/*; do
        path=$(realpath "$file")
        name=$(basename "$file")
        base="${name%.*}"

        if [[ "$name" == *"-dark"* ]]; then
            continue
        fi


        darkname="${base}-dark.png"
        darkpath=$"$FOLDER/$darkname"


        echo "  <wallpaper>"
        echo "    <name>"$name"</name>"
        echo "    <filename>"$path"</filename>"
        if [ -f "$darkpath" ]; then
            dark_realpath=$(realpath $darkpath)
            echo "    <filename-dark>"$dark_realpath"</filename-dark>"
        fi
        echo "    <options>zoom</options>"
        echo "  </wallpaper>"
        echo ""
    done
    echo '</wallpapers>'

} > "$OUTPUT"

echo "To finish the install, this script might need sudo to copy the .xml file to your background properties folder (Y/n)..."
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    sudo cp 42-wallpapers.xml /usr/share/gnome-background-properties;
    rm 42-wallpapers.xml
    echo "Installed."
else
    continue
fi
    rm 42-wallpapers.xml
    echo "bye ! :D"