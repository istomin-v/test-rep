#!/bin/bash

trap "exit" TERM

runManager() {
    echo "запуск Hunyuan3D-2"
    python3.11 api_server.py --host 0.0.0.0 --port $HUNYUAN_PORT &
    wait $!
}

runStub() {
    echo "запуск заглушку"
    while :
    do
        sleep 1
    done
}

if $IS_RUN_STUB; then
    runStub;
else
    runManager;
fi
