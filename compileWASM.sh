#!/bin/bash

# add exported C/C++ functions here
CPP_FUNCS="[
 '_malloc',
 '_free',
 '_grayScale',
 '_brighten',
 '_invert',
 '_noise',
 '_multiFilter',
 '_multiFilterFloat',
 '_sobelFilter',
 '_convFilter'
]" 

echo "compiling C++ to WASM ..."
emcc -o ./lib/webdsp_c.js ./cpp/webdsp.cpp -lm -O3 -s WASM=1 \
-s EXPORTED_FUNCTIONS="$CPP_FUNCS" \
-s ALLOW_MEMORY_GROWTH=1 \

sed -i.bak 's/else{doRun()}/&script.dispatchEvent(doneEvent);/' lib/webdsp_c.js

rm lib/*.bak
