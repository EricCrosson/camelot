Build instructions
==================

To build all promela models, execute the following from inside this directory

    mkdir build
    cd build
    cmake ..
    make


Binaries will be placed in the `build/bin` directory.


Pass custom flags to spin
-------------------------

    mkdir build
    cd build
    cmake -DARGS:STRING="-N 50"
    make


which is unfortunately verbose, so shout if you know a cleaner way.


Build clean
===========

    rm -rf build
