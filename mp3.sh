#!/bin/bash

HOST=''
for id in {16..30};
do
    echo "start $id"
    URL=''
    IN=`curl -s 'https://'$HOST'?id='$id'&player=mp' |sed -n 170p `
    echo $IN
    IFS='*' read -ra ADDR <<< "$IN"
    for i in "${ADDR[@]}"; do
        if [ "$i" -eq "$i" ] 2>/dev/null
        then
            URL+=$(printf \\$(printf '%03o' $i))
        fi
    done
    echo $URL
    curl -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -s  $URL > $(printf '%003d' $id).mp3
    sleep 30
done
