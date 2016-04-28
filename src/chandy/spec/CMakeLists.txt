cmake_minimum_required (VERSION 3.0.2)

project(chandy C)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})

SET (ARGS "-DN=4" CACHE STRING "Compile-time arguments passed to spin")

file(GLOB chandy-srcs "*.pml")
make_binaries (${chandy-srcs})
