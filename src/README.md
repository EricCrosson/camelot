Reproducible Research
=====================

What is Reproducible Research? [Hothorn, Held and Friede] offer the following
possible definition

> a piece of reproducible research is an article that provides readers with all
> the materials that are needed to produce the same results as described in the
> publication

Consisting of more than methodology and code, _reproducible research_ contains
methodology, code, parameters, and a build environment. This information permits
other humans and even [machines] to confirm the published results. To reproduce
some research of your own follow the [Setup] and then [Build] instructions. To
build the associated [findings documents] see the [relevant build instructions].


Setup build environment
=======================

This project uses [docker] to encapsulate a functional build environment. More
information is available from [dockerhub]. This page also contains information
on a [manual setup].


Prebuilt environment
--------------------

[Install docker]. Executing the following code from in this directory will pull
down the build environment, mount your current working directory, and build the
cmake project

    docker run -tv $(pwd):/data hamroctopus/spin


Binaries will be placed in the `build/bin` directory.


Manual environment
------------------

Install the following dependencies

-   make
-   cmake >3.0.2
-   [spin]
-   bison
-   gcc

and proceed to the build instructions.


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
  [dockerhub]: https://hub.docker.com/r/hamroctopus/spin/
  [Install docker]: https://docs.docker.com/engine/installation/
  [spin]: http://spinroot.com/spin/Man/README.html
  [Hothorn, Held and Friede]: https://www.r-project.org/nosvn/conferences/useR-2011/TalkSlides/Contributed/16Aug_1115_FocusI_4-ReportingWorkflows_3-Leha.pdf
  [machines]: https://travis-ci.org/stormosson/camelot/branches
  [Setup]: #setup-build-environment
  [Build]: #build-instructions
  [build instructions]: #build-instructions
  [findings documents]: ../doc
  [relevant build instructions]: ../doc/README.md
  [manual setup]: #manual-environment
