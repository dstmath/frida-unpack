echo "Usage: ./inject.sh packageName xx.js"

frida -U -f $1 -l $2 --no-pause