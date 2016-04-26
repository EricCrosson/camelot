Documentation Deliverables
==========================

The assignment calls for a [term paper] and a [presentation].

> The term paper will be due on April 28. It should be approximately 4 pages
> (excluding references), typed and double spaced. The paper should have an
> abstract, introduction, description of the project, various design
> alternatives considered during implmentation, performance results and
> conclusions. You must acknowledge any software that you download and use for
> your project. The paper should clearly identify which portions of your
> software project have been written by you (or modified by you).

The [term paper] was written in [LaTeX], for its [obvious advantages]. The
[presentation] was also typset with LaTeX, using [beamer]. If you desire to
build these documents yourself, follow the [Setup] and then [Build]
instructions. To build the [promela models] for yourself, follow the
[relevant build instructions].


Setup build environment
=======================

This project uses [docker] to encapsulate a functional build environment. More
information is available from [dockerhub]. This page also contains information
on a manual setup.


Prebuilt environment
--------------------

[Install docker]. The following code will pull down the build environment, mount
your locally cloned version of this repository, and give you a shell in the
docker container.

    docker pull hamroctopus/latex-cmake
    docker run -it -v </path/to/local/repo>:/data hamroctopus/latex-cmake


Navigate to `/data/doc/` and proceed to the [build instructions].


Manual environment
------------------

Install the following dependencies

-     make
-     cmake
-     texlive


Build Instructions
==================

To build a pdf, execute the following from inside either `presentation` or `report`

    mkdir build
    cd build
    CXX=$(which gcc) cmake ..
    make


Build clean
-----------

    rm -rf build


  [term paper]: https://github.com/stormosson/camelot/tree/deliverables/report.pdf
  [presentation]: https://github.com/stormosson/camelot/tree/deliverables/presentation.pdf
  [beamer]: https://bitbucket.org/rivanvx/beamer/wiki/Home
  [LaTeX]: https://www.latex-project.org/
  [obvious advantages]: http://nitens.org/taraborelli/latex
  [docker]: https://www.docker.com/
  [dockerhub]: https://hub.docker.com/r/hamroctopus/latex-cmake/
  [Install docker]: https://docs.docker.com/engine/installation/
  [Setup]: #setup-build-environment
  [Build]: #build-instructions
  [build instructions]: #build-instructions
  [promela models]: ../src
  [relevant build instructions]: ../src/README.md
