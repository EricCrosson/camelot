Setup build environment
=======================

This project uses [docker] to encapsulate a functional build environment. More
information is available from [dockerhub]. This page also contains information
on a manual setup.


Prebuilt environment
====================

[Install docker]. The following code will pull down the build environment, mount
your locally cloned version of this repository, and give you a shell in the
docker container.

    docker pull hamroctopus/camelot
    docker run -it -v </path/to/local/repo>:/data camelot


Navigate to `/data/src/` and proceed to the build instructions.

    mkdir build
    cd build
    cmake ..
    make

Binaries will be placed in the `build/bin` directory.


Manual environment setup
========================

Install the following dependencies

-   make
-   cmake >3.0.2
-   [spin]
-   bison
-   gcc
-   g++


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
-----------

    rm -rf build


  [docker]: https://www.docker.com/
  [dockerhub]: https://hub.docker.com/r/hamroctopus/camelot/
  [Install docker]: https://docs.docker.com/engine/installation/
  [spin]: http://spinroot.com/spin/Man/README.html
