#!/bin/bash

trap "exit" TERM

pip3 install -r requirements.txt
pip3 install -e .
cd hy3dgen/texgen/custom_rasterizer
python3.11 setup.py install
cd ../../..
cd hy3dgen/texgen/differentiable_renderer
python3.11 setup.py install
cd ../../..

runManager() {
    echo "запуск Hunyuan3D-2"
    python3.11 api_server.py --host 0.0.0.0 --port 8080 &
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
