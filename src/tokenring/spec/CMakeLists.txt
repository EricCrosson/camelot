cmake_minimum_required (VERSION 3.0.2)

project(tokenring)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})

SET (ARGS "-DN=10" CACHE STRING "Compile-time arguments passed to spin")

file(GLOB tokenring-srcs "*.pml")
make_binaries (${tokenring-srcs})
