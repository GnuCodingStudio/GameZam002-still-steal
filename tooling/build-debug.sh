EXPORT_PATH=".release/"

cd ..
mkdir $EXPORT_PATH
cd $EXPORT_PATH

/Applications/Godot.app/Contents/MacOS/Godot --headless --path ../ --export-debug "StillSteal-dmg"

