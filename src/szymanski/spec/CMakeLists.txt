cmake_minimum_required (VERSION 3.0.2)

project(szymanski)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})

SET (ARGS "-E-I../lib/ -L" CACHE STRING "Compile-time arguments passed to spin")

file(GLOB szymanski-srcs "*.pml")
make_binaries (${szymanski-srcs})
