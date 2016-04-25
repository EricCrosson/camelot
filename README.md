Camelot
=======

[![Build Status](https://travis-ci.org/stormosson/camelot.svg?branch=develop)](https://travis-ci.org/stormosson/camelot)

Overview
--------

Objective:

> Promela Models for Distributed Programs Specify and verify the correctness of
> at least four different distributed algorithms using Promela language and the
> SPIN model checker.

This assignment is from the [Spring 2012 Final Project list].

Verified Algorithms
-------------------

- [Token Ring]
- [Lamport]
- [Ricart and Agrawala]

Dependencies
------------

-   make
-   cmake
-   [spin]

See [build instructions].

  [build instructions]: https://github.com/stormosson/camelot/tree/master/src
  [Spring 2012 Final Project list]: http://users.ece.utexas.edu/~garg/sp16-proj.html
  [spin]: http://spinroot.com/spin/Man/README.html
  [Lamport]: http://users.ece.utexas.edu/~garg/dist1/lecdist/slides/l6-mutex/slide.pdf
  [Token Ring]: https://en.m.wikipedia.org/wiki/Token_ring
  [Ricart and Agrawala]: https://en.m.wikipedia.org/wiki/Ricart%E2%80%93Agrawala_algorithm
