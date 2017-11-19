#!/bin/bash
# Start the capture video web server and the plate license identifir system

UPADD="http://localhost:8081"
COUNTRY="br"
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -s|--stream)
    STREAM="$2"
    shift # past argument
    shift # past value
    ;;
    -ua|--uploadaddress)
    UPADD="$2"
    shift # past argument
    shift # past value
    ;;
    -c|--country)
    COUNTRY="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo "STREAM     = ${STREAM}"
echo "UPLOAD ADDRESS    = ${UPADD}"
echo "COUNTRY    = ${COUNTRY}"
if ( [ -z "$STREAM" ] ); then
    echo "Insira os argumentos de execução para o endereço de stream e/ou upload"
    echo "ex: ./start.sh --stream http://localhost:8080"
    if ( [  -z "$UPADD" ]); then
        echo "ex: ./start.sh -s http://localhost:8080 -ua http://localhost:8081"
        if ( [  -z "$COUNTRY" ]); then
        echo "ex: ./start.sh -s http://localhost:8080 -ua http://localhost:8081 -c br"
    fi
    fi
    exit 1;
fi

echo "[daemon]

; Declare each stream on a separate line
; each unique stream should be defined as stream = [url]

stream = $STREAM

site_id = localhost
country = $COUNTRY

store_plates = 1
store_plates_location = ./plates/

; upload address is the destination to POST to
upload_data = 1
upload_address = $UPADD
" > ./alprd.conf

killbg() {
        for p in $pids; do
                kill -9 -$(ps -o pgid= $p | grep -o '[0-9]*');
        done
}
trap killbg EXIT SIGINT
pids=()
alprd -f --config ./ &>/dev/null &
pids+=($!)
echo "ALPRD STARTED"
if ([ "$STREAM "=~"localhost" ] ); then
    ffmpeg -f video4linux2 -i /dev/video0 -r 30 -s 640x480 -f mjpeg -qscale 5 - 2>/dev/null | streameye &>/dev/null &
    pids+=($!)
    echo "STREAMEYE STARTED"
fi
echo "Placas encontradas:"
node index.js



